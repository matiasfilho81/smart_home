import 'package:flutter/material.dart';
import 'package:smart_home/utils/common.dart';
import 'package:smart_home/utils/consts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Smart Home'),
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

  List<bool> _list = [true, false, true, false];
  List<String> _list2 = ["cozinha", "quarto", "geladeira", "fogao"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppConsts.setWidhtSize(MediaQuery.of(context).size.width);
    AppConsts.setHeightSize(MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(children: _buildButtons()),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> listButtons = List.generate(_list.length, (i) {
      return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(setHeight(8)),
              child: Container(
                width: setWidth(300),
                height: setHeight(50),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  color: _list[i] ? AppConsts.yellowBasic : AppConsts.blurple,
                  onPressed: () {
                    setState(() {
                      _list[i] = !_list[i];
                    });
                  },
                  child: Text("${_list2[i]} status: ${_list[i]}"),
                ),
              ),
            ),
          ],
        ),
      );
    });
    return listButtons;
  }
}
