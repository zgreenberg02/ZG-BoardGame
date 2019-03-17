
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
    triangle(x, y-9, x+9, y+9, x-9, y+9);
    if (quantity > 1) {
      fill(0);
      textSize(11);
      text(quantity, x, y);
    }
  }
}
