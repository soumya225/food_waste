import 'package:food_waste/models/food_item.dart';
import 'package:test/test.dart';

void main() {
  group("FoodItem", () {
    test('Parse one item to list of FoodItems', () {
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
            '}'
          ']'
        '}';
      List<FoodItem> items = FoodItem.fromJson(jsonString);
      expect(items.length, 1);
      expect(items[0].carbValue, 74.7);
      expect(items[0].fatValue, 0.44);
      expect(items[0].proteinValue, 0.696);
      expect(items[0].description, "tomato powder");
      expect(items[0].foodCategory, "Vegetables and Vegetable Products");
    });

    test('Parse zero items to list of FoodItems', () {
      String jsonString = '{'
            '"foods": []'
          '}';
      List<FoodItem> items = FoodItem.fromJson(jsonString);
      expect(items.length, 0);
    });

    test('Parse multiple items to list of FoodItems', () {
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
      expect(items.length, 2);

      expect(items[0].carbValue, 74.7);
      expect(items[0].fatValue, 0.44);
      expect(items[0].proteinValue, 0.696);
      expect(items[0].description, "tomato powder");
      expect(items[0].foodCategory, "Vegetables and Vegetable Products");

      expect(items[1].carbValue, 7.09);
      expect(items[1].fatValue, 0.425);
      expect(items[1].proteinValue, 0.695);
      expect(items[1].description, "tomato, roma");
      expect(items[1].foodCategory, "Vegetables and Vegetable Products");
    });

  });
}