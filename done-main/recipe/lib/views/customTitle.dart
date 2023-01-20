// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
    );
  }
}
