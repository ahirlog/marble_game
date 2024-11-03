# marble_game

A new Flutter project.

https://github.com/user-attachments/assets/77468aa6-56c6-4741-959a-b8e848584c4d

## Getting Started

The code is a Two-Player Counterclockwise Marble Game built using Flutter for the UI framework and Dart as the programming language, with the Provider package for state management. The main components of the code are structured as follows:

Main Application and Setup:

The app is initialized using the main() function, which sets up GameProvider as a global state manager using ChangeNotifierProvider.
MarbleGameApp serves as the root widget and initializes GameScreen, the main UI for the game.

Game Logic (GameProvider):

GameProvider manages the game’s state, including the board, player turns, marble movements, timer.
The board is represented by a 4x4 grid (List<List<String?>>), where each cell can hold either "P1" for Player 1, "P2" for Player 2, or null if empty.

Gameplay:

Players take turns to place marbles in any empty cell, switching turns after each move.
After each placement, marbles move counterclockwise within the grid using _moveMarblesCounterclockwise() function.
The game checks for a win after each move by checking all rows, columns, and diagonals using _checkWinCondition().
Timer: Each player has 10 seconds per turn. The _startTurnTimer() function handles this countdown and automatically switches turns if the player exceeds their time.

User Interface (GameScreen):

The UI consists of a grid-based layout representing the board, where players can tap on cells to place marbles.
The AppBar has a reset button to restart the game, while the board dynamically updates to reflect marble positions, whose turn it is, and the timer countdown.

Libraries and Frameworks Used

Flutter: A UI framework to build the interactive components and structure of the game.
Provider: A package for state management, making it easier to manage the game state and update the UI accordingly.

Guide: How to Play the Game

Game Objective

The goal is to align four of your marbles consecutively, either horizontally, vertically, or diagonally.

Rules

Turn-Based Placement:

Two players take turns, starting with Player 1.
On your turn, tap on an empty cell in the 4x4 grid to place your marble.

Counterclockwise Movement:

After placing a marble, all marbles (including your opponent’s) shift one cell counterclockwise around the outer edges of the grid.

Winning Condition:

The first player to align four of their marbles in a row (horizontally, vertically, or diagonally) wins the game.

If a winning condition is met, the game ends and displays the winner.

Turn Timer:

Each player has 10 seconds per turn. If time runs out, the turn automatically switches to the other player.

Controls

Tap an empty cell on the grid to place your marble.
Reset Button (top right): Resets the game to the initial state.

With these rules and UI interactions, players can engage in a strategic two-player game where quick moves and counterclockwise shifts add a layer of complexity!
