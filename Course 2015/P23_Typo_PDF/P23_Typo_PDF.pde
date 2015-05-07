import geomerative.*;
import processing.pdf.*;

RShape grp;

void setup()
{
  size(800, 500);
  background(255);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);
  
  noLoop();
}

void draw()
{
  beginRecord(PDF, "filename.pdf"); 

  background(255);
  
  translate(width/2, height/2);
  
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  //RG.setPolygonizer(RG.BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();

  for (int i=0; i<points.length; i++)
  {
    noFill();
    stroke(0);
    float r = random(20);
    
    
    //line(points[i].x, points[i].y, 0, 0);
    //line(points[i].x, points[i].y, points[i].x+10, points[i].y+10);
    fill(255);
    ellipse(points[i].x, points[i].y, r, r);
  }
  
  endRecord();
}

