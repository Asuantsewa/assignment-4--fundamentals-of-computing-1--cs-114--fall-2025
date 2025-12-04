void setup() {
  size(500, 500); 
  cellSize = width / gridSize;
  resetBoard();
}

void draw() {
  background(255); 
  drawGrid();
  drawMarkers();
  
  
  if (!gameOver && currentPlayer == 'X') {
    delay(500); 
    computerMove();
  }
}

void keyPressed() {
  int keyNum = key - '0';
  
  if (key == 'r' || key == 'R') {
    resetBoard();
    return;
  }
  
  if (gameOver) {
    println("GAME HAS ENDED. Press 'R' to start a new game.");
    return; // Ignore all other keys if the game is over.
  }

  // Only process input if it's the player's turn ('O')
  if (currentPlayer != 'O') {
      // This case should be rare unless the user presses a key while the computer is thinking.
      println("Wait for the Computer's move (X) to finish.");
      return;
  }
  
  // Check for a valid move key (0 through 8)
  if (keyNum >= 0 && keyNum <= 8) {
    // Calculate board coordinates (row, col) based on the 0-8 mapping:
    int j = keyNum / 3; // Column index
    int i = keyNum % 3; // Row index
    
    // Check if the cell is valid and empty
    if (board[i][j] == ' ') {
      board[i][j] = 'O';
      println("Player O placed O at key " + keyNum);
      printBoard();
      
      checkGameState(); // Check state after move
      if (!gameOver) {
        currentPlayer = 'X'; 
        println("\n Computer X's turn");
      }
    } else {
        println("Key " + keyNum + " is already occupied. Try again.");
    }
  } 
  // Report invalid key press (not 0-8, not R)
  else {
    println("INCORRECT KEY: Please use keys 0 through 8 for your move, or 'R' to reset.");
    println("It is still Player O's turn.");
  }
}

void computerMove() {
  if (gameOver) return;

 // FInding the empty spot
  for (int j = 0; j < gridSize; j++) {
    for (int i = 0; i < gridSize; i++) {
      if (board[i][j] == ' ') {
        board[i][j] = 'X';
        println("Computer X placed X at key " + (i + j * 3));
        printBoard();
        
        checkGameState();
        if (!gameOver) {
          currentPlayer = 'O'; 
          println("\nPlayer O's turn (Keys 0-8) ");
        }
        return; 
      }
    }
  }
}
