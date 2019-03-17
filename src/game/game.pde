PImage img; //<>//
String menu = "start";
Region[] regions = new Region[18];
Button[] buttons = new Button[8];
ArrayList <Player> players  = new ArrayList <Player>();
Region test = new Region();
PShape shape;
boolean started = false;
boolean selectActions = false;
boolean alreadySelected = false;
int turn = 0;

public void setup() {

  size(927, 750);
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
  players.add(new Player("player 1", color(255, 0, 0)));
  players.add(new Player("player 2", color(0, 255, 0)));
}

public void draw() {
  displayBoard();
  if (menu.equals("start")) {
    startMenu();
  } else if (menu.equals("setup")) {
    gameSetupMenu();
  } else if (menu.equals("board")) {
    displayBoard();
    game();
    for (Region r : regions) {
      r.setReleased(false);
    }
  } else if (menu.equals("instructions")) {
    instructionsMenu();
  } for (Button b : buttons) {
      if(b != null){
         b.setReleased(false);
      }
     
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
    } else {
      String[] points = str.split(" ");
      regions[regionNumber].addVertex(Integer.parseInt(points[0]), Integer.parseInt(points[1]));
    }
  }
  regionNumber = 0;
  lines = loadStrings("unitDisplayCords.txt");
  for (String str : lines) {
    if (str.equals("")) {
      regionNumber++;
    } else {
      String[] points = str.split(" ");
      regions[regionNumber].setUnitDisplayCords(Integer.parseInt(points[0]), Integer.parseInt(points[1]), Integer.parseInt(points[2]), Integer.parseInt(points[3]), Integer.parseInt(points[4]), Integer.parseInt(points[5])  );
    }
  }
}

public void startMenu() {
  for (int i = 0; i < 3; i++) {
    buttons[i] = new Button(width/2, height/2 + 50 + 115 *i, 300, 50, 20, color(0), color(150), color(100));
  }
  buttons[0].setText("New Game", color(255, 0, 0), 30);
  buttons[1].setText("How To Play", color(255, 0, 0), 30);
  buttons[2].setText(" ", color(255, 0, 0), 30); 


  background(200);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(60);
  text("KINGDOMS AND KNIGHTS", width/2, 200);
  for (int i = 0; i < 3; i++) {
    buttons[i].display();
  }
  if (buttons[0].released()) { //<>//
    menu = "setup"; //<>//
  } else if (buttons[1].released()) {
    menu = "instructions";
  }
}

public void instructionsMenu() {
  buttons[3] = new Button(width/2, height - 100, 130, 30, 20, color(0), color(150), color(100));
  buttons[3].setText("Return To Start", color(255, 0, 0), 15);
  background(200);
  buttons[3].display();
  textAlign(CENTER, CENTER);
  fill(0, 0, 0);
  textSize(40);
  text("How to Play", width/2, 60);
  textSize(15);
  text("(add rules here)", width/2, 150);
  rectMode(CENTER);
  rect(width/2, 90, 350, 4);

  if (buttons[3].released()) {
    menu = "start";
  }
}
public void gameSetupMenu() {
  buttons[4] = new Button(width/2, height - 50, 130, 30, 20, color(0), color(150), color(100));
  buttons[4].setText("Start", color(255, 0, 0), 15);
  background(200);
  buttons[4].display();
  //Spinner test = new Spinner(400,400,1);
  //test.display();

  if (buttons[4].released()) {
    menu = "board";
  }
}

public void displayBoard() {
  buttons[5] = new Button(830, 100, 130, 30, 20, color(0), color(150), color(100));
  buttons[5].setText("Move Troops", color(255, 0, 0), 15);
  buttons[6] = new Button(830, 140, 130, 30, 20, color(0), color(150), color(100));
  buttons[6].setText("Train Troops", color(255, 0, 0), 15);
  buttons[7] = new Button(830, 180, 130, 30, 20, color(0), color(150), color(100));
  buttons[7].setText("Build Structures", color(255, 0, 0), 15);
  image(img, 0, 0);
  for (Region r : regions) {
    r.display();
  }
  for (Player p : players) {
    p.displayUnits();
  }
  
  if(selectActions){
    buttons[5].display();
    buttons[6].display();
    buttons[7].display();
  }
  
}
public Region selectRegion() {
  for (Region r : regions) {
    if (r.released()) {
      return r;
    }
  }
  return null;
}

public void game() {
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);
  if (!started) { 
    text("Player " + (turn+1), 700, 40);
    if(alreadySelected){
      text("Select a Different Region", 700, 80);
      text("Already Selected", 700, 60);
    }else{
      text("Select a Starting Region", 700, 60);
    }
    Region selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (playerInhabits(selectedRegion) == players.get(turn) || playerInhabits(selectedRegion) == null) {
        alreadySelected = false;
        players.get(turn).build(new City(players.get(turn).getColor(), selectedRegion, 2));   // for testing
        players.get(turn).build(new Village(players.get(turn).getColor(), selectedRegion, 1));
        players.get(turn).trainTroops(selectedRegion, 3);
        if (turn == players.size() - 1) {
          started = true;
          turn = 0;
          selectActions = true;
        }else {
          turn++;
        }
      }else{
         alreadySelected = true;
      }
    }
  }else{
    text("Player " + (turn+1), 700, 40);
    if(selectActions){
      text("Select an Action:", 700, 60);
    }
    
    
  }
}
public Player playerInhabits(Region r) {
  for (Player p : players) {
    if (p.inhabits(r)) {
      return p;
    }
  }
  return null;
}


void mouseReleased() {
  for (Region r : regions) {
    if (r.depressed()) {
      r.setReleased(true);
    }
  }
  for (Button b : buttons) { //<>//
    if(b != null){
      if (b.depressed()) { //<>//
      b.setReleased(true); //<>//
    }
    }
  }
}
