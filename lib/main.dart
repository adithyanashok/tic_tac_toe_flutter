import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/provider/room_data_provider.dart';
import 'package:flutter_tic_tac_toe/screen/create_room_screen.dart';
import 'package:flutter_tic_tac_toe/screen/game_scree.dart';
import 'package:flutter_tic_tac_toe/screen/join_room_screen.dart';
import 'package:flutter_tic_tac_toe/screen/main_menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(
          useMaterial3: false,
        ).copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 17, 138),
        ),
        debugShowCheckedModeBanner: false,
        home: const MainMenuScreen(),
        routes: {
          'main-menu': (context) => const MainMenuScreen(),
          'create-room': (context) => const CreateRoomScreen(),
          'join-room': (context) => const JoinRoomScreen(),
          'game-screen': (context) => const GameScreen(),
        },
        initialRoute: 'main-menu',
      ),
    );
  }
}
