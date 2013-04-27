void setup()
{
  size(400, 400);
}

void draw()
{
  background(200);
  
  translate(width/2, height/2);
  
  int step = 360/(mouseX+1);
  
  for (int i=0; i<360; i+=step)
  {
    pushMatrix();
    rotate(radians(i));
    translate(0, -100);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}

