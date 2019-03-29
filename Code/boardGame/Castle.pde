/**
 * Represents a group of Castles that can be built
 */
public class Castle extends Structure {

  /**
   * Constructs a single or group of castles
   * @param c color of the castle - corresponds to the color of the player that owns it.
   * @param location region where it is located
   * @param quantity number of castles in the group
   */
  public Castle(color c, Region location, int quantity) {
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }

  /**
   * Used to display the castles
   */
  public void display() {
    fill(c);
    noStroke();
    rectMode(CENTER);
    rect(location.getCastleX(), location.getCastleY(), 15, 15);
    if (quantity > 1) {
      fill(0);
      textSize(12);
      text(quantity, location.getCastleX(), location.getCastleY()-1);
    }
  }
}