// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Displaying dynamic text with a custom font

PFont font;

void setup()
{
  size(300, 100);
  // Load a font from the data folder (created with "Tools / Create Font"
  font = loadFont("OCR-A-48.vlw");
  
  // Set the font for later drawing
  textFont(font);
}

void draw()
{
  background(0);
  
  // Write the current time at position x:0, y:48
  text(hour() + ":" + minute() + ":" + second(), 0, 48);
  
  // Write the current mouse position's coordinates
  text("x:" + mouseX + " y:" + mouseY, 0, 90);
}
