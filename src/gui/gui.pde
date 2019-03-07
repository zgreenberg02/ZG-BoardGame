
PImage img;
int menu = 0;
Region[] regions = new Region[18];
Region test = new Region();
PShape shape;

public void setup() {

  size(927, 750);
  // surface.setResizable(true);
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
}

public void draw() { //<>//
                                  // uncomment to see desired gui
  //startMenu();                   // start menu
  //board();                     // board
  //instructionsMenu();          // instructions menu
  
}
public void createRegions() {
  int regionNumber = 0;
  for (int i = 0; i < regions.length; i++) {
    regions[i] = new Region();
  }
  String[] lines = loadStrings("regionShapes.txt");
  for (String str : lines) {
    if (str.equals("")) {
      regionNumber++; //<>//
    } else {
      String[] points = str.split(" ");
      regions[regionNumber].addVertex(Integer.parseInt(points[0]),Integer.parseInt(points[1]));
    }
  }
}

public void startMenu() {
  Button[] menuButtons = new Button[3];
  for(int i = 0; i < menuButtons.length; i++){
    menuButtons[i] = new Button(width/2 , height/2 + 50 + 115 *i, 300, 50, 20, color(0), color(150), color(100));
  }
  menuButtons[0].setText("New Game", color(255, 0, 0), 30);
  menuButtons[1].setText("Load Game", color(255, 0, 0), 30);
  menuButtons[2].setText("How To Play", color(255, 0, 0), 30);
 textAlign(CENTER, CENTER);
 fill(255,0,0);
 textSize(60);
 text("Name Of The Game", width/2, 200);


  for (Button buttons : menuButtons) {
    buttons.display();
  }
}

public void instructionsMenu() {
 textAlign(CENTER, CENTER);
 fill(0,0,0);
 textSize(40);
 text("How to Play", width/2, 60);
 rectMode(CENTER);
 rect(width/2, 90, 350, 4);
}
public void GameSetupMenu() {
}

public void board() {
  image(img, 0, 0);
  //regions[0].display();
}











//gameSetupMenu(); 