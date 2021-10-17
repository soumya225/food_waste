import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:food_waste/widgets/selected_product_list_item.dart';
import 'package:food_waste/screens/inventory_screen.dart';


class AddSelectedProductsScreen extends StatelessWidget {
  const AddSelectedProductsScreen({Key? key}) : super(key: key);

  Widget _buildFoodItemsList(BuildContext context) {
    return Expanded (
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: demoFoodItems.length,
        itemBuilder: (BuildContext context, int i) {
          return SelectedProductListItem(foodItem: demoFoodItems[i]);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }


  Widget _buildAddToInventoryButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName("/home"));
        },
        child: Text(
          "Add products to inventory",
          style: Theme.of(context).textTheme.button,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add selected products"),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Column (
              children: [
                _buildFoodItemsList(context),
                _buildAddToInventoryButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
