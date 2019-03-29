import java.awt.Polygon; //<>//

/**
 * Represents one of the 18 regions 
 */
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

  /**
   * Creates the region
   * @param type the type of recource the region has
   * @param number the number of the region
   */
  public Region(String type, int number) { 
    this.type = type;
    this.number = number;
  }

  /**
   * adds a point to the shape of the region
   * @param x x-cordinate of the vertex
   * @param x x-cordinate of the vertex
   */
  public void addVertex(int x, int y) {
    shapeHolder.addPoint(x, y);
    points++;
  }

  /**
   * adds a connection with another region (when 2 regions are adjacent)
   * @param num number of the region it connects with
   */
  public void addConnection(int num) {
    connections.add(num);
  }

  /**
   * Sets if the region is selected
   * @param sel if the region is selected
   */
  public void setSelected(boolean sel) {
    selected = sel;
  }

  /**
   * Displays the region.
   */
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
    if (selected) {
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

  /**
   * Checks if the region contains a point
   * @param x x-cordinate of the point it is checking
   * @param y y-cordinate of the point it is checking
   * @return boolean if the point is in the region
   */
  public boolean contains(int x, int y) {
    return shapeHolder.contains(x, y);
  }

  /**
   * Gets the type of the region
   * @return String type of the region
   */
  public String getType() {

    return type;
  }

  /**
   * Gets if the region is depressed
   * @return boolean if the region is depressed
   */
  public boolean depressed() {
    return depressed;
  } 

  /**
   * Gets if the region is released
   * @return boolean if the region is released
   */
  public boolean released() {
    return released;
  }

  /**
   * Sets if the region is released
   * @param boolean if the region is released
   */
  public void setReleased(boolean released) {
    this.released = released;
  }

  /**
   * Gets if the region is adjacent to another region
   * @param region to check
   * @return boolean if the region is adjacent
   */
  public boolean nextTo(Region r) {
    if (connections.contains(r.number) ) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Sets the points where the units will be displayed in the region
   * @param CastleX x-cordinate of the castle
   * @param CastleY y-cordinate of the castle
   * @param troopX x-cordinate of the troop
   * @param troopY y-cordinate of the troop
   * @param villageX x-cordinate of the village
   * @param villageY y-cordinate of the village
   */
  public void setUnitDisplayCords(int CastleX, int CastleY, int troopX, int troopY, int villageX, int villageY) {
    this.CastleX = CastleX;
    this.CastleY = CastleY;
    this.troopX = troopX;
    this.troopY = troopY;
    this.villageX = villageX;
    this.villageY = villageY;
  }

  /**
   * Gets x-cordinate of where the troops will be displayed
   * @return int x-cordinate of where the troops will be displayed
   */
  public int getTroopX() {
    return troopX;
  }

  /**
   * Gets y-cordinate of where the troops will be displayed
   * @return int y-cordinate of where the troops will be displayed
   */
  public int getTroopY() {
    return troopY;
  }

  /**
   * Gets x-cordinate of where the castles will be displayed
   * @return int x-cordinate of where the castles will be displayed
   */
  public int getCastleX() {
    return CastleX;
  }

  /**
   * Gets y-cordinate of where the castles will be displayed
   * @return int y-cordinate of where the castles will be displayed
   */
  public int getCastleY() {
    return CastleY;
  }

  /**
   * Gets x-cordinate of where the villages will be displayed
   * @return int x-cordinate of where the villages will be displayed
   */
  public int getVillageX() {
    return villageX;
  }

  /**
   * Gets y-cordinate of where the villages will be displayed
   * @return int y-cordinate of where the villages will be displayed
   */
  public int getVillageY() {
    return villageY;
  }
}