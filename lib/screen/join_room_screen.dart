import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/resources/socket_io_methods.dart';
import 'package:flutter_tic_tac_toe/responsive/responsive.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_button.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_text.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_text__field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => JoinRoomScreenState();
}

class JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketIoMethods _socketIoMethods = SocketIoMethods();

  @override
  void initState() {
    super.initState();
    _socketIoMethods.updatePlayersStateListener(context);
    _socketIoMethods.joinRoomListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Join Room',
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: "Enter your nickname",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _gameIdController,
                hintText: "Enter Game ID",
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomButton(
                  onTap: () => _socketIoMethods.joinRoom(
                        _nameController.text,
                        _gameIdController.text,
                      ),
                  text: 'Join')
            ],
          ),
        ),
      ),
    );
  }
}
