class Spinner {

 

  private int x ; // x position
  private int y; // y position
  private int number = 0;
  private boolean upDepressed;
  private boolean downDepressed;
  

 public Spinner(int x, int y) {
   this.x = x;
   this.y = y;
   
 }

  public void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, 55, 30, 5);
    fill(0);
    if(upDepressed){
      fill(150);
    }else{
      fill(0);
    }
    triangle(x+13, y-2, x+25, y-2, x+19, y-12);
    if(downDepressed){
      fill(150);
    }else{
      fill(0);
    }
    triangle(x+13, y+1, x+25, y+1, x+19, y+12);
    textSize(18);
    textAlign(CENTER,CENTER);
    fill(0);
    text(number, x - 2, y -2 );
    

    if (mousePressed && mouseY > y - 15 && mouseY < y && mouseX > x + 10  && mouseX < x + 27) {
      upDepressed = true;
    } else {
      upDepressed = false;
    }
    if (mousePressed &&mouseY > y  && mouseY < y + 15 && mouseX > x + 10  && mouseX < x + 27) {
      downDepressed = true;
    } else {
      downDepressed = false;
    }

    //noStroke();
    //if (depressed) {
    //  fill(pressedColor);
    //} else if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
    //  fill(hoverColor);
    //} else {
    //  fill(c);
    //}
    //rectMode(CENTER);
    //rect(x, y, w, h, r);
    //textAlign(CENTER, CENTER);
    //if (text != null) {
    //  fill(textColor);
    //  textSize(textSize);
    //  text(text, x, y);
    //}
  }
  public boolean upDepressed() {
    return upDepressed;
  }
   public boolean downDepressed() {
    return downDepressed;
  }
  
  public void addNumber(int num){
    number += num;
  }
  public int getNumber(){
    return number;
  }
  public void setNumber(int num){
   number = num; 
  }
}