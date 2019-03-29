/**
 * Represents a spinner that can keep track of and change number values
 */
class Spinner {

  private int x;
  private int y;
  private int number = 0;
  private boolean upDepressed;
  private boolean downDepressed;

  /**
   * Constructs the spinner
   * @param x x-coordinate of the spinner
   * @param y y-coordinate of the spinner
   */
  public Spinner(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /**
   * Displays the spinners
   */
  public void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, 55, 30, 5);
    fill(0);
    if (upDepressed) {
      fill(150);
    } else {
      fill(0);
    }
    triangle(x+13, y-2, x+25, y-2, x+19, y-12);
    if (downDepressed) {
      fill(150);
    } else {
      fill(0);
    }
    triangle(x+13, y+1, x+25, y+1, x+19, y+12);
    textSize(18);
    textAlign(CENTER, CENTER);
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
  }

  /**
   * Gets upDepressed
   * @return boolean if the up button is depressed
   */
  public boolean upDepressed() {
    return upDepressed;
  }

  /**
   * Gets downDepressed
   * @return boolean if the down button is depressed
   */
  public boolean downDepressed() {
    return downDepressed;
  }

  /**
   * incriments the number by a value
   * @param num the number to incriment by
   */
  public void addNumber(int num) {
    number += num;
  }

  /**
   * Gets number
   * @return int number
   */
  public int getNumber() {
    return number;
  }

  /**
   * Sets number
   * @param num number to set
   */
  public void setNumber(int num) {
    number = num;
  }
}