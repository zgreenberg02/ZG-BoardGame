import java.util.Iterator;

/**
 * Represents one of the players
 */
public class Player {

  private String name;
  private color c;
  private int wood = 4;
  private int ore = 4;
  private int wheat = 4;
  private ArrayList <Troop> troops = new ArrayList<Troop>();
  private ArrayList <Structure> structures = new ArrayList<Structure>();

  /**
   * Constructs a player.
   * @param name name of the player
   * @param c color of the player
   */
  public Player(String name, color c) {
    this.name = name;
    this.c = c;
  }

  /**
   * Gets the name of the player.
   * @return String name of the player
   */
  public String getName() {
    return name;
  }

  /**
   * Gets the color of the player.
   * @return color color of the player
   */
  public color getColor() {
    return c;
  }

  /**
   * Gets the amount of wood the player has.
   * @return int amount of wood
   */
  public int getWood() {
    return wood;
  }

  /**
   * Sets the amount of wood the player has.
   * @param wood amount of wood
   */
  public void setWood(int wood) {
    this.wood = wood;
  }

  /**
   * Gets the amount of ore the player has.
   * @return int amount of ore
   */
  public int getOre() {
    return ore;
  }

  /**
   * Sets the amount of ore the player has.
   * @param ore amount of ore
   */
  public void setOre(int ore) {
    this.ore = ore;
  }

  /**
   * Gets the amount of wheat the player has.
   * @return int amount of wheat
   */
  public int getWheat() {
    return wheat;
  }

  /**
   * Sets the amount of wheat the player has.
   * @param wheat amount of wheat
   */
  public void setWheat(int wheat) {
    this.wheat = wheat;
  }

  /**
   * Moves troops.
   * @param r1 region to move from
   * @param r2 region to move to
   * @param num number of troops to move
   */
  public void moveTroops(Region r1, Region r2, int num ) {
    if (num > 0) {
      trainTroops(r1, -num);
      trainTroops(r2, num);
    }
  }

  /**
   * Collects recources from the regions with structures.
   * Called at the begining of a players turn.
   */
  public void collectRecources() {
    for (Structure s : structures) {
      if (s != null) {
        switch (s.collectRecources()) {
        case "wheat":
          if (s instanceof Castle) {
            wheat+=2*s.getQuantity();
          } else {
            wheat+= s.getQuantity();
          }
          break;
        case "wood":
          if (s instanceof Castle) {
            wood+=2*s.getQuantity();
          } else {
            wood+=s.getQuantity();
          }
          break;
        case "ore":
          if (s instanceof Castle) {
            ore+=2*s.getQuantity();
          } else {
            ore+= s.getQuantity();
          }
          break;
        }
      }
    }
  }

  /**
   * Builds a structure.
   * @param building the structrue that will be built
   */
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

  /**
   * Removes all of the structures in a region
   * @param r region to remove the structures from
   */
  public void removeStructures(Region r) {
    Iterator itr = structures.iterator();
    while (itr.hasNext()) {
      Structure s = (Structure)itr.next();
      if (s.getLocation() == r) {
        itr.remove();
      }
    }
  }

  /**
   * Trains more troops.
   * @param location region to train the troops in
   * @param quantity number of troops to train
   */
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
    Iterator itr = troops.iterator();
    while (itr.hasNext()) {
      Troop t = (Troop)itr.next();
      if (t.getQuantity() < 1) {
        itr.remove();
      }
    }
  }


  /**
   * Checks if the player inhabits a certain region
   * @param r region it checks
   * @return boolean return if the player inhabits the region.
   */
  public boolean inhabits(Region r) {
    if (hasTroops(r)|| hasStructuresIn(r)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Checks if the player has troops in a certain region
   * @param r region it checks
   * @return boolean return if the player has troops in the region
   */
  public boolean hasTroops(Region r) {
    for (Troop t : troops) {
      if (t.getLocation() == r ) {
        return true;
      }
    }
    return false;
  }

  /**
   * Gets the number of troops in a region
   * @param r region it checks
   * @return int number of troops the player has in the region
   */
  public int troopsIn(Region r) {
    int num = 0;
    for (Troop t : troops) {
      if (t.getLocation() == r ) {
        num += t.getQuantity();
      }
    }
    return num;
  }

  /**
   * Checks if the player has structures in a certain region
   * @param r region it checks
   * @return boolean return if the player has structures in the region
   */
  public boolean hasStructuresIn(Region r) {
    for (Structure s : structures) {
      if (s.getLocation() == r ) {
        return true;
      }
    }
    return false;
  }

  /**
   * Checks if the player has any structures
   * @return boolean return if the player has structures
   */
  public boolean hasStructures() {

    if (structures.isEmpty()) {
      return false;
    }
    return true;
  }

  /**
   * Checks if the player has troops
   * @return boolean return if the player has troops
   */
  public boolean hasTroops() {

    if (troops.isEmpty()) {
      return false;
    }
    return true;
  }

  /**
   * Checks if the player has troops or units
   * @return boolean return if the player has troops or structures
   */
  public boolean hasUnits() {
    if (troops.isEmpty() && structures.isEmpty() ) {
      return false;
    } else {
      return true;
    }
  }

  /**
   * Displays the troops and structures a player owns
   */
  public void displayUnits() {
    for (Structure s : structures) {
      s.display();
    }
    for (Troop t : troops) {
      t.display();
    }
  }
}