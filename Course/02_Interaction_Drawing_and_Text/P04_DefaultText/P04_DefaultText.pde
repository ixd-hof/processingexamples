// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Displaying text with the default font

void setup()
{
  size(200, 100);
}

void draw()
{
  background(255);
  
  // Set the font color to black
  fill(0, 0, 0);
  
  // Write a string at the position x:20, y:30
  text("Hello Processing", 20, 30);
  
  // Write the current mouse position's coordinates
  text("x:" +  mouseX + " | y: " + mouseY, 20, 50);
}

