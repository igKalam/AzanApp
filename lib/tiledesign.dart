import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'models/models.dart';
import 'dataBase/alarm_db.dart';

class TileDesign extends StatefulWidget {
  const TileDesign({super.key, required this.prayer});
  final PrayerTime prayer;

  @override
  State<TileDesign> createState() => _TileDesignState();
}

class _TileDesignState extends State<TileDesign> {
final dbHelper = AlarmDatabaseHelper();
 @override
void initState() {
  super.initState();
  setAlarmTime();
}
int _alarmTime = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      title: Row(
        children: [
          Text(
              widget.prayer.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).primaryColor,
              )
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Azan :"),
              Text(widget.prayer.time)
        ],
      ),
      subtitle:Row(
        children: [
          Text(
                widget.prayer.ikamaTime,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                'Alarm Time:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 8), // Add space between widgets
              Text(
                 _alarmTime > 0 ?  '$_alarmTime' : "Select Time",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                 showPickerNumber(context);
                },  
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(
              begin: 0,
              end: 999,
              )              
        ]),        
        hideHeader: true,
        title: const Text("Select Alarm time"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          dbHelper.setAlarm(widget.prayer.name, value[0] as int);
          setState(() {
            _alarmTime = value[0] as int;
          });
          // _showAlertDialog(context, _alarmTime.toString());
        },
        ).showDialog(context);
  }

  Future<void> _showAlertDialog(BuildContext context, String message ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> setAlarmTime() async {
    Map<String, dynamic>? storedTime = await dbHelper.getAlarmByName(widget.prayer.name);
    if(storedTime != null){
      setState(() {
            _alarmTime = storedTime['time'] as int;
            //_showAlertDialog(context, _alarmTime.toString());
      });
    } else{
        //_showAlertDialog(context, "received stored time as null");
    }   
  }
}