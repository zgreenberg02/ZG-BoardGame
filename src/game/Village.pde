
public class Village extends Structure {

  Village(color c, Region location, int quantity) {
    this.c = c;
    this. location = location;
    this.quantity = quantity;
  }

  public String collectRecources() {

    return location.getType();
  }
  public void display() {
    fill(c);
    int x = location.getVillageX();
    int y = location.getVillageY();
    triangle(x,y-5,x+5,y+5,x-5,y+5);
  }
}