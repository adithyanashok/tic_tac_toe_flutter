import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/provider/room_data_provider.dart';
import 'package:flutter_tic_tac_toe/resources/socket_io_methods.dart';
import 'package:flutter_tic_tac_toe/widgets/scoreboard.dart';
import 'package:flutter_tic_tac_toe/widgets/tic_tac_toe_board.dart';
import 'package:flutter_tic_tac_toe/widgets/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketIoMethods _socketIoMethods = SocketIoMethods();

  @override
  void initState() {
    super.initState();
    _socketIoMethods.updateRoomListener(context);
    _socketIoMethods.updatePlayersStateListener(context);
    _socketIoMethods.pointIncreaseListener(context);
    _socketIoMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<RoomDataProvider>(context).roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Scorboard(),
                    TicTacToeBoard(
                      dataProvider: Provider.of<RoomDataProvider>(context),
                    ),
                    Text(
                        '${Provider.of<RoomDataProvider>(context).roomData['turn']['nickname']}\'s turn')
                  ],
                ),
              ),
            ),
    );
  }
}
