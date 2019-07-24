import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';

void main() {
  globals.login_time = DateTime.now(); // get login time
//  read last login time
//  if demarcation time was crossed:
//      old data = read(new)
//      new = blank
//  else
//      old = read(old)
//      new = read(new)
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
//void go2yesterday() {
//  const num_rows = 8;
//  var count_list = [0, 0, 0, 0, 0, 0, 0, 0];
//  var now = DateTime.now();
//  Navigator.of(context).push(
//    MaterialPageRoute<void>(
//      builder: (BuildContext context) {
//        return Scaffold(
//
//          appBar: AppBar(
//            title: Text(now.month.toString() + '/' + now.day.toString()),
////        title: Text(new DateFormat('EEE, MM/DD').format()),
//            actions: <Widget>[      // Add 3 lines from here...
//              IconButton(icon: Icon(Icons.list), onPressed: go2yesterday),
//            ],                      // ... to here.
//          ),
//
//          body: new ListView(
////        padding: const EdgeInsets.all(8.0),
//            children: new List<Widget>.generate(num_rows, (index) {
//              return new GridTile(
//                child: new Container(
//                  color: Colors.blue.shade200,
//                  height: 89.5,
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//
//                      Expanded(
//                        child: Container(
//                            width: 200.0,
//                            height: 200.0,
//                            child: new RawMaterialButton(
//                              shape: new CircleBorder(),
//                              elevation: 0.0,
//                              child: Icon(Icons.remove_circle_outline),
//                              onPressed: (){setState((){count_list[index]--;});},
//                            )
//                        ),
//                      ),
//
//                      Expanded(
//                        child: Text(
//                          count_list[index].toString(),
//                          style: Theme.of(context).textTheme.display1,
//                        ),
//                      ),
//                      Expanded(
//                        child: Container(
//                            width: 200.0,
//                            height: 200.0,
//                            child: new RawMaterialButton(
//                              shape: new CircleBorder(),
//                              elevation: 0.0,
//                              child: Icon(Icons.add_circle_outline),
//                              onPressed: (){setState((){count_list[index]++;});},
//                            )
//                        ),
//                      ),
//                      Expanded(
//                        child: Text(
//                          count_list[index].toString(),
//                          style: Theme.of(context).textTheme.display1,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              );
//
//
//
//            }),
//          ),
//        );
//      }
//    )
//  );
//}

class _MyHomePageState extends State<MyHomePage> {
  static const num_rows = 8;
  var count_list = [0, 0, 0, 0, 0, 0, 0, 0];
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
//        title: Text(now.month.toString() + '/' + now.day.toString() + '/' + now.year.toString()),
//        title: Text(globals.login_time.month.toString() + '/' + globals.login_time.day.toString() + '/' + globals.login_time.year.toString()),
        title: Text(DateFormat('MM/dd/yyyy h:m:s').format(globals.login_time).toString()),
//        title: Text(new DateFormat('EEE, MM/DD').format()),
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
                          onPressed: (){setState((){count_list[index]--;});},
                        )
                      ),
                    ),

                    Expanded(
                      child: Text(
                        count_list[index].toString(),
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
                            onPressed: (){setState((){count_list[index]++;});},
                          )
                      ),
                    ),
                    Expanded(
                      child: Text(
                        count_list[index].toString(),
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
