// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// A first mouse event

// Variables for storing mouse coordinates
int mx = 0;
int my = 0;

void setup()
{
  size(500, 500);
  background(0);
}

void draw() {
  background(0);

  fill(255);
  noStroke();
  ellipse(mx, my, 20, 20);
}

// Store current mouse coordinates when the mouse is moved in order
// to use them for drawing withing draw()
void mouseMoved()
{
  mx = mouseX;
  my = mouseY;
}

