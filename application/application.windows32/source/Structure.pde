
public abstract class Structure {

  color c;
  Region location;
  int quantity;

  
  public abstract void display();
  
  public String collectRecources(){
    return location.getType();
  }
  
  
  
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