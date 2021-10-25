import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/screens/input_search_screen.dart';
import 'package:food_waste/utilities.dart';
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
                  text: "all",
                ),
                Tab(
                  text: storageLocations[0],
                ),
                Tab(
                  text: storageLocations[1],
                ),
                Tab(
                  text: storageLocations[2],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 196.0,
            child: TabBarView(
              children: [
                StorageLocation(location: null),
                StorageLocation(location: storageLocations[0]),
                StorageLocation(location: storageLocations[1]),
                StorageLocation(location: storageLocations[2]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

