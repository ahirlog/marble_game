import 'package:flutter/material.dart';
import 'package:marble_game/game_provider.dart';
import 'package:marble_game/game_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: const MarbleGameApp(),
    ),
  );
}

class MarbleGameApp extends StatelessWidget {
  const MarbleGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
