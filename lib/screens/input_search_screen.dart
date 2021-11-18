import 'package:flutter/material.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:food_waste/services/api_service.dart';
import 'package:food_waste/widgets/food_item_list_item.dart';
import 'package:provider/provider.dart';


class InputSearchScreen extends StatefulWidget {
  InputSearchScreen({Key? key}) : super(key: key);

  @override
  State<InputSearchScreen> createState() => _InputSearchScreenState();
}

class _InputSearchScreenState extends State<InputSearchScreen> {
  final textController = TextEditingController();

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: textController,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              child: Icon(Icons.search_rounded),
              onPressed: () => {
                setState(() {})
              },
            ),
          ),
          hintText: "Search",
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildFoodItemsList(BuildContext context) {
    return textController.text.isEmpty ? Text("Search for food items") : FutureBuilder<dynamic>(
      future: ApiService().fetchFoods(textController.text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        "assets/images/cancel.png",
                        fit: BoxFit.contain
                    ),
                  ),
                  Text('Oh no! Something went wrong! Please try again.'),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Text('No foods found');
          }
          final List<FoodItem> foods = FoodItem.fromJson(snapshot.data.body);
          if(foods.isEmpty) {
            return const Text('No foods found');
          }
          final List<Widget> foodTiles = foods.map<Widget>((FoodItem f) => FoodItemListItem(foodItem: f)).toList();
          return Expanded (
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: foodTiles.length,
              itemBuilder: (BuildContext context, int i) {
                return foodTiles[i];
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          );
        }
        else {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          );
        }
      },
    );
  }

  Widget _buildSelectProductsButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          var cart = context.read<Cart>();
          if(cart.foodItems.length > 0) {
            Navigator.pushNamed(context, "/add_selected_products");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No items selected. Please select at least one item or go back to inventory.")));
          }
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
