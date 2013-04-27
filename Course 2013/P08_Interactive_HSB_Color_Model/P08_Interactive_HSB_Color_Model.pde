float h = 0;
float s = 0;
float b = 0;

void setup()
{
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
}

void draw()
{
  println(mouseX + " h:" + h + " s:" + s + " b:" + b);
  background(0);
  
  fill(h, s, b);
  ellipse(width/2, height/2, 200, 200);
}

void mouseDragged()
{
  h = map(mouseX, 0, width, 120, 200);
}

void mouseMoved()
{
  b = map(mouseX, 0, width, 0, 100);
  s = map(mouseY, 0, height, 0, 100);
}


