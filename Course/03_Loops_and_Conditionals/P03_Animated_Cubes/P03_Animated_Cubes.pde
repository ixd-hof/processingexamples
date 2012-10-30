// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Animated cubes by iterating a value and apply a sinus function

float counter = 0;

void setup()
{
  size(400, 400);
}

void draw()
{
  background(0);
  
  for (int i=0; i<10; i++)
  {
    pushMatrix();
    translate(i*40, sin(counter+i)*100+100);
    // sin(counter) -> -1 - 1
    // *100 -> -100 - 100
    // +100 -> 0 - 200
    
    rect(0, 0, 40, 40);
    popMatrix();
    
    counter += 0.01;
  }
}
