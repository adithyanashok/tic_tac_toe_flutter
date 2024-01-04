// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tic_tac_toe/provider/room_data_provider.dart';
import 'package:flutter_tic_tac_toe/resources/socket_io_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  final RoomDataProvider dataProvider;
  const TicTacToeBoard({
    Key? key,
    required this.dataProvider,
  }) : super(key: key);

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketIoMethods _socketIoMethods = SocketIoMethods();

  @override
  void initState() {
    super.initState();
    _socketIoMethods.tappeListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    void tapped(int index, RoomDataProvider roomDataProvider) {
      _socketIoMethods.tapGrid(
        index,
        roomDataProvider.roomData['_id'],
        roomDataProvider.displayElements,
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketIoMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (roomDataProvider.roomData['turn']['socketID'] ==
                    _socketIoMethods.socketClient.id) {
                  tapped(index, roomDataProvider);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.dataProvider.displayElements[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 40,
                            color: widget.dataProvider.displayElements[index] ==
                                    'O'
                                ? Colors.red
                                : Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
