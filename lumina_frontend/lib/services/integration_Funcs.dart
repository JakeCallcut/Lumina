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
    //<String, String> getTestData() {
      //final testRef = db.collection("testCollection");
      //final query = testRef.where("testField", isEqualTo: "Success!");
      
      //final docRef = db.collection("testCollection").doc("testDocument");
      //docRef.get().then(
        //(DocumentSnapshot doc) {
        //  final data = doc.data() as Map<String, dynamic>;
        //  print(data);
        //  return data;
        //  // ...
        //},
       // onError: (e) => print("Error getting document: $e"),
      //);
      //return "";


    //}
}