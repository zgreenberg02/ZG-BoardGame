public class Button {
  private int x ; // x position
  private int y; // y position
  private int w; //width
  private int h; // height
  private int r; //rounding
  private color c;
  private color pressedColor;
  private color hoverColor;
  private boolean depressed = false;
  private String text;
  private color textColor;
  private int textSize;
  private boolean released;

  public Button(int x, int y, int w, int h, int r, color c, color pressedColor, color hoverColor)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.c = c;
    this.hoverColor = hoverColor;
    this.pressedColor = pressedColor;
  }
 // public Button(){}

  public void setText(String text, color textColor, int textSize) {
    this.text = text;
    this.textColor = textColor;
    this.textSize = textSize;
  }

  public void display() {
    if (mousePressed &&mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      depressed = true;
    } else {
      depressed = false;
    }

    noStroke();
    if (depressed) {
      fill(pressedColor);
    } else if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      fill(hoverColor);
    } else {
      fill(c);
    }
    rectMode(CENTER);
    rect(x, y, w, h, r);
    textAlign(CENTER, CENTER);
    if (text != null) {
      fill(textColor);
      textSize(textSize);
      text(text, x, y);
    }
  }
  public boolean depressed(){
    return depressed;
  }
  public boolean released() {
    return released;
  }
  public void setReleased(boolean released) {
    this.released = released;
  }
  
  
}