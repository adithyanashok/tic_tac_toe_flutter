import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/resources/socket_io_methods.dart';
import 'package:flutter_tic_tac_toe/responsive/responsive.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_button.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_text.dart';
import 'package:flutter_tic_tac_toe/widgets/custom_text__field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketIoMethods _socketIoMethods = SocketIoMethods();

  @override
  void initState() {
    super.initState();
    _socketIoMethods.createRoomListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
                text: 'Create Room',
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: "Enter your nickname",
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomButton(
                onTap: () => _socketIoMethods.createRoom(_nameController.text),
                text: 'Create',
              )
            ],
          ),
        ),
      ),
    );
  }
}
