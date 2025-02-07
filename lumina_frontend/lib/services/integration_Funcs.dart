import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Integration {
  var db = FirebaseFirestore.instance;

  void addTestData() {
    final testField2 = <String, String> {
      "testField2": "Further SUCCESS!!!!!!"
    };

    db.collection("testCollection2").add(testField2).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void setTestData() {
    
    final testField = <String,String> {
      "testField": "adjacent SUCCESS!!!!!!"
    };
    
    db.collection("testCollection").doc("testDocument").set(testField).onError((e, _) => print ("error $e"));
  }
    //String getTestData() {
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