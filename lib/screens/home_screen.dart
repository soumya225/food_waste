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
                    icon: Icon(Icons.info_rounded),
                    tooltip: "About",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        builder: (BuildContext buildContext) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView(
                              children: [
                                Text(
                                  "Welcome to the Butler app!",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                    """
                                                                        
Butler aims to help you keep track of the foods you have at home and to help you plan when to use those foods.
To get started, add food items to your inventory. Once you have added enough products, you’ll be able to view an automatically generated food schedule that will suggest what to consume today, tomorrow, and the day after tomorrow.

The source of data for the food items is USDA FoodData Central :
U.S. Department of Agriculture, Agricultural Research Service. FoodData Central, 2019. fdc.nal.usda.gov.

©2021 Soumya Satheesan""",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          );
                        }
                      );
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
