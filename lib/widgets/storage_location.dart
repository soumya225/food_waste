import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/widgets/inventory_item_list_item.dart';

class StorageLocation extends StatefulWidget {
  const StorageLocation({Key? key}) : super(key: key);

  @override
  State<StorageLocation> createState() => _StorageLocationState();
}

class _StorageLocationState extends State<StorageLocation> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = "Expiry";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => {},
              child: Text(
                "Sort by:"
              )
            ),
            DropdownButton<String>(
              value: dropdownValue,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>["Expiry", "Category"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        Expanded(
          child: GridView.extent(
            padding: EdgeInsets.only(bottom: 16.0),
            maxCrossAxisExtent: 200,
            children: demoInventoryItems.map<Widget>((dynamic foodItem) =>
                InventoryItemListItem(foodItem: foodItem,)).toList(),
          ),
        ),
      ],
    );
  }
}
