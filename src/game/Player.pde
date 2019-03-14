public class Player {

  Die dice = new Die(10);
  private String name;
  private color c;
  private int wood;
  private int ore;
  private int wheat;
  ArrayList <Troop> troops = new ArrayList<Troop>();
  ArrayList <Structure> structures = new ArrayList<Structure>();

  public Player(String name, color c) {
    this.name = name;
    this.c = c;
  }

  public int[] rollDice(int times) {
    int[] rolls = new int[times];
    for (int i = 0; i< times; i++) {
      rolls[0] = dice.roll();
    }

    return rolls;
  }
  public color getColor() {
    return c;
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
    boolean same = false;
    for(Troop t: troops){
      if(t.getLocation().equals(location) && !same){
        t.addTroops(quantity);
        same = true;
      }
    }
    if(!same){
      troops.add(new Troop(c, location, quantity));
    }
  }
  public void displayUnits() {
    for (Structure s : structures) {
      s.display();
    }
     for (Troop t : troops) {
      t.display();
    }
  }
}