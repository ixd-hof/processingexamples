import geomerative.*;

RShape grp;

void setup()
{
  size(800, 500);
  background(255);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);
  
  //frameRate(2);
}

void draw()
{
  //background(255);
  
  translate(width/2, height/2);
  //grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();

  for (int i=0; i<points.length; i++)
  {
    noFill();
    float rx = random(-mouseX/10, mouseX/10);
    float ry = random(-mouseY/10, mouseY/10);
    ellipse(points[i].x+rx, points[i].y+ry, 5, 5);
    //line(points[i].x, points[i].y, points[i].x+rx, points[i].y+ry);
  }
}

