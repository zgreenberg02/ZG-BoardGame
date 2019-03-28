import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Desktop; 
import java.io.File; 
import java.io.IOException; 
import java.util.Iterator; 
import java.awt.Polygon; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class boardGame extends PApplet {





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
  
  img = loadImage("gameBoard.jpg");
  img.resize(0, height);
  createRegions();
  players.add(new Player("Player 1", color(0xffF05244)));
  players.add(new Player("Player 2", color(0xff63E558)));
  players.add(new Player("Player 3", color(0xff5968E8)));
  players.add(new Player("Player 4", color(0xffF0E744)));

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
    rules();
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
        numberLimit = PApplet.parseInt(players.get(turn).getWheat()/2);
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
    if (round(random(1, diceSides+.1f)) >= hitLimit ) {
      hits ++;
    }
  }
  return hits;
}
public class Button {
  private int x ; // x position
  private int y; // y position
  private int w; //width
  private int h; // height
  private int r; //rounding
  private int c;
  private int pressedColor;
  private int hoverColor;
  private boolean depressed = false;
  private String text;
  private int textColor;
  private int textSize;
  private boolean released;

  public Button(int x, int y, int w, int h, int r, int c, int pressedColor, int hoverColor)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.c = c;
    this.hoverColor = hoverColor;
    this.pressedColor = pressedColor;
  }
 // public Button(){}

  public void setText(String text, int textColor, int textSize) {
    this.text = text;
    this.textColor = textColor;
    this.textSize = textSize;
  }

  public void display() {
    if (mousePressed &&mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      depressed = true;
    } else {
      depressed = false;
    }

    noStroke();
    if (depressed) {
      fill(pressedColor);
    } else if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      fill(hoverColor);
    } else {
      fill(c);
    }
    rectMode(CENTER);
    rect(x, y, w, h, r);
    textAlign(CENTER, CENTER);
    if (text != null) {
      fill(textColor);
      textSize(textSize);
      text(text, x, y);
    }
  }
  public boolean depressed(){
    return depressed;
  }
  public boolean released() {
    return released;
  }
  public void setReleased(boolean released) {
    this.released = released;
  }
  
  
}
public class Castle extends Structure {

  public Castle(int c, Region location, int quantity){
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }
  public void display(){
    fill(c);
    noStroke();
    rectMode(CENTER);
    rect(location.getCastleX(),location.getCastleY(),15,15);
    if (quantity > 1) {
      fill(0);
      textSize(12);
      text(quantity, location.getCastleX(), location.getCastleY()-1);
    }
  }

}


public class Player {

  private String name;
  private int c;
  private int wood = 4;
  private int ore = 4;
  private int wheat = 4;
  private ArrayList <Troop> troops = new ArrayList<Troop>();
  private ArrayList <Structure> structures = new ArrayList<Structure>();

  public Player(String name, int c) {
    this.name = name;
    this.c = c;
  }
  public String getName(){
    return name;
  }
  public int getColor() {
    return c;
  }
  public int getWood() {
    return wood;
  }
  public void setWood(int wood) {
    this.wood = wood;
  }
  public int getOre() {
    return ore;
  }
  public void setOre(int ore) {
    this.ore = ore;
  }
  public int getWheat() {
    return wheat;
  }
  public void setWheat(int wheat) {
    this.wheat = wheat;
  }
  public void move(Troop troop, int quantity, Region location) {
  }
  public void collectRecources() {
    for (Structure s : structures) {
      if (s != null) {
        switch (s.collectRecources()) {
        case "wheat":
          if (s instanceof Castle) {
            wheat+=2*s.getQuantity();
          } else {
            wheat+= s.getQuantity();
          }
          break;
        case "wood":
          if (s instanceof Castle) {
            wood+=2*s.getQuantity();
          } else {
            wood+=s.getQuantity();
          }
          break;
        case "ore":
          if (s instanceof Castle) {
            ore+=2*s.getQuantity();
          } else {
            ore+= s.getQuantity();
          }
          break;
        }
      }
    }
  }
  public void build(Structure building) {
    boolean same = false;
    for (Structure s : structures) {
      if (s.getLocation() == building.getLocation() && s.getClass() == building.getClass() && !same) {
        s.addStructure(building.getQuantity() );
        same = true;
      }
    }
    if (!same) {
      structures.add(building);
    }
  }

