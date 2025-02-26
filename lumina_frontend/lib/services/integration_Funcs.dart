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

  Future<List<HomeOwner>> getallHomeOwners() async {
    List<HomeOwner> homeowners = [];
    try {
      var querySnapshot =  await db.collection("Homeowner").get();
      for (var docSnapshot in querySnapshot.docs)  {
        Map<String, dynamic> value = docSnapshot.data();
        HomeOwner h = HomeOwner(docSnapshot.id, value['firstname'], value['surname'], value['email'], value['password'], value['phoneNumber'], value['topHouseId'], value['hasGoogleLogin']);
        homeowners.add(h);
      }
    }    
    catch(e) {
      //log error here
      //returns empty list
      return homeowners;
    }

    return homeowners;
  }

  bool addHomeowner(HomeOwner ho)  {
    Map<String, dynamic> owner = {};
    //uses object data to create new field in the database
    try {
      owner["firstname"] = (ho.firstname);
      owner["surname"] = (ho.surname);
      owner["email"] = (ho.email);
      owner["password"] = (ho.password);
      owner["phoneNumber"] = (ho.phoneNumber);
      owner["topHouseId"] = (ho.topHouseId);
      owner["hasGoogleLogin"] = (ho.hasGoogleLogin);
      db.collection("Homeowner").add(owner);
    }
    catch(e) {
      return false;
    }

    return true;
  }

  bool updateHomeowner(HomeOwner ho)  {
    Map<String, dynamic> owner = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (ho.firstname.trim().isNotEmpty) {owner["firstname"] = (ho.firstname);}
      if (ho.surname.trim().isNotEmpty) {owner["surname"] = (ho.surname);}
      if (ho.email.trim().isNotEmpty) {owner["email"] = (ho.email);}
      if (ho.password.trim().isNotEmpty) {owner["password"] = (ho.password);}
      if (ho.phoneNumber.trim().isNotEmpty) {owner["phoneNumber"] = (ho.phoneNumber);}
      if (ho.topHouseId.trim().isNotEmpty) {owner["topHouseId"] = (ho.topHouseId);}
      owner["hasGoogleLogin"] = (ho.hasGoogleLogin);
      db.collection("Homeowner").doc(ho.id).update(owner);
    }
    catch(e) {
      return false;
    }       
    return true;
  }




  Future<List<TopLevelHome>> getallTopLevelHomes() async {
    List<TopLevelHome> topLevelHomes = [];
    try {
      var querySnapshot =  await db.collection("Top Level Homes").get();
      for (var docSnapshot in querySnapshot.docs)  {
        Map<String, dynamic> value = docSnapshot.data();
        TopLevelHome tlh = TopLevelHome(docSnapshot.id, value['name'], value['bLDevices']);
        topLevelHomes.add(tlh);
      }
    }    
    catch(e) {
      //log error here
      //returns empty list
      return topLevelHomes;
    }
    return topLevelHomes;
  }

  bool addTopLevelHomes(TopLevelHome tlh)  {
    Map<String, dynamic> tlhome = {};
    //uses object data to create new field in the database
    try {
      tlhome["name"] = (tlh.name);
      tlhome["bLDevices"] = (tlh.bLDevices);
      db.collection("Top Level Homes").add(tlhome);
    }
    catch(e) {
      return false;
    }

    return true;
  }

  bool updateTopLevelHome(TopLevelHome tlh)  {
    Map<String, dynamic> tlhome = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (tlh.name.trim().isNotEmpty) {tlhome["name"] = (tlh.name);}
      if (tlh.bLDevices.isNotEmpty) {tlhome["bLDevices"] = (tlh.bLDevices);}
      db.collection("Top Level Homes").doc(tlh.id).update(tlhome);
    }
    catch(e) {
      return false;
    }       
    return true;
  }

  Future<List<Household>> getHouseholds(String tlhId) async {
    List<Household> households = [];
    try {
      var querySnapshot =  await db.collection("Top Level Homes").doc(tlhId).collection("Household").get();
      for (var docSnapshot in querySnapshot.docs)  {
        Map<String, dynamic> value = docSnapshot.data();
        Household home = Household(docSnapshot.id, value['name'], value['Home Details'], value['Settings']);
        households.add(home);
      }
    }    
    catch(e) {
      //log error here
      //returns empty list
      return households;
    }
    return households;
  }

  bool addHousehold(Household home, String tlhId)  {
    Map<String, dynamic> house = {};
    //uses object data to create new field in the database
    try {
      house["name"] = (home.name);
      house["Home Details"] = (home.homeDetails);
      house["Settings"] = (home.settings);
      db.collection("Top Level Homes").doc(tlhId).collection("Household").add(house);
    }
    catch(e) {
      return false;
    }

    return true;
  }

  bool updateHousehold(Household home, String tlhId)  {
    Map<String, dynamic> house = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (home.name.trim().isNotEmpty) {house["name"] = (home.name);}
      if (home.homeDetails.isNotEmpty) {house["Home Detais"] = (home.homeDetails);}
      if (home.settings.isNotEmpty) {house["bLDevices"] = (home.settings);}
      db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(home.id).update(house);
    }
    catch(e) {
      return false;
    }       
    return true;
  }

  Future<List<Resident>> getResidents(String tlhId, hId) async {
    List<Resident> residents = [];
    try {
      var querySnapshot =  await db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Residents").get();
      for (var docSnapshot in querySnapshot.docs)  {
        Map<String, dynamic> value = docSnapshot.data();
        Resident resident = Resident(docSnapshot.id, value['firstname'], value['surname'], value['email'], value['password'], value['phoneNumber'], value['hasGoogleLogin']);
        residents.add(resident);
      }
    }    
    catch(e) {
      //log error here
      //returns empty list
      return residents;
    }
    return residents;
  }

  bool addResident(Resident person, String tlhId, hId)  {
    Map<String, dynamic> resident = {};
    //uses object data to create new field in the database
    try {
      resident["firstname"] = (person.firstname);
      resident["surname"] = (person.surname);
      resident["email"] = (person.email);
      resident["password"] = (person.password);
      resident["phoneNumber"] = (person.phoneNumber);
      resident["hasGoogleLogin"] = (person.hasGoogleLogin);
      db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Residents").add(resident);
    }
    catch(e) {
      return false;
    }
    return true;
  }

  bool updateResident(Resident person, String tlhId, hId)  {
    Map<String, dynamic> resident = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (person.firstname.trim().isNotEmpty) {resident["firstname"] = (person.firstname);}
      if (person.surname.trim().isNotEmpty) {resident["surname"] = (person.surname);}
      if (person.email.trim().isNotEmpty) {resident["email"] = (person.email);}
      if (person.password.trim().isNotEmpty) {resident["password"] = (person.password);}
      if (person.phoneNumber.trim().isNotEmpty) {resident["phoneNumber"] = (person.phoneNumber);}
      resident["hasGoogleLogin"] = (person.hasGoogleLogin);
      db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Residents").doc(person.id).update(resident);
    }
    catch(e) {
      return false;
    }       
    return true;
  }

  Future<List<Room>> getRooms(String tlhId, hId) async {
    List<Room> rooms = [];
    try {
      var querySnapshot =  await db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Rooms").get();
      for (var docSnapshot in querySnapshot.docs)  {
        Map<String, dynamic> value = docSnapshot.data();
        Room room = Room(docSnapshot.id, value['Room Name']);
        rooms.add(room);
      }
    }    
    catch(e) {
      //log error here
      //returns empty list
      return rooms;
    }
    return rooms;
  }

  bool addRoom(Room place, String tlhId, hId)  {
    Map<String, dynamic> room = {};
    //uses object data to create new field in the database
    try {
      room["Room Name"] = (place.name);
      db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Rooms").add(room);
    }
    catch(e) {
      return false;
    }
    return true;
  }

  bool updateRoom(Room place, String tlhId, hId)  {
    Map<String, dynamic> room = {};
    //updates any feilds in the database where the incoming object isn't the empty string
    try {
      if (place.name.trim().isNotEmpty) {room["Room Name"] = (place.name);}

      db.collection("Top Level Homes").doc(tlhId).collection("Household").doc(hId).collection("Residents").doc(place.id).update(room);
    }
    catch(e) {
      return false;
    }       
    return true;
  }
}