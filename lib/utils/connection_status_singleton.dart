import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

//InternetAddress utility
//For StreamController/Stream

enum ConnectionStatus { good, bad, none }

class ConnectionStatusSingleton {
  //CODE: THIS TRACKS THE CURRENT CONNECTION STATUS
  Timer? _timer;

  //CODE: THIS IS HOW WE'LL ALLOW SUBSCRIBING TO CONNECTION CHANGES
  BehaviorSubject<ConnectionStatus?> connectionChangeController =
      BehaviorSubject<ConnectionStatus?>.seeded(ConnectionStatus.good);

  //CODE: FLUTTER_CONNECTIVITY
  final Connectivity connectivity = Connectivity();

  //CODE: HOOK INTO FLUTTER_CONNECTIVITY'S STREAM TO LISTEN FOR CHANGES
  //CODE: AND CHECK THE CONNECTION STATUS OUT OF THE GATE
  void initialize() {
    connectivity.onConnectivityChanged.listen(_connectionChange);
    const Duration sec = Duration(seconds: 5);
    _timer = Timer.periodic(
      sec,
      (Timer t) => checkConnection(),
    );
  }

  Stream get connectionChange => connectionChangeController.stream;

  Future<String> getConnectivitySource() async {
    ConnectivityResult _connectivity = await connectivity.checkConnectivity();
    if (_connectivity == ConnectivityResult.mobile) {
      return "Mobile";
    } else if (_connectivity == ConnectivityResult.wifi) {
      return "Wifi";
    } else {
      return "none";
    }
  }

  //CODE: A CLEAN UP METHOD TO CLOSE OUR STREAM CONTROLLER
  //CODE: BECAUSE THIS IS MEANT TO EXIST THROUGH THE ENTIRE APPLICATION LIFE CYCLE THIS ISN'T
  //CODE: REALLY AN ISSUE
  void dispose() {
    _timer?.cancel();
    connectionChangeController.close();
  }

  //CODE:FLUTTER_CONNECTIVITY'S LISTENER
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  void updateConnectionStatusSubject(ConnectionStatus value) {
    if (connectionChangeController.value == value) {
      return;
    }
    connectionChangeController.add(value);
  }

  //CODE:THE TEST TO ACTUALLY SEE IF THERE IS A CONNECTION
  Future<void> checkConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com').timeout(
        Duration(seconds: 3),
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        updateConnectionStatusSubject(ConnectionStatus.good);
      } else {
        updateConnectionStatusSubject(ConnectionStatus.none);
      }
    } on SocketException catch (_) {
      updateConnectionStatusSubject(ConnectionStatus.none);
    } on TimeoutException catch (_) {
      updateConnectionStatusSubject(ConnectionStatus.bad);
    }
  }
}

final ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton();
