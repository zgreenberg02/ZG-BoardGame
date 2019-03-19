public class Die {
  private int sides;
  public Die(int sides) {
    this.sides = sides;
  }
  public int roll(){
    return round(random(1,sides+.1));
  }
}