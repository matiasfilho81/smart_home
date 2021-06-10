import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // testar funcionamento
    Firestore.instance.collection('data').getDocuments().then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((doc) {
        print(doc["humidity"]);
      });
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyHomePage.tag,
      routes: {
        MyHomePage.tag: (context) => MyHomePage(),
      },
    );
  }
}
