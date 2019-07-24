import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
//        crossAxisCount: 2,
        children: new List<Widget>.generate(8, (index) {
          return new GridTile(
            child: new Card(
              color: Colors.blue.shade200,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {_counter++;});
                    },
                    tooltip: 'Increment',
                    //              child: Icon(Icons.add),
                    elevation: 0.7,
                    disabledElevation: .5,
                  ),
                  const SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {
                      setState(() {_counter=0;});
                    },
                    child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 20)
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