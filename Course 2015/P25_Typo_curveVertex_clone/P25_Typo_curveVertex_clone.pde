import geomerative.*;

RShape grp;

void setup()
{
  size(800, 500);
  background(255);

  RG.init(this);

  grp = RG.getText("C", "FiraMono-Medium.ttf", 200, CENTER);

  noLoop();
}

void draw()
{
  noStroke();
  fill(255, 5);
  //rect(0, 0, width, height);
  background(255);

  translate(width/2, height/2);

  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  //RG.setPolygonizer(RG.BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();
  beginShape();
  curveVertex(points[0].x, points[0].y);
  for (int i=0; i<points.length; i++)
  {
    noFill();
    stroke(0);
    curveVertex(points[i].x+random(-5, 5), points[i].y+random(-5, 5));
  }
  endShape();
}

