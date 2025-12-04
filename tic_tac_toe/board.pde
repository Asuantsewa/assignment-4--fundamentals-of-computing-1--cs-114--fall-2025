void checkGameState() {
  if (checkWin(currentPlayer)) {
    // *** REQUIRED: Report Win ***
    println("\n");
    println(currentPlayer + " HAS WON THE GAME !!!");
    println("Press 'R' to reset.");
    gameOver = true;
  } else if (isBoardFull()) {
    // *** REQUIRED: Report Draw / No Winner ***
    println("\n");
    println(" NO ONE HAS WON. IT'S A DRAW!"); // Report draw
    println("Press 'R' to reset.");
    gameOver = true;
  }
}

// --- Helper and Drawing Functions ---

boolean checkWin(char player) {
  // Check rows and columns
  for (int i = 0; i < gridSize; i++) {
    if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
    if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
  }
  // Check diagonals
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
  if (board[2][0] == player && board[1][1] == player && board[0][2] == player) return true;
  return false;
}

boolean isBoardFull() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (board[i][j] == ' ') return false;
    }
  }
  return true;
}

void printBoard() {
  println("Current Board (0-8 Keys):");
  for (int j = 0; j < gridSize; j++) {
    String row = "|";
    for (int i = 0; i < gridSize; i++) {
      char marker = board[i][j];
      // Display the marker or the key number if empty
      row += " " + (marker == ' ' ? (i + j * 3) : marker) + " |"; 
    }
    println(row);
  }
}

void drawGrid() {
  stroke(0);
  strokeWeight(3);
  line(cellSize, 0, cellSize, height);
  line(cellSize * 2, 0, cellSize * 2, height);
  line(0, cellSize, width, cellSize);
  line(0, cellSize * 2, width, cellSize * 2);
}

void drawMarkers() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      float x = i * cellSize + cellSize / 2;
      float y = j * cellSize + cellSize / 2;
      char marker = board[i][j];
      
      if (marker == 'X') {
        drawX(x, y);
      } else if (marker == 'O') {
        drawO(x, y);
      }
    }
  }
}

void drawX(float x, float y) {
  float r = cellSize / 3.5; 
  stroke(200, 0, 0); 
  strokeWeight(5);
  line(x - r, y - r, x + r, y + r);
  line(x + r, y - r, x - r, y + r);
}

void drawO(float x, float y) {
  float r = cellSize / 3.5; 
  stroke(0, 0, 200); 
  strokeWeight(5);
  noFill();
  ellipse(x, y, r * 2, r * 2);
}

void resetBoard() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      board[i][j] = ' '; 
    }
  }
   gameOver = false;
  currentPlayer = 'X'; 
  
  // CONSOLE REPORTING: Game Start/Reset
  println("GAME RESET: TIC-TAC-TOE");
  println("Player O uses keys 0-8 for positions:");
  println(" Computer X's turn"); 
  printBoard();
}
