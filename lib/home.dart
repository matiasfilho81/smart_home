import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:smart_home/utils/common.dart';
import 'package:smart_home/utils/consts.dart';

class MyHomePage extends StatefulWidget {
  static String tag = '/home';
  static String umiade = '95%';

  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AppConsts.setWidhtSize(MediaQuery.of(context).size.width);
    AppConsts.setHeightSize(MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: AppConsts.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/plug.png",
              color: Colors.white,
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text('Smart Home'),
            )
          ],
        ),
        backgroundColor: AppConsts.appbarBackgroundColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: setHeight(350),
                  child: dispositivos(),
                ),
                Container(
                  height: setHeight(250),
                  child: sensores(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => modalCreate(context),
        tooltip: 'Adicionar Agenda',
        child: Icon(Icons.add),
      ),
    );
  }

  modalCreate(BuildContext context) {
    var form = GlobalKey<FormState>();
    var titulo = TextEditingController();
    var descricao = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Adicionar novo dispositivo'),
            content: Form(
              key: form,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nome do dispositivo'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Lâmpada da Sala',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: titulo,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Este campo não pode ser vazio.';
                        }
                        return null;
                      },
                    ),
                    Text('Descrição'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '(Opcional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: descricao,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () async {
                  if (form.currentState.validate()) {
                    await Firestore.instance.collection('switch').add({
                      'title': titulo.text,
                      'description': descricao.text,
                      'status': false,
                      'data': Timestamp.now(),
                      'delete': false,
                    });
                    Navigator.of(context).pop();
                  }
                },
                color: Colors.green,
                child: Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dispositivos() {
    Stream<QuerySnapshot> snapshots = Firestore.instance
        .collection('switch')
        .where('delete', isEqualTo: false)
        // .orderBy('data')
        .snapshots();

    return StreamBuilder(
      stream: snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data.documents.length == 0) {
          return Center(
              child: Text(
            'Vazio',
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int i) {
            return cardDispositivos(context, i, snapshot);
          },
        );
      },
    );
  }

  Widget cardDispositivos(BuildContext context, int i, AsyncSnapshot<QuerySnapshot> snapshot) {
    DocumentSnapshot doc = snapshot.data.documents[i];
    Map<String, dynamic> item = doc.data;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        height: setHeight(80),
        child: Card(
          color: item['status'] ? AppConsts.onBottom : AppConsts.offBottom,
          elevation: setHeight(10.0),
          child: Column(
            children: [
              ListTile(
                title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(item['description']),
                leading: IconButton(
                  icon: Icon(
                    Icons.lightbulb,
                    color: item['status'] ? AppConsts.onColor : AppConsts.offColor,
                  ),
                  onPressed: () => doc.reference.updateData({
                    'status': !item['status'],
                  }),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () => doc.reference.updateData({
                    'delete': true,
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sensores() {
    Stream<QuerySnapshot> snap = Firestore.instance.collection('data').snapshots();

    return StreamBuilder(
      stream: snap,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snap.data.documents.length == 0) {
          return Center(
              child: Text(
            'Vazio',
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.builder(
          itemCount: snap.data.documents.length,
          itemBuilder: (BuildContext context, int i) {
            return cardSensores(context, i, snap);
          },
        );
      },
    );
  }

  Widget cardSensores(BuildContext context, int i, AsyncSnapshot<QuerySnapshot> snapshot) {
    DocumentSnapshot doc = snapshot.data.documents[i];
    Map<String, dynamic> item = doc.data;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        height: setHeight(80),
        child: Card(
          elevation: setHeight(10.0),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  "lib/assets/" + item['path'] + ".png",
                ),
                title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(item['valor'] + item['unit']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
