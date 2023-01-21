// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OnboardModel {
  final String image, title, des;
  Color color;
  OnboardModel(
      {required this.des,
      required this.title,
      required this.image,
      required this.color});

  static final List<OnboardModel> demo = [
    OnboardModel(
        color: Colors.amber[200]!,
        des:
            'Don\'t know what to eat? Take a picture, we\'ll suggets things to cook with your ingredients',
        title: 'Get inspired',
        image: 'assets/images/1.jpg'),
    OnboardModel(
        color: Color.fromARGB(255, 59, 175, 233),
        des:
            'Find thousands of easy and healthy recipes so you save time and eat better.',
        title: 'Easy & healthy',
        image: 'assets/images/2.webp'),
    OnboardModel(
        color: Color.fromARGB(255, 64, 139, 129),
        des:
            'Save your favorite reipes and get reminders to buy the ingredients to cook them',
        title: 'Save your favorities',
        image: 'assets/images/3.jpg'),
  ];
}
