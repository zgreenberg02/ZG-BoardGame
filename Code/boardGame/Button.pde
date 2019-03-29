/**
 * Represents a button that can be pressed
 */
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

  /**
   * Creates a button
   * @param x x-coordinate of the center of the button
   * @param y y-coordinate of the center of the button
   * @param w width of the button
   * @param h height of the button
   * @param r radius of the rounded corners on the button
   * @param c normal color of the button
   * @param pressedColor color of the button while being pressed
   * @param hovorColor color of the button while the mouse is over it (and it is not being pressed)
   */
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

  /**
   * Used to set the text that appears in the button.
   * @param text the text that will appear in the button
   * @param textColor color of the text
   * @param textSize size of the text
   */
  public void setText(String text, color textColor, int textSize) {
    this.text = text;
    this.textColor = textColor;
    this.textSize = textSize;
  }

  /**
   * Used to display the button and detect if the mouse is over it
   * or if it is depressed
   */
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

  /**
   * gets if it is depressed
   * @return boolean returns depressed.
   */
  public boolean depressed() {
    return depressed;
  }

  /**
   * gets if it is released
   * @return boolean returns released.
   */
  public boolean released() {
    return released;
  }

  /**
   * Sets if the button is released
   * @param released if the button is released or not
   */
  public void setReleased(boolean released) {
    this.released = released;
  }
}