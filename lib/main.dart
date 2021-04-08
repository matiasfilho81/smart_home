import 'package:flutter/material.dart';
import 'package:smart_home/utils/common.dart';
import 'package:smart_home/utils/consts.dart';
import 'package:firebase_core/firebase_core.dart';

// https://www.youtube.com/watch?v=EXp0gq9kGxI

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AppConsts.setWidhtSize(MediaQuery.of(context).size.width);
    AppConsts.setHeightSize(MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          botao("Adiconar", AppConsts.greenBasic, Icons.add),
          botao("Remover", AppConsts.redBasic, Icons.add),
          botao("Editar", AppConsts.yellowBasic, Icons.add),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget botao(String titulo, Color cor, IconData icone) {
    return GestureDetector(
      onTap: () => print(titulo),
      child: Padding(
        padding: EdgeInsets.all(setHeight(8)),
        child: Container(
          width: setHeight(300),
          height: setHeight(70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                titulo,
                style: TextStyle(color: AppConsts.textOnPrimary, fontSize: 30.0),
              ),
              Icon(
                icone,
                color: AppConsts.textOnPrimary,
                size: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
