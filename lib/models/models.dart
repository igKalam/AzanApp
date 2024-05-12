class PrayerTime {
  String name;
  String time;
  String ikamaTime;
  PrayerTime({required this.ikamaTime, required this.name, required this.time});
  Map<String, dynamic> toJson() {
    return {
      'prayerName': name,
      'time': time,
      'ikama': ikamaTime 
    };
  }
}

enum LogType {
  debug,
  info,
  warning,
  error,
}