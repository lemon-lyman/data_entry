import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  globals.gahbage = directory.path;
  return directory.path;
}

Future<File> getFile(fileName) async {
  final path = await _localPath;
  return File('$path/' + fileName);
}

Future<File> writeDate(String date) async {
  final file = await getFile('login_time.txt');
  return file.writeAsString(date);
}

Future<DateTime> readDate() async {
  try {
    final file = await getFile('login_time.txt');
    String contents = await file.readAsString();
    return DateTime.parse(contents);
  }catch (e) {
//    return 0;
  var a = 4;
  }
}

Future<void> writeHotStats(List<int> hotStats, String day) async {
  final file = await getFile(day);
  file.writeAsBytes(hotStats);
}

Future<List<int>> readHotStats(String day) async {
  final file = await getFile(day);
  List<int> hotStats = await file.readAsBytes();
  return hotStats;
}

Future<int> append2Log(List<int> completedDay) async {
  final file = await getFile('Log.csv');
  List<List<int>> wrappedDay = [completedDay];
  String formattedDay = const ListToCsvConverter().convert(wrappedDay);
  final path = await _localPath;
  if (FileSystemEntity.typeSync('$path/Log.csv') != FileSystemEntityType.notFound) {
    file.writeAsString(formattedDay, mode: FileMode.append);
  } else {
    file.writeAsString(formattedDay);
  }

  return 0;
}

bool isOvernight(DateTime oldTime, DateTime newTime) {
  var demarcTime = DateTime.utc(oldTime.year, oldTime.month, oldTime.day, 4, 0, 0);
  if (oldTime.isAfter(demarcTime)) {
    demarcTime =  demarcTime.add(new Duration(days: 1));
  }
  if (newTime.isAfter(demarcTime)) {
    return true;
  } else {
    return false;
  }
}

void updateStreaks(List<int> stats, List<int> streaks){
  for (var i = 0; i < globals.streaks.length; i++;) {
    if (globals.streaks_type[i]==0) { // Negative Streak
      if (globals.todayStats[i] > 0) {
        globals.streaks[i] = 0;
      } else {
        globals.streaks[i]++;
      }
    } else { // Positive Streak
      if (globals.todayStats[i] > 0) {
        globals.streaks[i]++;
      } else {
        globals.streaks[i] = 0;
      }
    }
  }
  writeHotStats(globals.streaks, 'streaks');
}

Future<void> main() async {

  globals.newLoginTime = DateTime.now();
  globals.oldLoginTime = await readDate();
  globals.overnightFlag = isOvernight(globals.oldLoginTime, globals.newLoginTime);
  writeDate(globals.newLoginTime.toString());

  final path = await _localPath;

  if (FileSystemEntity.typeSync('$path/today') != FileSystemEntityType.notFound) {
    globals.todayStats = await readHotStats('today');
  } else {
    globals.todayStats = [0, 0, 0, 0, 0, 0, 0, 0];
  }
  if (FileSystemEntity.typeSync('$path/yesterday') != FileSystemEntityType.notFound) {
    globals.yesterdayStats = await readHotStats('yesterday');
  } else {
    globals.yesterdayStats = [0, 0, 0, 0, 0, 0, 0, 0];
  }
  if (FileSystemEntity.typeSync('$path/streaks') != FileSystemEntityType.notFound) {
    globals.streaks = await readHotStats('streaks');
  } else {
    globals.streaks = [0, 0, 0, 0, 0, 0, 0, 0];
  }

  if (isOvernight(globals.oldLoginTime, globals.newLoginTime)) {
    updateStreaks(globals.todayStats, globals.streaks);
    append2Log(globals.yesterdayStats);
    globals.yesterdayStats = await readHotStats('today');
    globals.todayStats = [0, 0, 0, 0, 0, 0, 0, 0];
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const num_rows = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(DateFormat('MM/dd H:m').format(globals.oldLoginTime).toString() + ' ' + DateFormat('MM/dd H:m').format(globals.newLoginTime).toString()),
        actions: <Widget>[      // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed:  (){}),
        ],                      // ... to here.
      ),

      body: new ListView(
//        padding: const EdgeInsets.all(8.0),
        children: new List<Widget>.generate(num_rows, (index) {
          return new GridTile(
            child: new Container(
                color: Colors.blue.shade200,
                height: 89.5,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: new RawMaterialButton(
                          shape: new CircleBorder(),
                          elevation: 0.0,
                          child: Icon(Icons.remove_circle_outline),
                          onPressed: (){setState((){globals.todayStats[index]--;
                          writeHotStats(globals.todayStats, 'today');});},
                        )
                      ),
                    ),

                    Expanded(
                      child: Text(
                        globals.todayStats[index].toString(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: 200.0,
                          height: 200.0,
                          child: new RawMaterialButton(
                            shape: new CircleBorder(),
                            elevation: 0.0,
                            child: Icon(Icons.add_circle_outline),
                            onPressed: (){setState((){globals.todayStats[index]++;
                            writeHotStats(globals.todayStats, 'today');});},
                          )
                      ),
                    ),
                    Expanded(
                      child: Text(
                        globals.streaks[index].toString(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ],
                ),
          ),
          );



        }),
      ),
    );
  }
}
