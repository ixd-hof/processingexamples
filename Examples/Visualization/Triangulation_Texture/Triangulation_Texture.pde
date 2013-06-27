// http://wiki.processing.org/w/Triangulation
import org.processing.wiki.triangulate.*;

PImage img;
 
ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();
 
void setup()
{
  size(400, 400, P3D);
  smooth();
  
  points.add(new PVector(0, 0, 0));
  points.add(new PVector(width, 0, 0));
  points.add(new PVector(width, height, 0));
  points.add(new PVector(0, height, 0));
  triangles = Triangulate.triangulate(points);
  
  // Image: NASA
  img = loadImage("nasa_buzz.jpg");
  
  textureMode(NORMAL);
}
 
void draw()
{
 // image(img,0,0);
  background(255);
 
  // draw the mesh of triangles
  beginShape(TRIANGLES);
  texture(img);
 
  for (int i = 0; i < triangles.size(); i++) {
    
    Triangle t = (Triangle)triangles.get(i);
    
    // Create UV coordinates
    float u1 = map(t.p1.x, 0, width, 0, 1);
    float v1 = map(t.p1.y, 0, height, 0, 1);
    float u2 = map(t.p2.x, 0, width, 0, 1);
    float v2 = map(t.p2.y, 0, height, 0, 1);
    float u3 = map(t.p3.x, 0, width, 0, 1);
    float v3 = map(t.p3.y, 0, height, 0, 1);
    
    vertex(t.p1.x, t.p1.y, t.p1.z, u1, v1);
    vertex(t.p2.x, t.p2.y, t.p2.z, u2, v2);
    vertex(t.p3.x, t.p3.y, t.p3.z, u3, v3);
  }
  endShape();
  
}

void mousePressed()
{
  points.add(new PVector(mouseX, mouseY, random(-250)));
  triangles = Triangulate.triangulate(points);
}
