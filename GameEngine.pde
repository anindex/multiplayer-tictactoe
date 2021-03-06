enum GameCondition {DRAW, WIN, LOSE, CONTINUE};

class GameEngine
{
  public Grid gameState;
  public Player player;
  
  public Player player1;
  public Player player2;
  
  public MarkedCoordinate lastUpdate;
  
  public boolean inTurned;
  
  public GameEngine(Grid gameState, Player player)
  {
    this.gameState = gameState;
    this.player = player;
    this.lastUpdate = new MarkedCoordinate();
    
    this.player1 = new Player();
    this.player2 = new Player();
    
    this.inTurned = true;
  }
  
  public GameCondition checkEndGame()
  {
    if(inTurned)
    {
      gameState.spaceLeft--;
      
      int w = gameState.cells.length;
      int h = gameState.cells[0].length;
      
      //check y
      int line = 0;
      for(int i = -4; i <= 4; i++)
      {
         if(player.lastMove.y + i >= 0 && player.lastMove.y + i < h)
         {
            if(gameState.cells[player.lastMove.x][player.lastMove.y + i].type == player.markType)
            {
              line++;
              if(line == 5)
              {
                return GameCondition.WIN;
              }
            }
            else
            {
              line = 0;
            }
         }
      }
      
      //check x
      line = 0;
      for(int i = -4; i <= 4; i++)
      {
         if(player.lastMove.x + i >= 0 && player.lastMove.x + i < w)
         {
            if(gameState.cells[player.lastMove.x + i][player.lastMove.y].type == player.markType)
            {
              line++;
              if(line == 5)
              {
                return GameCondition.WIN;
              }
            }
            else
            {
              line = 0;
            }
         }
      }
      
      //check diagonal
      line = 0;
      for(int i = -4; i <= 4; i++)
      {
         if(player.lastMove.x + i >= 0 && player.lastMove.x + i < w && player.lastMove.y + i >= 0 && player.lastMove.y + i < h)
         {
            if(gameState.cells[player.lastMove.x + i][player.lastMove.y + i].type == player.markType)
            {
              line++;
              if(line == 5)
              {
                return GameCondition.WIN;
              }
            }
            else
            {
              line = 0;
            }
         }
      }
      
      //check anti-diagonal
      line = 0;
      for(int i = -4; i <= 4; i++)
      {
         if(player.lastMove.x - i >= 0 && player.lastMove.x - i < w && player.lastMove.y + i >= 0 && player.lastMove.y + i < h)
         {
            if(gameState.cells[player.lastMove.x - i][player.lastMove.y + i].type == player.markType)
            {
              line++;
              if(line == 5)
              {
                return GameCondition.WIN;
              }
            }
            else
            {
              line = 0;
            }
         }
      }
      
      if(gameState.spaceLeft == 0)
      {
        return GameCondition.DRAW;
      }
    }
    
    return GameCondition.CONTINUE;
  }
  
  public void updateCell(Coordinate pos, CellType type)
  {
    gameState.cells[pos.x][pos.y].type = type;
    
    lastUpdate.x = pos.x;
    lastUpdate.y = pos.y;
    lastUpdate.type = type;
    
    player.lastMove = pos;
  }
  
  public void name_change()
  {
    this.player.name = textfield2.getText();
  }
}
