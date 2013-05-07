float counter = 0;

void setup()
{
  size(400, 400);
  colorMode(HSB, 360, 100, 100);
}

void draw()
{
  background(200);
  
  translate(width/2, height/2);
  
  for (int i=0; i<10; i++)
  {
    pushMatrix();
    //translate(i*40, sin(counter+i)*100);
    // sin(counter) -> -1 - 1
    // *100 -> -100 - 100
    // +100 -> 0 - 200
    translate(cos(counter+i/2.0)*100, sin(counter+i)*100);
    
    float h = map(sin(counter+i), -1, 1, 0, 360);
    fill(h, 100, 100);
    ellipse(0, 0, 40, 40);
    popMatrix();
    
    counter += 0.01;
  }
}
