/**
 * Represents a group of villages that can be built
 */
public class Village extends Structure {

  /**
   * Constructs a single or group of villages
   * @param c color of the village - corresponds to the color of the player that owns it.
   * @param location region where it is located
   * @param quantity number of villages in the group
   */
  Village(color c, Region location, int quantity) {
    this.c = c;
    this. location = location;
    this.quantity = quantity;
  }

  /**
   * Used to display the villages
   */
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