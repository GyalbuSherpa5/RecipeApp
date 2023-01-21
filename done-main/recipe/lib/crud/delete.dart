import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteRecipe {
  DeleteRecipe(BuildContext context, {required String title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to delete your receipe? "),
          actions: [
            MaterialButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text("yes"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('recipe')
                    .doc(title)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
