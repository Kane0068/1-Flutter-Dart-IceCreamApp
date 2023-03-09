import 'package:flutter/material.dart';

class IceCream {
  final String image, flavor;
  final double price;
  final Color lightColor, darkColor;
  double rating;
  int count;

  IceCream({
    required this.image,
    required this.flavor,
    required this.rating,
    required this.price,
    required this.lightColor,
    required this.darkColor,
    required this.count,
  });
}

final IceCreamList = [

  IceCream(
      count: 1,
      image: "icecream1.png",
      flavor: "Strawberry",
      rating: 4.3,
      price: 60.8,
      lightColor: Colors.orange,
      darkColor: Colors.amber),
  IceCream(
      count: 1,
      image: "icecream2.png",
      flavor: "Bananas",
      rating: 3.3,
      price: 55.8,
      lightColor: Colors.orange,
      darkColor: Colors.amber),
  IceCream(
      count: 1,
      image: "icecream1.png",
      flavor: "Chocalate",
      rating: 4.5,
      price: 72.8,
      lightColor: Colors.orange,
      darkColor: Colors.amber),
  IceCream(
      count: 1,
      image: "icecream2.png",
      flavor: "Strawberry",
      rating: 4.3,
      price: 60.8,
      lightColor: Colors.orange,
      darkColor: Colors.amber),
  IceCream(
      count: 1,
      image: "icecream1.png",
      flavor: "Strawberry",
      rating: 4.3,
      price: 60.8,
      lightColor: Colors.orange,
      darkColor: Colors.amber),
];
