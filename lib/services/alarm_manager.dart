// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// class AlarmManager{
  
//   Future<void> _scheduleMultipleNotifications(
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//   // Cancel all previously scheduled notifications
//   await flutterLocalNotificationsPlugin.cancelAll();

//   // Define notification details
//   final AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'daily_notification',
//     'Daily Notification',
//     'Scheduled daily notification',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   final NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   // Get today's date
//   final now = tz.TZDateTime.now(tz.local);

//   // Define list of notification times and messages
//   // final List<Map<String, dynamic>> notifications = [
//   //   {'time': Time(5, 30), 'message': 'Good morning! It\'s time to wake up.'},
//   //   {'time': Time(12, 0), 'message': 'Lunch time!'},
//   //   {'time': Time(18, 0), 'message': 'Dinner time!'},
//   // ];

//   // Schedule notifications
//   // for (var notification in notifications) {
//   //   // Set the time for the notification
//   //   final scheduledDate = tz.TZDateTime(
//   //     tz.local,
//   //     now.year,
//   //     now.month,
//   //     now.day,
//   //     notification['time'].hour,
//   //     notification['time'].minute,
//   //   );

//   //   // Schedule the notification
//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     0,
//   //     'Daily Notification',
//   //     notification['message'],
//   //     scheduledDate,
//   //     platformChannelSpecifics,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.absoluteTime,
//   //     matchDateTimeComponents: DateTimeComponents.time,
//   //   );
//   // }
// }
// }