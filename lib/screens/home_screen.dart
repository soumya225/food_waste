import 'package:flutter/material.dart';
import 'package:food_waste/screens/inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
              tabs: [
                Tab(
                  text: "Food inventory",
                  icon: Icon(Icons.kitchen_rounded),
                ),
                Tab(
                  text: "Food schedule",
                  icon: Icon(Icons.calendar_today_rounded),
                ),
              ]),
        ),
        body: TabBarView(
          children: <Widget>[
            InventoryScreen(),
            Center(
              child: Text("Schedule"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/input_search");
          },
          child: Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
