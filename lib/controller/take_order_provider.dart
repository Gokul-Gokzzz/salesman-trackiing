import 'package:flutter/material.dart';

class FoodProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _foodItems = [
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 1",
      "price": "₹100",
      "quantity": 1,
    },
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 2",
      "price": "₹100",
      "quantity": 1,
    },
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 3",
      "price": "₹100",
      "quantity": 1,
    },
  ];

  List<Map<String, dynamic>> get foodItems => _foodItems;

  void incrementQuantity(int index) {
    _foodItems[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_foodItems[index]['quantity'] > 1) { // Prevent decrementing below 1
      _foodItems[index]['quantity']--;
      notifyListeners();
    }
  }
}
