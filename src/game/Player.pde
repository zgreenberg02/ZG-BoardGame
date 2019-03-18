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
    for(Structure s: structures){ //<>//
      if(s != null){ //<>//
        switch (s.collectRecources()){ //<>//
        case "wheat":
          if(s instanceof City){
            wheat+=2;
          }else{
            wheat++;
          }
        break;
        case "wood":
        if(s instanceof City){
            wood+=2;
          }else{
            wood++;
          }
        break;
        case "ore":
        if(s instanceof City){
            ore+=2;
          }else{
            ore++;
          }
        break;
      }
      }
      
      
    }
  }
  public void build(Structure building) {
    boolean same = false;
    for (Structure s : structures) {
      if (s.getLocation() == building.getLocation() && s.getClass() == building.getClass() && !same) {
        s.addStructure(building.getQuantity() );
        same = true;
      }
    }
    if (!same) {
      structures.add(building);
    }
  }
  public void trainTroops(Region location, int quantity) {
    boolean same = false;
    for (Troop t : troops) {
      if (t.getLocation() == location && !same) {
        t.addTroops(quantity);
        same = true;
      }
    }
    if (!same) {
      troops.add(new Troop(c, location, quantity));
    }
  }
  public boolean inhabits(Region r) {
    if (hasTroops(r)|| hasStrucutres(r)) {
      return true;
    } else {
      return false;
    }
  }
  public boolean hasTroops(Region r) {
    for (Troop t : troops) {
      if (t.getLocation() == r ) {
        return true;
      }
    }
    return false;
  }
  public boolean hasStrucutres(Region r) {
    for (Structure s : structures) {
      if (s.getLocation() == r ) {
        return true;
      }
    }
    return false;
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
