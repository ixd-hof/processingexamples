// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Simple mouse interaction

void setup()
{
  size(500, 500);
  background(0);
  
  noFill();
  stroke(255);
}

void draw() {
  // If the left mouse button is pressed
  if (mousePressed == true) {
    // draw an ellipse at the mouse coordinates
    ellipse(mouseX, mouseY, 20, 20);
  }
  else
  {
    // clear the background
    background(0); 
  }
}
