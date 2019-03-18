// capitilazation  //<>// //<>//
// winning
// trading in recources
// double collection
// enum
PImage img;
String menu = "board";
Region[] regions = new Region[18];
Button[] buttons = new Button[8];
ArrayList <Player> players  = new ArrayList <Player>();
PShape shape;
boolean started = false;
boolean selectActions = false;
boolean selectingError = false;
boolean move = false;
boolean train = false;
boolean build = false;
boolean selectingRegion = true;
int turn = 0;


public void setup() {
  size(927, 750);
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
  players.add(new Player("player 1", color(255, 0, 0)));
  players.add(new Player("player 2", color(0, 255, 0)));

  for (int i = 0; i < 3; i++) {
    buttons[i] = new Button(width/2, height/2 + 50 + 115 *i, 300, 50, 20, color(0), color(150), color(100));
  }
  buttons[0].setText("New Game", color(255, 0, 0), 30);
  buttons[1].setText("How To Play", color(255, 0, 0), 30);
  buttons[2].setText(" ", color(255, 0, 0), 30);
  buttons[3] = new Button(width/2, height - 100, 130, 30, 20, color(0), color(150), color(100));
  buttons[3].setText("Return To Start", color(255, 0, 0), 15);
  buttons[4] = new Button(width/2, height - 50, 130, 30, 20, color(0), color(150), color(100));
  buttons[4].setText("Start", color(255, 0, 0), 15);
  buttons[5] = new Button(90, 105, 130, 30, 20, color(0), color(150), color(100));
  buttons[5].setText("Move Troops", color(255), 15);
  buttons[6] = new Button(90, 145, 130, 30, 20, color(0), color(150), color(100));
  buttons[6].setText("Train Troops", color(255), 15);
  buttons[7] = new Button(90, 185, 130, 30, 20, color(0), color(150), color(100));
  buttons[7].setText("Build Structures", color(255), 15);
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
  } 
  for (Button b : buttons) {
    if (b != null) {
      b.setReleased(false);
    }
  }
}


public void createRegions() {
  int regionNumber = 0;
  for (int i = 0; i < regions.length; i++) {
    if (i < 6) {
      regions[i] = new Region("wood", i);
    } else if (i < 12) {
      regions[i] = new Region("ore", i);
    } else if (i < 18) {
      regions[i] = new Region("wheat", i);
    }
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


  background(200);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(60);
  text("KINGDOMS AND KNIGHTS", width/2, 200);
  for (int i = 0; i < 3; i++) {
    buttons[i].display();
  }
  if (buttons[0].released()) {
    menu = "setup";
  } else if (buttons[1].released()) {
    menu = "instructions";
  }
}

public void instructionsMenu() {
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

  background(200);
  buttons[4].display();
  //Spinner test = new Spinner(400,400,1);
  //test.display();

  if (buttons[4].released()) {
    menu = "board";
  }
}

public void displayBoard() {
  image(img, 0, 0);
  for (Region r : regions) {
    r.display();
  }
  for (Player p : players) {
    p.displayUnits();
  }

  if (selectActions) {
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
public void advanceTurn() {
  if (turn == players.size() - 1) {
    turn = 0;
    selectActions = true;
    players.get(turn).collectRecources();
  } else {
    turn++;
    players.get(turn).collectRecources();
  }
}

public void game() {
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);
  if (!started) { 
    text("Player " + (turn+1), 20, 40);
    if (selectingError) {
      text("Select a Different Region", 20, 80);
      text("Already Selected", 20, 60);
    } else {
      text("Select a Starting Region", 20, 60);
    }
    Region selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (playerInhabits(selectedRegion) == players.get(turn) || playerInhabits(selectedRegion) == null) {
        selectingError = false;
        //players.get(turn).build(new City(players.get(turn).getColor(), selectedRegion, 2));   // for testing
        players.get(turn).build(new Village(players.get(turn).getColor(), selectedRegion, 1));
        players.get(turn).trainTroops(selectedRegion, 3);
        if (turn == players.size() - 1) {
          started = true;
          turn = 0;
          selectActions = true;
          players.get(turn).collectRecources();
        } else {
          turn++;
        }
      } else {
        selectingError = true;
      }
    }
  } else {
    text("Player " + (turn+1), 20, 40);
    text("Player " + (turn+1) +" Recources", 730, 40);
    text("Wheat:  " + players.get(turn).getWheat(), 767, 73);
    text("Wood:   " + players.get(turn).getWood(), 767, 95);
    text("Ore:      " + players.get(turn).getOre(), 767, 117);
    stroke(0);
    strokeWeight(4);

    line(730, 57, 895, 57);


    if (selectActions) {
      text("Select an Action", 20, 60);
      line(20, 77, 160, 77);
      if (buttons[5].released()) {
        selectActions = false;
        move = true;
      } else if (buttons[6].released()) {
        selectActions = false;
        train = true;
      } else if (buttons[7].released()) {
        selectActions = false;
        build = true;
      }
    } else if (move) {                                        ///////
      move();
    } else if (train) {
      train();
    } else if (build) {
      build();
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
public void move() { ///
  text("Select a Region to Move", 20, 60);
  text("Troops Form", 20, 80);
  Region selectedRegion = selectRegion();
  if (selectedRegion != null) {
    if (players.get(turn).hasTroops(selectedRegion)) {          ///

      players.get(turn).trainTroops(selectedRegion, 3); // change to move
      if (turn == players.size() - 1) {
        started = true;
        turn = 0;
        players.get(turn).collectRecources();
        selectActions = true;
      } else {
        turn++;
      }
    } else {
      //conflict
    }
  }
}
public void train() {
  if (selectingRegion) {
    text("Select a Region to Train", 20, 60);
    text("Troops In ", 20, 80);
    if(selectingError){
      text("Select a Valid Region to ", 20, 60);
      text("Train Troops In ", 20, 80);
    }
    Region selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (players.get(turn).hasStrucutres(selectedRegion)) {
          selectingRegion = false;
      } else {
        selectingError = true;
      }
    }
  }else{
    selectingError = false;
    //players.get(turn).trainTroops(selectedRegion, 3); // 
    advanceTurn();
  }
}
public void build() {
}
public void mouseReleased() {
  if (menu.equals("board")) {
    for (Region r : regions) {
      if (r.depressed()) {
        r.setReleased(true);
      }
    }
  }

  for (Button b : buttons) {
    if (b != null) {
      if (b.depressed()) {
        b.setReleased(true);
      }
    }
  }
}
