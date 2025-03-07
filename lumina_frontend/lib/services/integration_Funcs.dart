import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumina_frontend/model/models.dart';

class Integration {
  var db = FirebaseFirestore.instance;

  // void addTestData() {
  //   final testField2 = <String, String> {
  //     "testField2": "Further SUCCESS!!!!!!"
  //   };

  //   db.collection("testCollection2").add(testField2).then((DocumentReference doc) => print('documentSnapshot added with ID: ${doc.id}'));
  // }

  // void testTopLevel() {

  // }

  // void setTestData() {

  //   final testField = <String,String> {
  //     "testField": "adjacent SUCCESS!!!!!!"
  //   };

  //   db.collection("testCollection").doc("testDocument").set(testField).onError((e, _) => print ("error $e"));
  // }

  // void setTestDataSubCollection() {

  //   final testSubField = <String,String> {
  //     "testSubField": "low level SUCCESS!!!!!!"
  //   };

  //   db.collection("testCollection").doc("testDocument").collection("testSubCollection").doc("testSubDocument").set(testSubField).onError((e, _) => print ("error $e"));
  // }

  // void getTestData() {
  //     //final testRef = db.collection("testCollection");
  //     //final query = testRef.where("testField", isEqualTo: "Success!");

  //     final docRef = db.collection("Homeowner").doc("vAYUGygxXkiyYZmtMv3I");
  //     docRef.get().then(
  //       (DocumentSnapshot doc) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         print(data);

  //         // ...
  //       },
  //       onError: (e) => print("Error getting document: $e"),
  //     );

  // }

  //   void getBothResidents() {

  //     final docRef2 = db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Residents").doc("7VJYi9v1v9pstJAix9hr");
  //     docRef2.get().then(
  //       (DocumentSnapshot doc) {
  //         final data2 = doc.data() as Map<String, dynamic>;
  //         print(data2);

  //       },
  //       onError: (e) => print("Error getting document: $e"),
  //     );

  //     final docRef3 = db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6").collection("Residents").doc("w5AqgU2fPFAkjZq7Q9CI");
  //     docRef3.get().then(
  //       (DocumentSnapshot doc) {
  //         final data3 = doc.data() as Map<String, dynamic>;
  //         print(data3);

  //       },
  //       onError: (e) => print("Error getting document: $e"),
  //     );
  // }

  // void getOwnerId() {

  //   //  final owners = db.collection('Homeowner').document(widget.data['Document Id'].toString()).get();
  //   final owners = db.collection('Homeowner').get().then((value) => value.docs.map((e)=> e.id).toList());
  //   print(owners);

  // }

  // void getHousehold() {
  //     final docRefH = db.collection("Top Level Homes").doc("gogPwWrvOuUeNVWNHsrs").collection("Household").doc("RyWdVEdWzHdOotkTK4n6");
  //     docRefH.get().then(
  //       (DocumentSnapshot doc) {
  //         final dataH = doc.data() as Map<String, dynamic>;

  //         print(dataH);

  //       },
  //       onError: (e) => print("Error getting document: $e"),
  //     );
  // }

  // Future<HomeOwner> getHomeOwner(String firstname, String lastname) async {
  //    var querySnapshot =  await db.collection("Homeowner").where("firstname", isEqualTo: firstname)
  //                                                 .where("surname", isEqualTo: lastname).get();
  //     var value;
  //     for (var docSnapshot in querySnapshot.docs)  {
  //       value = docSnapshot.data();
  //     }

  //      print (value['firstname']) ;
  //    HomeOwner h = HomeOwner.basic(value['firstname'],value['surname']);

  //    return h;

  // }
  //   Future<String> getHomeOwner(String firstname, String lastname) async
  // {
  //    var querySnapshot =  await db.collection("Homeowner").where("firstname", isEqualTo: firstname)
  //                                                .where("surname", isEqualTo: lastname).get();
  //     //print("ACG");
  //     String value="";
  //     for (var docSnapshot in querySnapshot.docs)  {
  //       value = docSnapshot.id;
  //      // print ("CG");
  //       //print (value);
  //     }

  //    return value;

  // }

  Future<List<User>> getallUsers() async {
    List<User> users = [];
    try {
      var querySnapshot = await db.collection("Homeowner").get();
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> value = docSnapshot.data();
        User u = User(
            docSnapshot.id,
            value['loginId'],
            value['email'],
            value['password'],
            value['phoneNumber'],
            value['houseCodeId'],
            value['hasGoogleLogin']);
        users.add(u);
      }
    } catch (e) {
      //log error here
      //returns empty list
      return users;
    }

