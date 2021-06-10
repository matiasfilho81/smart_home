import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/utils/common.dart';
import 'package:smart_home/utils/consts.dart';

class MyHomePage extends StatelessWidget {
  static String tag = '/home';
  static String humidade = '95%';

  // static String humidity;
  @override
  Widget build(BuildContext context) {
    AppConsts.setWidhtSize(MediaQuery.of(context).size.width);
    AppConsts.setHeightSize(MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: Text("Smart House"),
        backgroundColor: AppConsts.primaryColorOpacity50,
      ),
      body: Column(
        children: [
          Container(
            height: setHeight(400),
            child: sensores(),
          ),
          monitor(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var myData = {'description': "Quarto", 'status': true};

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
              height: setHeight(64.0),
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppConsts.black),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color:
                      data['status'] ? AppConsts.textOnPrimary : AppConsts.primaryColorOpacity50),
              child: Center(child: Text(data['description'])),
            );
          },
        );
      },
    );
  }

  Widget monitor() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        child: Card(
          elevation: setHeight(20.0),
          child: Column(
            children: [
              Divider(),
              ListTile(
                title: Text('Umidade do Ar', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('95%'),
                leading: Icon(
                  Icons.select_all,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
