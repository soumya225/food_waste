import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/analytics_service.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  CollectionReference inventoriesCollection =
      FirebaseFirestore.instance.collection("inventories");

  String _uniqueDocumentID(InventoryItem item) {
    return item.description + item.expiry.toString();
  }

  Future<void> addItemToInventory(InventoryItem item) {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User is not logged in");
    }

    return inventoriesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_inventory")
        .doc(_uniqueDocumentID(item))
        .set(<String, dynamic>{
      "description": item.description,
      "foodCategory": item.foodCategory,
      "location": item.location,
      "count": item.count,
      "expiry": item.expiry,
      "proteinValue": item.proteinValue,
      "fatValue": item.fatValue,
      "carbValue": item.carbValue
    }).catchError((e) => print(e));
  }

  Stream<List<InventoryItem>> getInventoryItems() {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User is not logged in");
    }

    return inventoriesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_inventory")
        .orderBy("expiry")
        .snapshots()
        .map(_inventoryItemsFromSnapshot);
  }

  List<InventoryItem> _inventoryItemsFromSnapshot(QuerySnapshot snapshot) {
    List<InventoryItem> items = [];

    snapshot.docs.forEach((doc) {
      items.add(InventoryItem(
        description: doc.get("description"),
        foodCategory: doc.get("foodCategory"),
        location: doc.get("location"),
        count: doc.get("count"),
        expiry: doc.get("expiry").toDate(),
        proteinValue: doc.get("proteinValue"),
        carbValue: doc.get("carbValue"),
        fatValue: doc.get("fatValue")
      ));
    });

    return items;
  }

  Future<void> deleteInventoryItem(InventoryItem item) {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User is not logged in");
    }

    return inventoriesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_inventory")
        .doc(_uniqueDocumentID(item))
        .delete()
        .catchError((e) => print(e));
  }

  Future<void> updateInventoryItem(InventoryItem item, {DateTime? newExpiry}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User is not logged in");
    }

    String id = _uniqueDocumentID(item);

    if(newExpiry == null) {
      return inventoriesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("user_inventory")
          .doc(id)
          .update(<String, dynamic>{
        "description": item.description,
        "foodCategory": item.foodCategory,
        "location": item.location,
        "count": item.count,
        "expiry": item.expiry
      }).catchError((e) => print(e));
    } else {
      await deleteInventoryItem(item);
      return addItemToInventory(InventoryItem(
        description: item.description,
        foodCategory: item.foodCategory,
        expiry: newExpiry,
        location: item.location,
        count: item.count,
        proteinValue: item.proteinValue,
        fatValue: item.fatValue,
        carbValue: item.carbValue
      ));
    }
  }

}
