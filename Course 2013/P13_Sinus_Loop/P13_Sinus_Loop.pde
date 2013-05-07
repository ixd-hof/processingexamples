float counter = 0;

void setup()
{
  size(400, 400);
  colorMode(HSB, 360, 100, 100);
}

void draw()
{
  background(200);
  
  translate(0, height/2);
  
  float step = map(mouseX, 0, width, 10, 50);
  float amplitude = map(mouseY, 0, height, 10, 100);
  
  for (int i=0; i<20; i++)
  {
    pushMatrix();
    translate(i*step, sin(counter+i)*amplitude);

    ellipse(0, 0, 20, 20);
    popMatrix();
    
    counter += 0.001;
  }
}
