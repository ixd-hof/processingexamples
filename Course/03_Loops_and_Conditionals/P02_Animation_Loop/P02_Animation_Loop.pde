// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Animated cubes by iterating a value and multiply it with the current time

void setup()
{
  size(400, 400);
}

void draw()
{
  background(0);
  
  // iterate through 0 to 10
  for (int i=0; i<10; i++)
  {
    pushMatrix();
    // translate to I*40 to the right and half the sketches height from top
    // i=0: 0
    // i=1: 40
    // i=2: 80
    // ...
    translate(i*40, height/2);
    
    // calclulate an angle from i and the current milliseconds
    // hint: play around with the values
    float angle = i*(millis()/1000.0);
    rotate(angle);
    
    // draw a rect of the size 40 x 40
    rect(0, 0, 40, 40);
    popMatrix();
  }
}
