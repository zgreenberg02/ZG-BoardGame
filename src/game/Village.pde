
public class Village extends Structure {

  Village(color c, Region location) {
    this.c = c;
    this. location = location;
  }

  public String collectRecources() {

    return location.getType();
  }
  public void display() {
  }
}