import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:amazon_clone/models/rating.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Product12 {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;

  Product12(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      this.id,
      this.rating});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': images,
      'category': category,
      'id': id,
      'rating': rating
    };
  }

  factory Product12.fromMap(Map<String, dynamic> map) {
    return Product12(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        id: map['_id'] ?? '',
        rating: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product12.fromJson(String source) =>
      Product12.fromMap(json.decode(source));
}
