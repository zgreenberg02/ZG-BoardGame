/**
 * Framework for castles and villages
 */
public abstract class Structure {

  color c;
  Region location;
  int quantity;

  /**
   * forces castles and villages to display the structure
   */
  public abstract void display();

  /**
   * Gets the type of recource it collects
   * @return String type of recources it collects
   */
  public String collectRecources() {
    return location.getType();
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
  public void addStructure(int quantity) {
    this.quantity += quantity;
  }

  /**
   * Gets the location
   * @return Region the location of the structure
   */
  public Region getLocation() {
    return location;
  }
}