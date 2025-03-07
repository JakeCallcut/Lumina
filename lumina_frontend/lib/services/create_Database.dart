import 'package:cloud_firestore/cloud_firestore.dart';

class Create {
  var db = FirebaseFirestore.instance;

  void createTopLevelHome() {
    final tLH = {
      "name" : "1st carehome",
      "bLDevices" : ["drone", "fryer"]
    };
    db.collection("Top Level Homes").add(tLH).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createUser() {
    final owner = {
      "firstname" : "Lumina",
      "surname" : "Haven",
      "phoneNumber" : "1234567890",
      "email" : "mrHavensSolution@gmail.com",
      "password" : "ShiningL1ght",
      "topHouseId" : "oFoh7ELw1kJHjuJ6nYrJ",
      "houseHoldId" : "",
      "hasGoogleLogin" : true
    };
       final resident = {
      "firstname" : "Old",
      "surname" : "Person",
      "phoneNumber" : "77644328976",
      "email" : "needsCare247@gmail.com",
      "password" : "50SoOld97",
      "topHouseId" : "oFoh7ELw1kJHjuJ6nYrJ",
      "houseHoldId" : "iPjhMCjaZiBkmygJ0fKo",
      "hasGoogleLogin" : false
    };
    db.collection("User").add(owner).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
    db.collection("User").add(resident).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
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
    
    db.collection("Top Level Homes").doc("oFoh7ELw1kJHjuJ6nYrJ").collection("Household").add(houseData).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createRooms() {
    final room = {
      "Room Name" : "Living room"
    };
    db.collection("Top Level Homes").doc("oFoh7ELw1kJHjuJ6nYrJ").collection("Household").doc("iPjhMCjaZiBkmygJ0fKo").collection("Rooms").add(room).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createEnergy() {

    final usageDetails = <String,dynamic>{
      "price" : 2.75,
      "amount" : 5.6,
      "worth" : 0.66,
      "unused" : 2.31,
      "topHouseId" : "oFoh7ELw1kJHjuJ6nYrJ",
      "houseHoldId" : "iPjhMCjaZiBkmygJ0fKo"
    };
    final engin = <String, int>{};
    engin.update("1", (value) => 12, ifAbsent: () => 12);
    engin.update("2", (value) => 27, ifAbsent: () => 27);
    final engout = <String, int>{};
    engout.update("1", (value) => 53, ifAbsent: () => 53);
    engout.update("2", (value) => 48, ifAbsent: () => 48);
    usageDetails["monthEnergyIn"] = engin;
    usageDetails["monthEnergyOut"] = engout;
    db.collection("EnergyUsage").add(usageDetails).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }

  void createDevice() {


    final deviceDetails = <String,dynamic>{
      "name" : "Tesla",
      "typeName" : "ECar",
      "imageId" : 2,
      "mainAction" : false
    };
    final actionList = <String, bool>{

    };
    actionList.update("Opendoor", (value) => true, ifAbsent: () => true);
    actionList.update("Heating", (value) => false, ifAbsent: () => false);
    deviceDetails["actionList"] = actionList;

    db.collection("Top Level Homes").doc("oFoh7ELw1kJHjuJ6nYrJ").collection("Household").doc("iPjhMCjaZiBkmygJ0fKo").collection("Rooms").doc("ESzmpAzNOEzqZCvwqaFh").collection("Devices").add(deviceDetails).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  }
}