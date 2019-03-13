public class Player {
  
  static Die die = new Die(10);
  private String name;
  private String color;
  private int wood;
  private int ore;
  private int wheat;
  ArrayList <Troop> troops = new ArrayList<Troop>();
  ArrayList <Structure> structures = new ArrayList<Structure>();
  
  public Player(String name, String color){
    
  }
  public static int[] rollDice(int times) {
    //die.roll()
    return new int[] {};
    
  }
  public int getWood() {
    return wood;
  }
  public void setWood(int wood) {
    this.wood = wood;
  }
  public int getOre() {
    return ore;
  }
  public void setOre(int ore) {
    this.ore = ore;
  }
  public int getWheat() {
    return wheat;
  }
  public void setWheat(int wheat) {
    this.wheat = wheat;
  }
  public void move(Troop troop, int quantity, Region location) {
    
  }
  public void collectRecources() {
    
  }
  public void build(Structure building) {
    structures.add(building);
  }
  public void trainTroops(Region location, int quantity) {
    
  }
}
