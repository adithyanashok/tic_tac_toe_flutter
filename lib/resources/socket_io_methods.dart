import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/provider/room_data_provider.dart';
import 'package:flutter_tic_tac_toe/resources/game_methods.dart';
import 'package:flutter_tic_tac_toe/resources/socket_io_client.dart';
import 'package:flutter_tic_tac_toe/util/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIoMethods {
  final _socketClient = SocketIOClient.instance!.socket!;

  Socket get socketClient => _socketClient;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElement) {
    if (displayElement[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void createRoomListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.of(context).pushNamed('game-screen');
    });
  }

  void joinRoomListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.of(context).pushNamed('game-screen');
    });
  }

  void errorListener(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (data) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        data[0],
      );

      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        data[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateTheRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void tappeListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElement(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showAlertDialog(context, '${playerData['nickname']} won the game!');
      Navigator.pushNamedAndRemoveUntil(context, 'main-menu', (route) => false);
    });
  }
}
