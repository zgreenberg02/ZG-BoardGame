import java.awt.Polygon;

public class Region {

  Polygon shapeHolder = new Polygon();
  private int points = 0;
  private String type;
  private PShape shape;
  private boolean depressed = false;
  private boolean released = false;
  private int cityX;
  private int cityY;
  private int troopX;
  private int troopY;
  private int villageX;
  private int villageY;
  private int number;
  
  public Region(String type, int number){ 
    this.type = type;
    this.number = number;
  }


  public void addVertex(int x, int y) {
    shapeHolder.addPoint(x, y);
    points++;
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

  public void setUnitDisplayCords(int cityX,int cityY,int troopX,int troopY,int villageX,int villageY) {
    this.cityX = cityX;
    this.cityY = cityY;
    this.troopX = troopX;
    this.troopY = troopY;
    this.villageX = villageX;
    this.villageY = villageY;
  }
  public int getTroopX(){
    return troopX;
  }
  public int getTroopY(){
    return troopY;
  }
  public int getCityX(){
    return cityX;
  }
  public int getCityY(){
    return cityY;
  }
  public int getVillageX(){
    return villageX;
  }
  public int getVillageY(){
    return villageY;
  }
}
