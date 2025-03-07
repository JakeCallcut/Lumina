class Device {
  
  String id = "";
  String deviceName = "";
  String typeName = "";
  int imageId = 0;
  bool mainAction = false;
  Map<String,bool> actionList = {};

  Device(this.id, this.deviceName, this.typeName, this.imageId, this.mainAction, this.actionList);
}