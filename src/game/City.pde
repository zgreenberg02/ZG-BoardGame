public class City extends Structure {

  public City(color c, Region location, int quantity){
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }
  
  public String collectRecources(){
    
    return location.getType();
  }

  public void display(){
    fill(c);
    rectMode(CENTER);
    rect(location.getCityX(),location.getCityY(),15,15);
    if (quantity > 1) {
      fill(0);
      textSize(12);
      text(quantity, location.getCityX(), location.getCityY()-1);
    }
  }

}
