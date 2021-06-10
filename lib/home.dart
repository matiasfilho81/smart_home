import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  static String tag = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart House"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: sensores(),
          ),
          monitor(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var myData = {'description': "teste", 'status': false};

          var collection = Firestore.instance.collection('switch');
          collection
              .add(myData)
              .then((_) => print('Added'))
              .catchError((error) => print('Add failed: $error'));
        },
        tooltip: 'Adicionar Agenda',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget sensores() {
    return StreamBuilder(
      stream: Firestore.instance.collection('switch').snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data.documents.length == 0) {
          return Center(child: Text('Vazio'));
        }

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int i) {
            Map<String, dynamic> data = snapshot.data.documents[i].data;

            return Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Text(data['description'].toString()),
                  Text(data['status'].toString()),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget monitor() {
    return SizedBox(
      child: Card(
        elevation: 20,
        child: Column(
          children: [
            Divider(),
            ListTile(
              title: Text('Sensor de Temperatura:', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('temperatura C'),
              leading: Icon(
                Icons.toys,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
