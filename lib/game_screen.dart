import 'package:flutter/material.dart';
import 'package:marble_game/game_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Consumer<GameProvider>(
        builder: (context, game, child) {
          return Column(
            children: [
              timerSection(game),
              const Divider(),
              Column(
                children: List.generate(
                  GameProvider.boardSize,
                  (row) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      GameProvider.boardSize,
                      (col) => GestureDetector(
                        onTap: () => game.placeMarble(row, col),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              color: Colors.black12),
                          child: (game.board[row][col] != null)
                              ? Center(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (game.board[row][col] == 'P1')
                                          ? Colors.grey[800]
                                          : Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        game.board[row][col] ?? '',
                                        style: TextStyle(
                                          color: (game.board[row][col] == 'P1')
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row timerSection(GameProvider game) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (game.winner != null) winnerText(game),
        Container(
          margin: const EdgeInsets.only(top: 7),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Text(
            'Turn: ${game.isPlayerOneTurn ? 'Player 1' : 'Player 2'} (${game.turnTime}s left)',
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
          ),
        ),
        if (game.winner != null) winnerText(game),
      ],
    );
  }

  Padding winnerText(GameProvider game) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 7),
      child: Text(
        '${game.winner} wins!',
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        'MARBLE GAME',
        style: TextStyle(
            fontWeight: FontWeight.w700, color: Colors.white, fontSize: 30),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () => context.read<GameProvider>().resetGame(),
        ),
      ],
    );
  }
}
