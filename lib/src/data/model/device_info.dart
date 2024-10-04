
class DeviceInfo {
  double? availableStorage;
  double? totalStorage;
  double? appCacheSize;

  DeviceInfo({this.availableStorage, this.totalStorage, this.appCacheSize});

  Map<String,double?> toMap() {
    return {
      'availableStorage' : availableStorage,
      'totalStorage' : totalStorage,
      'appCacheSize' : appCacheSize,
    };
  }


}