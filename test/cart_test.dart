import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:test/test.dart';

void main() {

  String jsonString = '{'
      '"foods": ['
      '{'
      '"lowercaseDescription": "tomato powder",'
      '"foodCategory": "Vegetables and Vegetable Products",'
      '"foodNutrients": ['
      '{"nutrientId": 1005, "nutrientName": "Carbohydrate, by difference","value": 74.7},'
      '{"nutrientId": 1004, "nutrientName": "Total lipid (fat)", "value": 0.44},'
      '{"nutrientId": 1003, "nutrientName": "Protein", "value": 0.696}'
      ']'
      '},'
      '{'
      '"lowercaseDescription": "tomato, roma",'
      '"foodCategory": "Vegetables and Vegetable Products",'
      '"foodNutrients": ['
      '{"nutrientId": 1003, "nutrientName": "Protein", "value": 0.695},'
      '{"nutrientId": 1004, "nutrientName": "Total lipid (fat)", "value": 0.425},'
      '{"nutrientId": 1005, "nutrientName": "Carbohydrate, by difference","value": 7.09}'
      ']'
      '}'
      ']'
      '}';
  List<FoodItem> items = FoodItem.fromJson(jsonString);

  group("Cart", () {

    test('Cart should initially be empty', () {
      var cart = new Cart();
      expect(cart.foodItems.length, 0);
    });


    test('Add one item to cart', () {
      var cart = new Cart();
      cart.addToCart(items[0]);
      expect(cart.foodItems.length, 1);
      expect(cart.foodItems[0].description, "tomato powder");
    });

    test('Remove one item from cart', () {
      var cart = new Cart();

      cart.addToCart(items[0]);
      cart.addToCart(items[1]);

      cart.removeFromCart(items[0]);
      expect(cart.foodItems.length, 1);
    });

    test('Change expiry date of item in cart', () {
      var cart = new Cart();

      cart.addToCart(items[0]);
      cart.addToCart(items[1]);

      cart.changeExpiryDateOfItem(0, DateTime(2021, 12, 12));
      expect(cart.foodItems[0].expiry, DateTime(2021, 12, 12));
    });

    test('Change storage location of item in cart', () {
      var cart = new Cart();

      cart.addToCart(items[0]);
      cart.addToCart(items[1]);

      cart.changeStorageLocationOfItem(1, "Location");
      expect(cart.foodItems[1].location, "Location");
    });

    test('Change count of item in cart', () {
      var cart = new Cart();

      cart.addToCart(items[0]);
      cart.addToCart(items[1]);

      cart.changeItemCountOfItem(0, 2);
      expect(cart.foodItems[0].count, 2);
    });

    test('Clear items from cart', () {
      var cart = new Cart();

      cart.addToCart(items[0]);
      cart.addToCart(items[1]);

      cart.clearCart();
      expect(cart.foodItems.length, 0);
    });

  });
}