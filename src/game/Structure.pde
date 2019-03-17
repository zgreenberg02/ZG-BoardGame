
public abstract class Structure {
  
  color c;
  Region location;
  
  public abstract String collectRecources();
  public abstract void display();

  public Region getLocation() {
    return location;
  }
  
  
  
}