import 'package:cloud_firestore/cloud_firestore.dart';

class Create {
  var db = FirebaseFirestore.instance;

  //void addCollections() {
   // final setupDoc = <String, String> {
   //   "setup" : "done"
   // };
   // db.collection("Residents").doc("SampleUser").set(setupDoc).onError((e, _) => print ("error $e"));
   // db.collection("Residents").doc("").set(setupDoc).onError((e, _) => print ("error $e"));
   // db.collection("Homeowner").doc("").set(setupDoc).onError((e, _) => print ("error $e"));
   // db.collection("Energy Usage").doc("").set(setupDoc).onError((e, _) => print ("error $e"));
  //}
  void createTopLevelHome() {
    final tLH = {
      "bLDevices" : ["drone", "fryer"]
    };
    db.collection("Top Level Homes").add(tLH).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

}