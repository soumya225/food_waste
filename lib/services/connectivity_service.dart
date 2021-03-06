import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:food_waste/utilities.dart';


class ConnectivityService with ChangeNotifier {
  ConnectivityStatus connectionStatus = ConnectivityStatus.Loading;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("============ Connection result: $result");
      connectionStatus = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    connectionStatus = _getStatusFromResult(connectivityResult);
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}