import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/screens/food_schedule_screen.dart';
import 'package:food_waste/screens/inventory_screen.dart';
import 'package:food_waste/services/auth_service.dart';
import 'package:food_waste/services/connectivity_service.dart';
import 'package:food_waste/services/database_service.dart';
import 'package:food_waste/widgets/network_detection_wrapper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<InventoryItem>>.value(
        value: DatabaseService().getInventoryItems(),
        initialData: [],
        builder: (ctx, value) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Home"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.help_rounded),
                    tooltip: "Help",
                    onPressed: () {
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app_rounded),
                    tooltip: "Logout",
                    onPressed: () {
                      AuthService().signOut();
                      Navigator.pushReplacementNamed(context, "/login");
                    }
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                color: Theme.of(context).colorScheme.primary,
                child: TabBar(tabs: [
                  Tab(
                    text: "food inventory",
                    icon: Icon(Icons.kitchen_rounded),
                  ),
                  Tab(
                    text: "food schedule",
                    icon: Icon(Icons.calendar_today_rounded),
                  ),
                ]),
              ),
              body: Consumer<ConnectivityService>(
                builder: (context, service, widget) => NetworkDetection(
                  child: TabBarView(
                    children: <Widget>[
                      InventoryScreen(),
                      FoodScheduleScreen(),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/input_search");
                },
                child: Icon(Icons.add_rounded),
              ),
            ),
          );
        });
  }
}
