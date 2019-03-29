/**
 * Represents a troop that can be trained
 */
public class Troop {
  private color c;
  private Region location;
  private int quantity;

  /**
   * creates a troop
   * @param c color of the troop - corresponds with the color of the player that owns it
   * @param location region where it is located
   * @param quantity number of troops in the group
   */
  public Troop(color c, Region location, int quantity) {
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }

  /**
   * Gets the location
   * @return Region the location of the troops
   */
  public Region getLocation() {
    return location;
  }

  /**
   * Sets the location
   * @param location the Region to set
   */
  public void setLocation(Region location) {
    this.location = location;
  }

  /**
   * Gets the quantity
   * @return int quantity
   */
  public int getQuantity() {
    return quantity;
  }

  /**
   * Sets the quantity
   * @param quantity the number to change the quantity to
   */
  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  /**
   * Adds to the quantity
   * @param quantity the number to add to the quantity
   */
  public void addTroops(int quantity) {
    this.quantity += quantity;
  }

  /**
   * Used to display the troops
   */
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