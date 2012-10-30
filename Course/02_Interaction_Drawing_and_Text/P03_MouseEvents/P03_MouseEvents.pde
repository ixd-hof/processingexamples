// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Simple demonstration of basic mouse events

void setup()
{
  size(500, 500); 
}

void draw()
{
  
}

// if the left mouse button is pressed
void mousePressed()
{
  // fill the background with a random color
  background(random(255), random(255), random(255));
}

// if the mouse button is released
void mouseReleased()
{
  // fill the background black
  background(0);
}

// if the mouse moves
void mouseMoved()
{
  // fill the background with a random grey
  background(random(255));
}

// if the mouse gets dragged (press and move)
void mouseDragged() 
{
  // fill the background with a random color
  background(random(255), random(255), random(255));
}
