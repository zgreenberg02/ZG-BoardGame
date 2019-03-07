public class Button {
  private int xPos ; // x position
  private int yPos ; // y position
  private int w; //width
  private int h; // height
  private int r; //rounding
  private color c;
  private color pressedColor;
  private color hoverColor;
  private boolean depressed;
  private String text;
  private color textColor;
  private int textSize;

  public Button(int xPos, int yPos, int w, int h, int r, color c, color pressedColor, color hoverColor)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.w = w;
    this.h = h;
    this.r = r;
    this.c = c;
    this.hoverColor = hoverColor;
    this.pressedColor = pressedColor;
  }

  public void setText(String text, color textColor, int textSize) {
    this.text = text;
    this.textColor = textColor;
    this.textSize = textSize;
  }

  public void display() {
    if (mousePressed &&mouseX > xPos - w/2 && mouseX < xPos + w/2 && mouseY > yPos - h/2 && mouseY < yPos + h/2) {
      depressed = true;
    } else {
      depressed = false;
    }

    noStroke();
    if (depressed) {
      fill(pressedColor);
    } else if (mouseX > xPos - w/2 && mouseX < xPos + w/2 && mouseY > yPos - h/2 && mouseY < yPos + h/2) {
      fill(hoverColor);
    } else {
      fill(c);
    }
    rectMode(CENTER);
    rect(xPos, yPos, w, h, r);
    textAlign(CENTER, CENTER);
    if (text != null) {
      fill(textColor);
      textSize(textSize);
      text(text, xPos, yPos);
    }
  }
}