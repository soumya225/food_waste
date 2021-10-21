import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/widgets/food_item_list_item.dart';


class InputSearchScreen extends StatelessWidget {
  InputSearchScreen({Key? key}) : super(key: key);

    Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: "Search",
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildFoodItemsList(BuildContext context) {
      return Expanded (
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: demoFoodItems.length,
          itemBuilder: (BuildContext context, int i) {
            return FoodItemListItem(foodItem: demoFoodItems[i]);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      );
  }


  Widget _buildSelectProductsButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
          Navigator.pushNamed(context, "/add_selected_products")
        },
        child: Text(
          "Select products",
          style: Theme.of(context).textTheme.button,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for products")
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column (
              children: [
                _buildSearchBar(context),
                _buildFoodItemsList(context),
                _buildSelectProductsButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
