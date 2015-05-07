import geomerative.*;

RShape grp;
float [] drops;

void setup()
{
  size(800, 500);
  background(255);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);
  
  //frameRate(2);
  drops = new float[grp.getPoints().length];
  for (int i=0; i<drops.length; i++)
  {
    drops[i] = random(20);
  }
  //println(drops);
}

void draw()
{
  background(255);
  
  translate(width/2, height/2);
  //grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();

  for (int i=0; i<points.length; i++)
  {
    noFill();
    
    float c = map(drops[i], 0, 20, 100, 0);
    stroke(0, 0, 255, c);
    ellipse(points[i].x, points[i].y, drops[i], drops[i]);
    
    if (drops[i] < 20)
      drops[i] += 0.1;
    else
      drops[i] = 0;
  }
}

