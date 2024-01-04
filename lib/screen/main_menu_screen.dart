import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/responsive/responsive.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Responsive(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed('create-room');
                },
                text: "Create Room",
              ),
              const SizedBox(
                width: 20,
              ),
              CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed('join-room');
                },
                text: "Join Room",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
