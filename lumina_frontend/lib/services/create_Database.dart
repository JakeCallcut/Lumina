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

  void createHomeowner() {
    final owner = {
      "firstname" : "Lumina",
      "surname" : "Haven",
      "phoneNumber" : "1234567890",
      "email" : "mrHavensSolution@gmail.com",
      "password" : "ShiningL1ght",
      "topHouseId" : "gogPwWrvOuUeNVWNHsrs",
      "hasGoolgeLogin" : false
    };
    db.collection("Homeowner").add(owner).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
    
  }

  void createHousehold() {
    final houseData = <String,dynamic>{
      
    }; 
    final homeDetails = {
      "addressOrNum" : "home1",
      "inviteCode" : "ABCDEF"
    };
    final settings = {
      "budget" : 0,
      "darkMode" : false,
      "notifications" : true
    };
    houseData["Home Details"] = homeDetails;
    houseData["Settings"] = settings;
    
    db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").add(houseData).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }
  
  void createResident() {
      final resident = {
      "firstname" : "Old",
      "surname" : "Person",
      "phoneNumber" : "123123123",
      "email" : "needscare24@gmail.com",
      "password" : "Sos0Old97",
      "hasGoolgeLogin" : true
    };
    db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Residents").add(resident).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createRooms() {
    final room = {
      "Room Name" : "Living room"
    };
    db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Rooms").add(room).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createEnergy() {
    final usageDetails = <String,dynamic>{
      
    }; 
    final used = {
      "price" : 2.75,
      "amount" : 5.6
    };
    final saved = {
      "worth" : 0.66,
      "unused" : 2.31

    };
    usageDetails["Used"] = used;
    usageDetails["Saved"] = saved;

    db.collection("Energy Usage").add(usageDetails).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }
}