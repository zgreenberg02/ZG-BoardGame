public class Region {
  
  
  class Vertex{
    public int x;
    public int y;
    public Vertex(int x, int y){
      this.x = x;
      this.y = y;
    }
  }
  
  private String type;
  private ArrayList<Vertex> verticies = new ArrayList<Vertex>();
  private PShape shape;
  
  public Region(){//String type){ // add later

  }
 
  
  public void addVertex(int x, int y){
    verticies.add(new Vertex(x,y));
  }
  
  public void display(){
    shape = createShape();
    shape.beginShape();
    for(Vertex vert : verticies){
      shape.vertex(vert.x,vert.y);
    }
    shape.endShape(CLOSE);
    shape(shape);
  }
  public String getType() {
    
    return type;
  }
  
  
  
  
}