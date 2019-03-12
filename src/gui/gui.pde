
PImage img;
String menu = "board";
Region[] regions = new Region[18];
Button[] menuButtons = new Button[4];
Region test = new Region();
PShape shape;

public void setup() {

  size(927, 750);
  // surface.setResizable(true);
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
  
  //startMenu Buttons
  for(int i = 0; i < menuButtons.length; i++){
    menuButtons[i] = new Button(width/2 , height/2 + 50 + 115 *i, 300, 50, 20, color(0), color(150), color(100));
  }
  menuButtons[0].setText("New Game", color(255, 0, 0), 30);
  menuButtons[1].setText("How To Play", color(255, 0, 0), 30);
  menuButtons[2].setText(" ", color(255, 0, 0), 30);
  
  //how to play buttons
  menuButtons[3] = new Button(width/2 , height - 100, 130, 30, 20, color(0), color(150), color(100));
  menuButtons[3].setText("Return To Start", color(255, 0, 0),15);
}

public void draw() { //<>// //<>//
  if(menu.equals("start")){
    startMenu();   
  }else if(menu.equals("setup")){
    gameSetupMenu();   
  }else if(menu.equals("board")){
    board();   
  }else if(menu.equals("instructions")){
    instructionsMenu();   
  }else{
    println("error");
  }
}
public void createRegions() {
  int regionNumber = 0;
  for (int i = 0; i < regions.length; i++) {
    regions[i] = new Region();
  }
  String[] lines = loadStrings("regionShapes.txt");
  for (String str : lines) {
    if (str.equals("")) {
      regionNumber++;
    } else { //<>//
      String[] points = str.split(" ");
      regions[regionNumber].addVertex(Integer.parseInt(points[0]),Integer.parseInt(points[1]));
    }
  }
}

public void startMenu() {
 background(200);
 textAlign(CENTER, CENTER);
 fill(255,0,0);
 textSize(60);
 text("Name Of The Game", width/2, 200);
  for (int i = 0; i < 3; i++) {
     menuButtons[i].display();
  }
  if(menuButtons[0].depressed){
    menu = "setup";
  }else if(menuButtons[1].depressed){
    menu = "instructions";
  }
}

public void instructionsMenu() {
 background(200);
 menuButtons[3].display();
 textAlign(CENTER, CENTER);
 fill(0,0,0);
 textSize(40);
 text("How to Play", width/2, 60);
 textSize(15);
 text("(add rules here)", width/2, 150);
 rectMode(CENTER);
 rect(width/2, 90, 350, 4);
 
 if(menuButtons[3].depressed){
    menu = "start";
  }
}
public void gameSetupMenu() {
  background(200);
  Spinner test = new Spinner(400,400,1);
  test.display();
  
}

public void board() {
  image(img, 0, 0);
  for(Region r: regions){
    r.display();
  }
}











//gameSetupMenu(); 