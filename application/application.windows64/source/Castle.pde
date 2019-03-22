public class Castle extends Structure {

  public Castle(color c, Region location, int quantity){
    this.c = c;
    this.location = location;
    this.quantity = quantity;
  }
  public void display(){
    fill(c);
    noStroke();
    rectMode(CENTER);
    rect(location.getCastleX(),location.getCastleY(),15,15);
    if (quantity > 1) {
      fill(0);
      textSize(12);
      text(quantity, location.getCastleX(), location.getCastleY()-1);
    }
  }

}