  public void removeStructures(Region r) {
    Iterator itr = structures.iterator();
     while (itr.hasNext()) {
      Structure s = (Structure)itr.next();
      if (s.getLocation() == r) {
        itr.remove();
      }
    }

  }


  public void trainTroops(Region location, int quantity) {
    boolean same = false;
    
    for (Troop t : troops) {
      if (t.getLocation() == location && !same) {
        t.addTroops(quantity);
        same = true;
      }
    }
    if (!same) {
      troops.add(new Troop(c, location, quantity));
    }
    Iterator itr = troops.iterator();
    while (itr.hasNext()) {
      Troop t = (Troop)itr.next();
      if (t.getQuantity() < 1) {
        itr.remove();
      }
    }
  }
  public void moveTroops(Region r1, Region r2, int num ) {
    if (num > 0) {
      trainTroops(r1, -num);
      trainTroops(r2, num);
    }
  }

  public boolean inhabits(Region r) {
    if (hasTroops(r)|| hasStructuresIn(r)) {
      return true;
    } else {
      return false;
    }
  }
  public boolean hasTroops(Region r) {
    for (Troop t : troops) {
      if (t.getLocation() == r ) {
        return true;
      }
    }
    return false;
  }
  public int troopsIn(Region r) {
    int num = 0;
    for (Troop t : troops) {
      if (t.getLocation() == r ) {
        num += t.getQuantity();
      }
    }
    return num;
  }
  public boolean hasStructuresIn(Region r) {
    for (Structure s : structures) {
      if (s.getLocation() == r ) {
        return true;
      }
    }
    return false;
  }
  public boolean hasStructures() {
    
      if (structures.isEmpty()) {
        return false;
      }
    return true;
  }
  public boolean hasTroops() {
    
      if (troops.isEmpty()) {
        return false;
      }
    return true;
  }
  public boolean hasUnits() {
    if (troops.isEmpty() && structures.isEmpty() ) {
      return false;
    }
    else{
    return true;
    }
  }
  public void displayUnits() {
    for (Structure s : structures) {
      s.display();
    }
    for (Troop t : troops) {
      t.display();
    }
  }
}


public class Region {

  Polygon shapeHolder = new Polygon();
  private int points = 0;
  private String type;
  private PShape shape;
  private boolean depressed = false;
  private boolean released = false;
  private boolean selected;
  private int CastleX;
  private int CastleY;
  private int troopX;
  private int troopY;
  private int villageX;
  private int villageY;
  private int number;
  private ArrayList <Integer> connections = new ArrayList<Integer>();
  
  public Region(String type, int number){ 
    this.type = type;
    this.number = number;
  }


  public void addVertex(int x, int y) {
    shapeHolder.addPoint(x, y);
    points++;
  }
  public void addConnection(int num) {
    connections.add(num);
  }
  public void setSelected(boolean sel){
    selected = sel;
  }
  public void display() {
    if (contains(mouseX, mouseY)&& mousePressed) {
      depressed = true;
      stroke(0);
      strokeWeight(4);
    } else if (contains(mouseX, mouseY)) {
      strokeWeight(3);
      stroke(0);
      depressed = false;
    } else {
      depressed = false;
      noStroke();
    }
    if(selected){
      stroke(0);
      strokeWeight(3);
    }
    noFill();
    shape = createShape();
    shape.beginShape();
    int[] xPoints = shapeHolder.xpoints; 
    int[] yPoints = shapeHolder.ypoints;
    for (int i = 0; i < points; i++) {
      shape.vertex(xPoints[i], yPoints[i]);
    }
    shape.endShape(CLOSE);
    shape(shape);
  }
  public boolean contains(int x, int y) {
    return shapeHolder.contains(x, y);
  }
  public String getType() {

    return type;
  }

