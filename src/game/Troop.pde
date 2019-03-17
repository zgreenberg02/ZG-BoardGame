
public class Troop {
  private color c;
  private Region location;
  private int quantity;
  
  public Troop(color c, Region location, int quantity){
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

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }
  public void addTroops(int quantity){
    this.quantity += quantity;
  }
  public void display(){
    fill(c);
    ellipse(location.getTroopX(), location.getTroopY(),10,10);
  }

  
  
  
  
}