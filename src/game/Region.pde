import java.awt.Polygon;

public class Region {
  
  Polygon shapeHolder = new Polygon();
  private int points = 0;
  private String type;
  private PShape shape;
  private boolean depressed = false;
  
  public Region(){//String type){ // add later

  }
 
  
  public void addVertex(int x, int y){
    shapeHolder.addPoint(x,y);
    points++;
  }
  
  public void display(){
    if(contains(mouseX,mouseY)&& mousePressed){
      depressed = true;
      stroke(0);
      strokeWeight(4);
    }else if(contains(mouseX,mouseY)){
      strokeWeight(3);
      stroke(0);
      depressed = false;
    }else{
      depressed = false;
      noStroke();
    }
    noFill();
    shape = createShape();
    shape.beginShape();
    int[] xPoints = shapeHolder.xpoints; 
    int[] yPoints = shapeHolder.ypoints;
    for(int i = 0; i < points; i++){
      shape.vertex(xPoints[i], yPoints[i]);
    }
    shape.endShape(CLOSE);
    shape(shape);
  }
  public boolean contains(int x, int y){
    return shapeHolder.contains(x,y);
  }
  public String getType() {
    
    return type;
  }

  public boolean depressed(){
     return depressed;
  } 
  
  
}