public class City extends Structure {

  public City(color c, Region location){
    this.c = c;
    this.location = location;
    
  }
  
  public String collectRecources(){
    
    return location.getType();
  }
  
  public void display(){
    
  }

}
