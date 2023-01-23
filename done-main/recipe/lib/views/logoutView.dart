// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MenuAction { logout }

Future clear({required String key}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove(key);
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                clear(key: 'name');
              },
              child: const Text('Log out'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
