import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:food_waste/screens/input_search_screen.dart';
import 'package:food_waste/widgets/storage_location.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: TabBar(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Fridge",
                ),
                Tab(
                  text: "Freezer",
                ),
                Tab(
                  text: "Pantry",
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: TabBarView(
              children: [
                StorageLocation(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_boat),
              ],
            ),
          )
        ],
      ),
    );
  }
}

