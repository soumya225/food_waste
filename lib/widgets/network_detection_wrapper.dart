import 'package:flutter/material.dart';
import 'package:food_waste/services/connectivity_service.dart';
import 'package:provider/provider.dart';
import 'package:food_waste/utilities.dart';

class NetworkDetection extends StatelessWidget {
  final Widget child;
  NetworkDetection({ required this.child,});

  @override
  Widget build(BuildContext context) {
    var connection = context.read<ConnectivityService>();
    print("============ Connection status: ${connection.connectionStatus}");
    if (connection.connectionStatus == ConnectivityStatus.Loading) {
      return Center(
          child: SizedBox (
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
      );
    }
    else if (connection.connectionStatus == ConnectivityStatus.Offline) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                  "assets/images/cancel.png",
                  width: 136,
                  fit: BoxFit.contain
              ),
            ),
            Text(
              'No internet',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );
    } else {
      return child;
    }
  }
}