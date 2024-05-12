import 'package:adhan/adhan.dart';
import 'dart:convert';
import '../models/models.dart';
import "git_write.dart";

class Timing {
  GitWrite git = GitWrite();
  late Coordinates myCoordinates;
  late CalculationParameters params;
  late PrayerTimes prayerTimes;

  Timing() {
    myCoordinates = Coordinates(11.82652, 78.94736);
    params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    prayerTimes = PrayerTimes.today(myCoordinates, params);
  }

  List<PrayerTime> getPrayerTimeBasedOnLcation() {    
    List<PrayerTime> prayers = [
      PrayerTime(
          name: "Fajr",
          time:
              "${prayerTimes.fajr.hour}:${_formatMinute(prayerTimes.fajr.minute)}",
          ikamaTime: ""),
      PrayerTime(
          name: "Dhuhr",
          time:
              "${prayerTimes.dhuhr.hour}:${_formatMinute(prayerTimes.dhuhr.minute)}",
          ikamaTime: ""),
      PrayerTime(
          name: "Asr",
          time:
              "${prayerTimes.asr.hour}:${_formatMinute(prayerTimes.asr.minute)}",
          ikamaTime: ""),
      PrayerTime(
          name: "Maghrib",
          time:
              "${prayerTimes.maghrib.hour}:${_formatMinute(prayerTimes.maghrib.minute)}",
          ikamaTime: ""),
      PrayerTime(
          name: "Isha",
          time:
              "${prayerTimes.isha.hour}:${_formatMinute(prayerTimes.isha.minute)}",
          ikamaTime: ""),
    ];
    return prayers;
  }

  String _formatMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  savePrayerToGit(List<PrayerTime> prayerTiles){
   List<Map<String, dynamic>> jsonList = prayerTiles.map((prayerTime) => prayerTime.toJson()).toList();
    git.writeFile({'prayerTimes': jsonList});
  }

  Future<List<PrayerTime>> readPrayerTimeFromGit() async {
  // try {
  //   String decodedContent = await git.readFile();
  //   Map<String, dynamic> jsonData = jsonDecode(decodedContent);
  //   List<dynamic> jsonList = jsonData['prayerTimes'];
  //   final List<PrayerTime> prayerTimes = jsonList.map((json) {
  //     return PrayerTime(
  //       name: json['prayerName'],
  //       time: json['time'],
  //       ikamaTime: json['ikama'],
  //     );
  //   }).toList();

  //   return prayerTimes;
  // } catch (e) {
      List<PrayerTime> prayers = getPrayerTimeBasedOnLcation();
      //savePrayerToGit(prayers);
      return prayers; 
  //}
}

}
