import 'package:cloud_firestore/cloud_firestore.dart';

class Integration {
  var db = FirebaseFirestore.instance;

  void addTestData() {
    final testField2 = <String, String> {
      "testField2": "Further SUCCESS!!!!!!"
    };

    db.collection("testCollection2").add(testField2).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void testTopLevel() {
    
  }

  void setTestData() {
    
    final testField = <String,String> {
      "testField": "adjacent SUCCESS!!!!!!"
    };
    
    db.collection("testCollection").doc("testDocument").set(testField).onError((e, _) => print ("error $e"));
  }

  void setTestDataSubCollection() {
    
    final testSubField = <String,String> {
      "testSubField": "low level SUCCESS!!!!!!"
    };
    
    db.collection("testCollection").doc("testDocument").collection("testSubCollection").doc("testSubDocument").set(testSubField).onError((e, _) => print ("error $e"));
  }

  void getTestData() {
      //final testRef = db.collection("testCollection");
      //final query = testRef.where("testField", isEqualTo: "Success!");
      
      final docRef = db.collection("Homeowner").doc("vAYUGygxXkiyYZmtMv3I");
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data);

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );

  }

    void getBothResidents() {
      
      final docRef2 = db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Residents").doc("7VJYi9v1v9pstJAix9hr");
      docRef2.get().then(
        (DocumentSnapshot doc) {
          final data2 = doc.data() as Map<String, dynamic>;
          print(data2);

        },
        onError: (e) => print("Error getting document: $e"),
      );

      final docRef3 = db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Residents").doc("w5AqgU2fPFAkjZq7Q9CI");
      docRef3.get().then(
        (DocumentSnapshot doc) {
          final data3 = doc.data() as Map<String, dynamic>;
          print(data3);

        },
        onError: (e) => print("Error getting document: $e"),
      );
  }
}