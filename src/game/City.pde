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
    rect(location.getCityX(),location.getCityY(),10,10);
  }

}