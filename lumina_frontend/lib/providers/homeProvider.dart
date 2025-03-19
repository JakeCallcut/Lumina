import 'package:flutter/material.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class homeProvider extends ChangeNotifier {
  String _loginid = '';
  String _accountType = '';

  TopLevelHome _tLH = TopLevelHome("", "", []);
  Household _houseHold = Household("", {}, {});
  HouseCode _houseCode = HouseCode("", "", "", "");
  List<Household> _houseHolds = [];
  User _user = User("", "", "", "", "", "", false);
  List<EnergyUsage> _energyUsage = [];
  List<Device> _devices = [];
  Room _curRoom = Room("","",);
  List<Room> _rooms = [];

  String get loginid => _loginid;
  String get accountType => _accountType;
  User get user => _user;
  TopLevelHome get topLevelHome => _tLH;
  Household get houseHold => _houseHold;
  HouseCode get houseCode => _houseCode;
  List<Household> get houseHolds => _houseHolds;
  List<EnergyUsage> get energyUsage => _energyUsage;
  List<Device> get devices => _devices;
  Room get curRoom => _curRoom;
  List<Room> get rooms => _rooms;
  var instance = Integration();
  // List of rooms
  // list of devices
  // list of energy

  void setUid(String dynamicUid) {
    _loginid = dynamicUid;
  }

  void setAccountType(String account) {
    _accountType = account;
  }

  void setRooms(List<Room> roomlist) {
    _rooms = roomlist;
  }

  void setRoom(Room currentRoom) async {
    _curRoom = currentRoom;
    List<Device> fetchedDevices = await instance.getDevices(houseCode.topHouseId, houseCode.householdId, _curRoom.id);
    _devices = fetchedDevices;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      // Fetch the user data
      User user = await instance.getUserByLogin(loginid);
      _user = user;

      // Attempt to fetch the TopLevelHome
      TopLevelHome tLH = await instance.getTopLevelHome(user.houseCodeId);

      if (tLH.id.isNotEmpty) {
        // If a valid TopLevelHome is found, proceed with manager data
        setAccountType("manager");
        _tLH = tLH;
        await managerData();
      } else {
        // If no valid TopLevelHome is found, fall back to resident data
        await residentData();
      }
    } catch (e) {
      // Handle any unexpected errors
      print("Error in fetchData: $e");
      await residentData(); // Fallback to resident data in case of an error
    }

    // Notify listeners after data is fetched
    notifyListeners();
  }

  Future<void> managerData() async {
    List<Household> tempHouseholds = await instance.getHouseholds(_tLH.id);
    _houseHolds = tempHouseholds;
    for (int i = 0; i < _houseHolds.length; i++) {
      EnergyUsage tempEnergy =
          await instance.getEnergyUsageByHouseId(_houseHolds[i].id);
      _energyUsage.add(tempEnergy);
    }
  }

  Future<void> residentData() async {
    HouseCode tempHouseCode =
        await instance.getHouseCodeById(_user.houseCodeId);
    _houseCode = tempHouseCode;
    Household tempHousehold = await instance.getHousehold(
        tempHouseCode.topHouseId, tempHouseCode.householdId);
    _houseHold = tempHousehold;
    List<Room> fetchedRooms = await instance.getRooms(houseCode.topHouseId, houseCode.householdId);
    _rooms = fetchedRooms;
  }
}
