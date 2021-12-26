import 'package:food_waste/utilities.dart';
import 'package:test/test.dart';

void main() {
  group('Calculate days to expiry', () {
    test("Many days to expiry", () {
      DateTime from = DateTime(2020, 9, 7, 17, 30);
      DateTime to = DateTime(2021, 9, 7, 19);
      int days = daysToExpiry(from, to);
      expect(days, 365);
    });

    test("One day to expiry", () {
      DateTime from = DateTime(2017, 9, 7, 17, 30);
      DateTime to = DateTime(2017, 9, 8, 19);
      int days = daysToExpiry(from, to);
      expect(days, 1);
    });

    test("Zero days to expiry", () {
      DateTime from = DateTime(2017, 9, 7, 17, 30);
      DateTime to = DateTime(2017, 9, 7, 19);
      int days = daysToExpiry(from, to);
      expect(days, 0);
    });

    test("Negative days to expiry", () {
      DateTime from = DateTime(2017, 9, 7, 17, 30);
      DateTime to = DateTime(2017, 9, 4, 19);
      int days = daysToExpiry(from, to);
      expect(days, -3);
    });
  });
}