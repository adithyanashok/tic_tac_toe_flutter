import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showAlertDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.of(context).pop();
            },
            child: const Text("Play Again"),
          ),
        ],
      );
    },
  );
}
