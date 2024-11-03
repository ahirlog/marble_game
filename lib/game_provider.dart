import 'package:flutter/material.dart';
import 'dart:async';

class GameProvider with ChangeNotifier {
  static const int boardSize = 4;
  List<List<String?>> board =
      List.generate(boardSize, (_) => List.filled(boardSize, null));
  bool isPlayerOneTurn = true;
  bool isGameOver = false;
  String? winner;
  Timer? turnTimer;
  int turnTime = 10; // 10 seconds for each turn
  List<List<List<String?>>> gameHistory = [];

  GameProvider() {
    _startTurnTimer();
  }

  void _startTurnTimer() {
    turnTime = 10;
    turnTimer?.cancel();
    turnTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (--turnTime <= 0) {
        isPlayerOneTurn = !isPlayerOneTurn;
        _startTurnTimer();
        notifyListeners();
      } else {
        notifyListeners();
      }
    });
  }

  void resetGame() {
    board = List.generate(boardSize, (_) => List.filled(boardSize, null));
    isPlayerOneTurn = true;
    isGameOver = false;
    winner = null;
    gameHistory.clear();
    _startTurnTimer();
    notifyListeners();
  }

  void placeMarble(int row, int col) {
    if (isGameOver || board[row][col] != null) return;

    board[row][col] = isPlayerOneTurn ? 'P1' : 'P2';
    // _recordHistory();

    _moveMarblesCounterclockwise();

    if (_checkWinCondition()) {
      isGameOver = true;
      winner = isPlayerOneTurn ? 'Player 1' : 'Player 2';
      turnTimer?.cancel();
    } else {
      isPlayerOneTurn = !isPlayerOneTurn;
      _startTurnTimer();
    }

    notifyListeners();
  }

  void _moveMarblesCounterclockwise() {
    List<List<String?>> newBoard =
        List.generate(boardSize, (_) => List.filled(boardSize, null));

    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] != null) {
          int newRow = row, newCol = col;

          if (row == 0 && col < boardSize - 1) {
            newCol++;
          } else if (col == boardSize - 1 && row < boardSize - 1) {
            newRow++;
          } else if (row == boardSize - 1 && col > 0) {
            newCol--;
          } else if (col == 0 && row > 0) {
            newRow--;
          }

          newBoard[newRow][newCol] = board[row][col];
        }
      }
    }

    board = newBoard;
  }

  bool _checkWinCondition() {
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (_checkDirection(row, col, 1, 0) ||
            _checkDirection(row, col, 0, 1) ||
            _checkDirection(row, col, 1, 1) ||
            _checkDirection(row, col, 1, -1)) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkDirection(int row, int col, int rowDir, int colDir) {
    String? player = board[row][col];
    if (player == null) return false;

    for (int i = 1; i < 4; i++) {
      int newRow = row + rowDir * i;
      int newCol = col + colDir * i;
      if (newRow < 0 ||
          newRow >= boardSize ||
          newCol < 0 ||
          newCol >= boardSize ||
          board[newRow][newCol] != player) {
        return false;
      }
    }
    return true;
  }

// void _recordHistory() {
//   gameHistory.add(board.map((row) => row.toList()).toList());
// }
}
