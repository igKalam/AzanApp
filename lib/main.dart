
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'tiledesign.dart';
import 'services/timing.dart';
import 'models/models.dart';
import 'dataBase/prayer_time_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pray Community'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
  Timing times = Timing();
  PrayerTimeDatabaseHelper pDb = PrayerTimeDatabaseHelper();
  List<PrayerTime> prayers = [];

 @override
void initState() {
  super.initState();
  _loadPrayerTimes(); // Call the async method
}

Future<void> _loadPrayerTimes() async {
  try {
    // final x =  pDb.getAllPrayers();
    // print(x);
    final List<PrayerTime> fetchedPrayers = await times.readPrayerTimeFromGit();    
    setState(() {
      prayers = fetchedPrayers;
      insertParyerInDB();
    });
  } catch (e) {
   // print("Error loading prayer times: $e");
  }
}

  @override
  Widget build(BuildContext context) {    
  return Scaffold(
    appBar: AppBar(        
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max,children: [Expanded(
      child: Text(widget.title),
    ), IconButton(onPressed: (){
        //_loadPrayerTimes();
      }, icon: const Icon(Icons.refresh))],) ,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: prayers.map((e) => TileDesign(prayer: e)).toList(),
      ),
    ),
  );
}

insertParyerInDB(){
for(PrayerTime p in prayers){
      pDb.setPrayer(p.name, p.time, p.ikamaTime);
    }
}
}

class PreLoades{
  PreLoades(){
      initNotifactionPlugin();
  }

  void requestPermissions() async {
  // Request permission for internet access
  //var internetStatus = await Permission..request();
  
  // Request permission for storage usage
  var storageStatus = await Permission.storage.request();

  // Handle permission statuses
  if (storageStatus.isGranted) {
    // Permissions granted, proceed with accessing internet and storage
  } else {
    // Permissions denied, handle accordingly (e.g., show a message to the user)
  }
}

  initNotifactionPlugin() async {
    WidgetsFlutterBinding.ensureInitialized();
  // Initialize the local notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configure the plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}