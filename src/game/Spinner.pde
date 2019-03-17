class Spinner {

 

  private int x ; // x position
  private int y; // y position
  private int size;

 public Spinner(int x, int y, int size) {
   this.x = x;
   this.y = y;
   this.size = size;
   
 }

  //  public void setText(String text, color textColor, int textSize) {
  //    this.text = text;
  //    this.textColor = textColor;
  //    this.textSize = textSize;
  //  }

  public void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, x, 55* size, 30*size, 5*size);
    fill(0);
    triangle(x+13, x-2, x+25, x-2, x+19, x-12);
    triangle(x+13, x+1, x+25, x+1, x+19, x+12);

    //if (mousePressed &&mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
    //  depressed = true;
    //} else {
    //  depressed = false;
    //}

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
  public boolean depressed() {
    return true ;
    //return depressed;
  }
}