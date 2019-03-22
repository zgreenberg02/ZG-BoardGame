
public class Troop {
  private color c;
  private Region location;
  private int quantity;

  public Troop(color c, Region location, int quantity) {
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