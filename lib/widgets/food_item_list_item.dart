import 'package:flutter/material.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:provider/provider.dart';

class FoodItemListItem extends StatelessWidget {
  final FoodItem foodItem;

  FoodItemListItem({Key? key, required this.foodItem}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var isInCart = context.select<Cart, bool>(
          (cart) => cart.foodItems.contains(foodItem),
    );

    return InkWell(
      onTap: () {
        var cart = context.read<Cart>();
        if(isInCart) {
          cart.removeFromCart(foodItem);
        } else {
          cart.addToCart(foodItem);
        }
      },
      child: ListTile(
          title: Text(foodItem.description),
          subtitle: Text(foodItem.foodCategory),
          trailing: isInCart ? Icon(Icons.check_box_rounded) : Icon(Icons.check_box_outline_blank_rounded)
      ),
    );
  }
}