    return users;
  }

  bool addUser(User us) {
    Map<String, dynamic> user = {};
    //uses object data to create new field in the database
    try {
      user["loginId"] = (us.loginId);
      user["firstname"] = (us.firstname);
      user["surname"] = (us.surname);
      user["phoneNumber"] = (us.phoneNumber);
      user["topHouseId"] = (us.houseCodeId);
      user["hasGoogleLogin"] = (us.hasGoogleLogin);
      db.collection("User").add(user);
    } catch (e) {
      return false;
    }

    return true;
  }

  bool updateUser(User us) {
    Map<String, dynamic> owner = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (us.loginId.trim().isNotEmpty) {
        owner["loginId"] = (us.loginId);
      }
      if (us.firstname.trim().isNotEmpty) {
        owner["firstname"] = (us.firstname);
      }
      if (us.surname.trim().isNotEmpty) {
        owner["surname"] = (us.surname);
      }
      if (us.phoneNumber.trim().isNotEmpty) {
        owner["phoneNumber"] = (us.phoneNumber);
      }
      if (us.houseCodeId.trim().isNotEmpty) {
        owner["houseCodeId"] = (us.houseCodeId);
      }
      owner["hasGoogleLogin"] = (us.hasGoogleLogin);
      db.collection("User").doc(us.id).update(owner);
    } catch (e) {
      return false;
    }
    return true;
  }

  // Future<List<TopLevelHome>> getallTopLevelHomes() async {
  //   List<TopLevelHome> topLevelHomes = [];
  //   try {
  //     var querySnapshot = await db.collection("Top Level Homes").get();
  //     for (var docSnapshot in querySnapshot.docs) {
  //       Map<String, dynamic> value = docSnapshot.data();
  //       TopLevelHome tlh = TopLevelHome(docSnapshot.id, value['name'], value['bLDevices']);
  //       topLevelHomes.add(tlh);
  //     }
  //   } catch (e) {
  //     //log error here
  //     //returns empty list
  //     return topLevelHomes;
  //   }
  //   return topLevelHomes;
  // }

 Future<List<TopLevelHome>> getallTopLevelHomes() async {
  List<TopLevelHome> topLevelHomes = [];
  try {
    var querySnapshot = await db.collection("Top Level Homes").get();
    for (var docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> value = docSnapshot.data();
      if (value['name'] != null && value['bLDevices'] != null) {
        List<String> bLDevices = List<String>.from(value['bLDevices']);
        TopLevelHome tlh = TopLevelHome(docSnapshot.id, value['name'], bLDevices);
        topLevelHomes.add(tlh);
      } else {
        print("Missing required fields in document: ${docSnapshot.id}");
      }
    }
  } catch (e) {
    print("Error getting top level homes: $e");
    //log error here
    //returns empty list
    return topLevelHomes;
  }
  return topLevelHomes;
}

  bool addTopLevelHomes(TopLevelHome tlh) {
    Map<String, dynamic> tlhome = {};
    //uses object data to create new field in the database
    try {
      tlhome["name"] = (tlh.name);
      tlhome["bLDevices"] = (tlh.bLDevices);
      db.collection("Top Level Homes").add(tlhome);
    } catch (e) {
      return false;
    }

    return true;
  }

  bool updateTopLevelHome(TopLevelHome tlh) {
    Map<String, dynamic> tlhome = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (tlh.name.trim().isNotEmpty) {
        tlhome["name"] = (tlh.name);
      }
      if (tlh.bLDevices.isNotEmpty) {
        tlhome["bLDevices"] = (tlh.bLDevices);
      }
      db.collection("Top Level Homes").doc(tlh.id).update(tlhome);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<Household>> getHouseholds(String tlhId) async {
    List<Household> households = [];
    try {
      var querySnapshot = await db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .get();
      if (querySnapshot.docs.isEmpty) {
        print("No households found for Top Level Home ID: $tlhId");
      } else {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> value = docSnapshot.data();
          Household home = Household(docSnapshot.id,
              value['Home Details'], value['Settings']);
          households.add(home);
        }
      }
    } catch (e) {
      print("Error getting households: $e");
      //log error here
      //returns empty list
      return households;
    }
    return households;
  }

  bool addHousehold(Household home, String tlhId) {
    Map<String, dynamic> house = {};
    //uses object data to create new field in the database
    try {
      house["Home Details"] = (home.homeDetails);
      house["Settings"] = (home.settings);
      db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .add(house);
    } catch (e) {
      return false;
    }

    return true;
  }

  bool updateHousehold(Household home, String tlhId) {
    Map<String, dynamic> house = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (home.homeDetails.isNotEmpty) {
        house["Home Detais"] = (home.homeDetails);
      }
      if (home.settings.isNotEmpty) {
        house["Settings"] = (home.settings);
      }
      db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .doc(home.id)
          .update(house);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<Room>> getRooms(String tlhId, hId) async {
    List<Room> rooms = [];
    try {
      var querySnapshot = await db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .doc(hId)
          .collection("Rooms")
          .get();
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> value = docSnapshot.data();
        Room room = Room(docSnapshot.id, value['Room Name']);
        rooms.add(room);
      }
    } catch (e) {
      //log error here
      //returns empty list
      return rooms;
    }
    return rooms;
  }

  bool addRoom(Room place, String tlhId, hId) {
    Map<String, dynamic> room = {};
    //uses object data to create new field in the database
    try {
      room["Room Name"] = (place.name);
      db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .doc(hId)
          .collection("Rooms")
          .add(room);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool updateRoom(Room place, String tlhId, hId) {
    Map<String, dynamic> room = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (place.name.trim().isNotEmpty) {
        room["Room Name"] = (place.name);
      }

      db
          .collection("Top Level Homes")
          .doc(tlhId)
          .collection("Household")
          .doc(hId)
          .collection("Residents")
          .doc(place.id)
          .update(room);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<List<EnergyUsage>> getEnergyUsage() async {
    List<EnergyUsage> energys = [];
    try {
      var querySnapshot = await db.collection("EnergyUsage").get();
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> value = docSnapshot.data();
        EnergyUsage energy = EnergyUsage(
            docSnapshot.id,
            value['topHouseId'],
            value['householdId'],
            value['unused'],
            value['worth'],
            value['amount'],
            value['price'],
            value['monthEnergyIn'],
            value['monthEnergyOut']);
        energys.add(energy);
      }
    } catch (e) {
      //log error here
      //returns empty list
      return energys;
    }
    return energys;
  }

  bool addEnergyUsage(EnergyUsage en) {
    Map<String, dynamic> energy = {};
    //uses object data to create new field in the database
    try {
      energy["topHouseId"] = (en.topHouseId);
      energy["householdId"] = (en.householdId);
      energy["unused"] = (en.unused);
      energy["worth"] = (en.worth);
      energy["amount"] = (en.amount);
      energy["price"] = (en.price);
      energy["monthEnergyIn"] = (en.monthEnergyIn);
      energy["monthEnergyOut"] = (en.monthEnergyOut);
      db.collection("Energy Usage").add(energy);
    } catch (e) {
      return false;
    }

    return true;
  }

  bool updateEnergyUsage(EnergyUsage en)  {
    Map<String, dynamic> energy = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (en.topHouseId.trim().isNotEmpty) {energy["topHouseId"] = (en.topHouseId);}
      if (en.householdId.trim().isNotEmpty) {energy["householdId"] = (en.householdId);}
      energy["unused"] = (en.unused);
      energy["worth"] = (en.worth);
      energy["amount"] = (en.amount);
      energy["price"] = (en.price);
      if (en.monthEnergyIn.isNotEmpty) {energy["monthEnergyIn"] = (en.monthEnergyIn);}
      if (en.monthEnergyOut.isNotEmpty) {energy["monthEnergyOut"] = (en.monthEnergyOut);}
      db.collection("Energy Usage").doc(en.id).update(energy);
    }
    catch(e) {
      return false;
    }
    return true;
  }

  Future<List<Device>> getDevices() async {
    List<Device> devices = [];
    try {
      var querySnapshot = await db.collection("Devices").get();
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> value = docSnapshot.data();
        Device device = Device(
            docSnapshot.id,
            value['deviceName'],
            value['typeName'],
            value['imageId'],
            value['mainAction'],
            value['actionList']);
        devices.add(device);
      }
    } catch (e) {
      //log error here
      //returns empty list
      return devices;
    }
    return devices;
  }
}
