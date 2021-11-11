import 'dart:convert';

import 'package:food_waste/models/inventory_item.dart';
import 'package:http/http.dart';

import 'package:food_waste/utilities.dart';

class ScheduleService {
  static final ScheduleService _instance = ScheduleService._internal();

  factory ScheduleService() {
    return _instance;
  }

  ScheduleService._internal();

  Future<dynamic> calculateDay(List<InventoryItem> items) async {
    String url = Uri.encodeFull('http://8e9f-197-157-115-202.ngrok.io/schedule');

    List jsonList = [];

    items.forEach((element) {
          var obj = {
            "name": element.description,
            "protein": element.proteinValue,
            "fat": element.fatValue,
            "carb": element.carbValue,
            "quantity": element.count,
            "daysToExpiry": daysToExpiry(DateTime.now(), element.expiry)
          };

          jsonList.add(obj);
    });

    var response = await post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(jsonList)
    );

    return json.decode(response.body);
  }
}
