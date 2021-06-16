import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClass {
  void stream() {
    Firestore.instance.collection('switch').snapshots();
  }

  void testFirebase() {
    Firestore.instance.collection('data').getDocuments().then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((doc) {
        print(doc["humidity"]);
      });
    });
  }
}
