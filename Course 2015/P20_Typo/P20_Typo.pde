import geomerative.*;

RShape grp;

void setup()
{
  size(800, 500);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);
}

void draw()
{
  background(255);

  RShape glyph = grp.children[0];
  glyph.rotate(0.01);
  glyph.rotate(0.01, glyph.getCenter());
  
  translate(width/2, height/2);
  grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();

  for (int i=0; i<points.length; i++)
  {
    ellipse(points[i].x, points[i].y, 5, 5);
  }
}

