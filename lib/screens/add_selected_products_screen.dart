import 'package:flutter/material.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/database_service.dart';
import 'package:food_waste/widgets/selected_product_list_item.dart';
import 'package:provider/provider.dart';


class AddSelectedProductsScreen extends StatelessWidget {
  const AddSelectedProductsScreen({Key? key}) : super(key: key);

  Widget _buildFoodItemsList(BuildContext context) {
    return Consumer<Cart>(
      builder: (BuildContext context, Cart cart, Widget? child) {
        return Expanded (
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cart.foodItems.length,
            itemBuilder: (BuildContext context, int i) {
              return SelectedProductListItem(foodItem: cart.foodItems[i], index: i);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        );
      }
    );
  }


  Widget _buildAddToInventoryButton(BuildContext context) {
    var cart = context.read<Cart>();

    return ElevatedButton(
        onPressed: () {
          cart.foodItems.forEach((foodItem) async {
            InventoryItem newItem = InventoryItem(
                description: foodItem.description,
                foodCategory: foodItem.foodCategory,
                expiry: foodItem.expiry,
                count: foodItem.count,
                location: foodItem.location
            );

            await DatabaseService().addItemToInventory(newItem);
          });

          print(cart.foodItems);

          cart.foodItems.clear();

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
