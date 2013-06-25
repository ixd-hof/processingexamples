// http://wiki.processing.org/w/Triangulation
import org.processing.wiki.triangulate.*;
 
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
 
void setup()
{
  size(400, 400, OPENGL);
  smooth();
  
  points.add(new PVector(0, 0, 0));
  points.add(new PVector(width, 0, 0));
  points.add(new PVector(width, height, 0));
  points.add(new PVector(0, height, 0));
}
 
void draw()
{
  background(200);
 
  // draw the mesh of triangles
  stroke(0, 40);
  fill(255, 40);
  
  beginShape(TRIANGLES);
 
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}

void mousePressed()
{
  points.add(new PVector(mouseX, mouseY, 0));
  triangles = Triangulate.triangulate(points);
}