  public boolean depressed() {
    return depressed;
  } 
  public boolean released() {
    return released;
  }
  public void setReleased(boolean released) {
    this.released = released;
  }
  public boolean nextTo(Region r) {
    if(connections.contains(r.number) ){
      return true;
    }else{
      return false;
    }
  }
  public void setUnitDisplayCords(int CastleX,int CastleY,int troopX,int troopY,int villageX,int villageY) {
    this.CastleX = CastleX;
    this.CastleY = CastleY;
    this.troopX = troopX;
    this.troopY = troopY;
    this.villageX = villageX;
    this.villageY = villageY;
  }
  //public int getNumber(){
  //  return number;
  //}
  public int getTroopX(){
    return troopX;
  }
  public int getTroopY(){
    return troopY;
  }
  
  public int getCastleX(){
    return CastleX;
  }
  public int getCastleY(){
    return CastleY;
  }
  public int getVillageX(){
    return villageX;
  }
  public int getVillageY(){
    return villageY;
  }
}
class Spinner {

 

  private int x ; // x position
  private int y; // y position
  private int number = 0;
  private boolean upDepressed;
  private boolean downDepressed;
  

 public Spinner(int x, int y) {
   this.x = x;
   this.y = y;
   
 }

  public void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, 55, 30, 5);
    fill(0);
    if(upDepressed){
      fill(150);
    }else{
      fill(0);
    }
    triangle(x+13, y-2, x+25, y-2, x+19, y-12);
    if(downDepressed){
      fill(150);
    }else{
      fill(0);
    }
    triangle(x+13, y+1, x+25, y+1, x+19, y+12);
    textSize(18);
    textAlign(CENTER,CENTER);
    fill(0);
    text(number, x - 2, y -2 );
    

    if (mousePressed && mouseY > y - 15 && mouseY < y && mouseX > x + 10  && mouseX < x + 27) {
      upDepressed = true;
    } else {
      upDepressed = false;
    }
    if (mousePressed &&mouseY > y  && mouseY < y + 15 && mouseX > x + 10  && mouseX < x + 27) {
      downDepressed = true;
    } else {
      downDepressed = false;
    }

    //noStroke();
    //if (depressed) {
    //  fill(pressedColor);
    //} else if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
    //  fill(hoverColor);
    //} else {
    //  fill(c);
    //}
    //rectMode(CENTER);
    //rect(x, y, w, h, r);
    //textAlign(CENTER, CENTER);
    //if (text != null) {
    //  fill(textColor);
    //  textSize(textSize);
    //  text(text, x, y);
    //}
  }
  public boolean upDepressed() {
    return upDepressed;
  }
   public boolean downDepressed() {
    return downDepressed;
  }
  
  public void addNumber(int num){
    number += num;
  }
  public int getNumber(){
    return number;
  }
  public void setNumber(int num){
   number = num; 
  }
}

public abstract class Structure {

  int c;
  Region location;
  int quantity;

  
  public abstract void display();
  
  public String collectRecources(){
    return location.getType();
  }
  
  
  
  public int getQuantity() {
    return quantity;
  }
  
  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }
  public void addStructure(int quantity) {
    this.quantity += quantity;
  }
  public Region getLocation() {
    return location;
  }
}

public class Troop {
  private int c;
  private Region location;
  private int quantity;

  public Troop(int c, Region location, int quantity) {
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }
  public Region getLocation() {
    return location;
  }

  public void setLocation(Region location) {
    this.location = location;
  }
  public Region getLocation(Region location) {
    return location;
  }
  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }
  public void addTroops(int quantity) {
    this.quantity += quantity;
  }
  public void display() {
    if (location != null && quantity >0 ) {
      noStroke();
      fill(c);
      ellipse(location.getTroopX(), location.getTroopY(), 15, 15);
      textAlign(CENTER, CENTER);
      if (quantity > 1) {
        fill(0);
        textSize(12);
        text(quantity, location.getTroopX(), location.getTroopY()-1);
      }
    }
  }
}

public class Village extends Structure {

  Village(int c, Region location, int quantity) {
    this.c = c;
    this. location = location;
    this.quantity = quantity;
  }
  public void display() {
    fill(c);
    noStroke();
    int x = location.getVillageX();
    int y = location.getVillageY();
    triangle(x, y-9, x+9, y+9, x-9, y+9);
    if (quantity > 1) {
      fill(0);
      textSize(11);
      text(quantity, x, y);
    }
  }
}
  public void settings() {  size(927, 750); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "boardGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
