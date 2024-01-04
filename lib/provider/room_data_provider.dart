import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/models/player_model.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  PlayerModel _player1 = PlayerModel(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );

  PlayerModel _player2 = PlayerModel(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'O',
  );
  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledBoxes => _filledBoxes;
  PlayerModel get player1 => _player1;
  PlayerModel get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> data) {
    _player1 = PlayerModel.fromMap(data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> data) {
    _player2 = PlayerModel.fromMap(data);
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElement[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElement[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }
}
