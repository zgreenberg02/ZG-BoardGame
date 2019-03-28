import java.awt.Desktop; //<>//
import java.io.File;
import java.io.IOException;

PImage img;
String menu = "start";
Region[] regions = new Region[18];
Button[] buttons = new Button[11];
Spinner selectNumber;
Spinner selectPlayers;
ArrayList <Player> players  = new ArrayList <Player>();
PShape shape;
boolean started = false;
boolean selectActions = false;
boolean selectingError = false;
boolean move = false;
boolean train = false;
boolean build = false;
boolean selectingRegion = true;
boolean selectingRegion2 = false;
boolean choosingNumber = false;
boolean selectStructure = false;
int turn = 0;
int numberLimit;
Region selectedRegion;
Region selectedRegion2;
final int diceSides = 10;
final int hitLimit = 8;

public void setup() {
  size(927, 750);
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
  players.add(new Player("Player 1", color(#F05244)));
  players.add(new Player("Player 2", color(#63E558)));
  players.add(new Player("Player 3", color(#5968E8)));
  players.add(new Player("Player 4", color(#F0E744)));

  buttons[0] = new Button(width/2, height/2 + 95, 300, 50, 20, color(0), color(150), color(100));
  buttons[0].setText("Start Game", color(255, 0, 0), 30);
  //width/2, height/2 + 50 + 115 *i, 300, 50, 20, color(0), color(150), color(100)
  buttons[1] = new Button(width/2, height/2 + 280, 300, 50, 20, color(0), color(150), color(100));
  buttons[1].setText("Rules", color(255, 0, 0), 30);

  buttons[2] = new Button(90, 670, 130, 30, 20, color(0), color(150), color(100));
  buttons[2].setText("Rules", color(255), 17);
  buttons[3] = new Button(width/2, height - 100, 130, 30, 20, color(0), color(150), color(100));
  buttons[3].setText("Return To Start", color(255, 0, 0), 15);
  buttons[4] = new Button(90, 200, 130, 30, 20, color(0), color(150), color(100));
  buttons[4].setText("None", color(255), 15);
  buttons[5] = new Button(90, 105, 130, 30, 20, color(0), color(150), color(100));
  buttons[5].setText("Move Troops", color(255), 15);
  buttons[6] = new Button(90, 145, 130, 30, 20, color(0), color(150), color(100));
  buttons[6].setText("Train Troops", color(255), 15);
  buttons[7] = new Button(90, 185, 130, 30, 20, color(0), color(150), color(100));
  buttons[7].setText("Build Structures", color(255), 15);
  buttons[8] = new Button(120, 120, 50, 30, 20, color(0), color(150), color(100));
  buttons[8].setText("ok", color(255), 15);
  buttons[9] = new Button(90, 120, 130, 30, 20, color(0), color(150), color(100));
  buttons[9].setText("Village", color(255), 15);
  buttons[10] = new Button(90, 160, 130, 30, 20, color(0), color(150), color(100));
  buttons[10].setText("Castle", color(255), 15);

  selectNumber = new Spinner(50, 120);
  selectPlayers = new Spinner(550, 550);
  selectPlayers.setNumber(2);
  numberLimit = 4;
}

public void draw() {
  if (menu.equals("start")) {
    startMenu();
  }else if (menu.equals("board")) {
    displayBoard();
    game();
    for (Region r : regions) {
      r.setReleased(false);
    }
  } else if (menu.equals("end")) {
    displayBoard();
    end();
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
      regions[i] = new Region("wood", i +1);
    } else if (i < 12) {
      regions[i] = new Region("ore", i+1);
    } else if (i < 18) {
      regions[i] = new Region("wheat", i+1);
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
  regionNumber = 0;
  lines = loadStrings("connectingRegions.txt");
  for (String str : lines) {
    if (str.equals("")) {
      regionNumber++;
    } else {
      String[] connections = str.split(" ");
      for (String s : connections ) {
        regions[regionNumber].addConnection(Integer.parseInt(s));
      }
    }
  }
}

public void startMenu() {


  background(200);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(60);
  text("KINGDOMS AND KNIGHTS", width/2, 230);
  fill(0);
  textSize(20);
  textAlign(RIGHT, CENTER);
  text("Number of Players: ",520, 545);
  buttons[0].display();
  buttons[1].display();

  
  selectPlayers.display();
  
  if (buttons[0].released()) {
    menu = "board";
    if(selectPlayers.getNumber() == 2){
      players.remove(3);
      players.remove(2);
    }else if(selectPlayers.getNumber() == 3){
      players.remove(2);
    }
  } else if (buttons[1].released()) {
    rules();
  }
}
public void end() {
  textAlign(CENTER, CENTER);
  fill(0, 0, 0);
  textSize(40);
  if (players.size() == 0) {
    text("It is a tie", width/2, 15);
  } else {
    fill(players.get(turn).getColor());
    text(players.get(turn).getName() + " Wins", width/2, 15);
  }
}
public void rules() {
  try { 
    Desktop desktop = Desktop.getDesktop();
    File file = new File(dataPath("") + "/rules.txt");
    if (file.exists()) {
      desktop.open(file);
    }
  }
  catch(IOException e) {
  }
}

public void displayBoard() {
  image(img, 0, 0);
  for (Region r : regions) {
    if (r == selectedRegion) {
      r.setSelected(true);
    } else {
      r.setSelected(false);
    }
  }
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
  if (choosingNumber) {
    buttons[8].display();
    selectNumber.display();
  }
  if (selectStructure) {
    buttons[10].display();
    buttons[9].display();
    buttons[4].display();
  }
  buttons[2].display();
  if (buttons[2].released()) {
    rules(); //<>//
    delay(0);
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

  selectedRegion = null;
  Iterator itr = players.iterator();
  while (itr.hasNext()) {
    Player p = (Player)itr.next();
    if (!p.hasUnits()) {
      itr.remove();
    }
  }

  if (players.size() <= 1) {  
    menu = "end";
    selectActions = false;
  } else {

    if (turn >= players.size() - 1) {
      turn = 0;
      selectActions = true;
      players.get(turn).collectRecources();
    } else {
      turn++;
      selectActions = true;
      players.get(turn).collectRecources();
    }
  }
  move = false;
  train = false;
  build = false;
}

public void game() {
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);
  if (!started) { 
    fill(players.get(turn).getColor());
    text(players.get(turn).getName(), 20, 40);
    fill(255);
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


    fill(0);
    noStroke();
    rectMode(CENTER);
    rect(750, 690, 15, 15);
    int x = 750;
    int y = 650;
    triangle(x, y-9, x+9, y+9, x-9, y+9);
    ellipse(750, 620, 15, 15);
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(18);
    text("Costs", 795, 588);
    textSize(14);
    text("- Troop:  2 Wheat", 760, 617);
    text("- Village:  1 Wheat", 760, 647);
    text("2 Wood", 830, 664);
    text("- Castle:  3 Wood", 760, 687);
    text("4 Ore", 827, 704);

    textSize(18);
    fill(players.get(turn).getColor());
    text(players.get(turn).getName(), 20, 40);
    text(players.get(turn).getName() +" Recources", 730, 40);
    fill(255);
    text("Wheat:  " + players.get(turn).getWheat(), 767, 73);
    text("Wood:   " + players.get(turn).getWood(), 767, 95);
    text("Ore:      " + players.get(turn).getOre(), 767, 117);
    stroke(0);
    strokeWeight(4);

    line(730, 57, 895, 57);
    line(733, 602, 895, 602);

    if (selectActions) {
      text("Select an Action", 20, 60);
      line(20, 77, 160, 77);
      if (buttons[5].released()) {
        selectActions = false;
        move = true;
        selectingRegion = true;
      } else if (buttons[6].released()) {
        if (players.get(turn).hasStructures() ) {
          selectActions = false;
          train = true;
          selectingRegion = true;
        }
      } else if (buttons[7].released()) {
        if (players.get(turn).hasTroops()) {
          selectActions = false;
          build = true;
          selectingRegion = true;
        }
      }
    } else if (move) {
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
public void move() {

  if (selectingRegion) {
    text("Select a Region to Move", 20, 60);
    text("Troops From", 20, 80);
    selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (players.get(turn).hasTroops(selectedRegion)) {
        numberLimit = players.get(turn).troopsIn(selectedRegion);
        selectingRegion = false;
        choosingNumber = true;
        selectNumber.setNumber(0);
      }
    }
  } else if (choosingNumber) {
    text("Select the number of", 20, 60);
    text("Troops to Move", 20, 80);
    if (buttons[8].released()) {
      choosingNumber = false;
      selectingRegion2 = true;
    }
  } else if (selectingRegion2) {
    text("Select a Region to Move", 20, 60);
    text("Troops to", 20, 80);
    selectedRegion2 = selectRegion();
    if (selectedRegion2 != null) {
      if (selectedRegion2.nextTo(selectedRegion)) {
        if (playerInhabits(selectedRegion2) == players.get(turn) || playerInhabits(selectedRegion2) == null ) {

          players.get(turn).moveTroops(selectedRegion, selectedRegion2, selectNumber.getNumber());
          selectingRegion2 = false;
          advanceTurn();
        } else {
          conflict();
          selectingRegion2 = false;
          advanceTurn();
        }
      }
    }
  }
}

public void conflict() {
  int attackingTroops = selectNumber.getNumber();
  int defendingTroops = playerInhabits(selectedRegion2).troopsIn(selectedRegion2);
  while (attackingTroops > 0 && defendingTroops > 0) {
    int attackerHits = attackHits(attackingTroops);
    int defenderHits = attackHits(defendingTroops );
    attackingTroops -= defenderHits;
    defendingTroops -= attackerHits;
  }
  players.get(turn).trainTroops(selectedRegion, -selectNumber.getNumber());
  playerInhabits(selectedRegion2).trainTroops(selectedRegion2, defendingTroops - playerInhabits(selectedRegion2).troopsIn(selectedRegion2) );


  if (attackingTroops > 0 && defendingTroops < 1) {
    playerInhabits(selectedRegion2).removeStructures(selectedRegion2);
    players.get(turn).trainTroops(selectedRegion2, attackingTroops);
  }
}

public void train() {
  if (selectingRegion) {
    text("Select a Region to Train", 20, 60);
    text("Troops In ", 20, 80);

    selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (players.get(turn).hasStructuresIn(selectedRegion)) {
        selectingRegion = false;
        choosingNumber = true;
        numberLimit = int(players.get(turn).getWheat()/2);
        selectNumber.setNumber(0);
      }
    }
  } else if (choosingNumber) { 
    text("Select the number of", 20, 60);
    text("Troops to Train", 20, 80);

    if (buttons[8].released()) {
      if (selectNumber.getNumber() > 0) {
        players.get(turn).trainTroops(selectedRegion, selectNumber.getNumber());
        players.get(turn).setWheat(players.get(turn).getWheat() - 2*selectNumber.getNumber() );
      }
      choosingNumber = false;
      advanceTurn();
    }
  }
}
public void build() {
  if (selectingRegion) {
    text("Select a Region to", 20, 70);
    text("Build In ", 20, 90);

    selectedRegion = selectRegion();
    if (selectedRegion != null) {
      if (players.get(turn).hasTroops(selectedRegion)) {
        selectingRegion = false;
        selectStructure = true;
      }
    }
  } else if (selectStructure) {
    text("Select a Structure to", 20, 60);
    text("Build", 20, 80);
    if (buttons[9].released() ) {
      if ( players.get(turn).getWheat() > 0 && players.get(turn).getWood() > 1 ) {
        players.get(turn).build(new Village(players.get(turn).getColor(), selectedRegion, 1));
        players.get(turn).setWood(players.get(turn).getWood() - 2 );
        players.get(turn).setWheat(players.get(turn).getWheat() - 1 );
        selectStructure = false;
        advanceTurn();
      }
    } else if (buttons[10].released()) {
      if ( players.get(turn).getOre() > 3 && players.get(turn).getWood() > 2 ) {
        players.get(turn).build(new Castle(players.get(turn).getColor(), selectedRegion, 1));
        players.get(turn).setOre(players.get(turn).getOre() - 4 );
        players.get(turn).setWood(players.get(turn).getWood() - 3 );
        selectStructure = false;
        advanceTurn();
      }
    } else if (buttons[4].released()) {
      selectStructure = false;
      advanceTurn();
    }
  }
}
public void mouseReleased() {
  if (menu.equals("board")) {
    for (Region r : regions) {
      if (r.depressed()) {
        r.setReleased(true);
      }
    }
  }else if(menu.equals("start")){
    if (selectPlayers.upDepressed()) {
      if (selectPlayers.getNumber() < numberLimit) {
        selectPlayers.addNumber(1);
      }
    }
    if (selectPlayers.downDepressed()) {
      if (selectPlayers.getNumber() > 2)

        selectPlayers.addNumber(-1);
    }
  }

  for (Button b : buttons) {
    if (b != null) {
      if (b.depressed()) {
        b.setReleased(true);
      }
    }
  }

  if (choosingNumber) {
    if (selectNumber.upDepressed()) {
      if (selectNumber.getNumber() < numberLimit) {
        selectNumber.addNumber(1);
      }
    }
    if (selectNumber.downDepressed()) {
      if (selectNumber.getNumber() > 0)

        selectNumber.addNumber(-1);
    }
  }
}

public int attackHits(int times) {
  int hits = 0;
  for (int i = 0; i < times; i++) {
    if (round(random(1, diceSides+.1)) >= hitLimit ) {
      hits ++;
    }
  }
  return hits;
}