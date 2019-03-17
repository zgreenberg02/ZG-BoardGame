
public abstract class Structure {

  color c;
  Region location;
  int quantity;

  public abstract String collectRecources();
  public abstract void display();
  
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