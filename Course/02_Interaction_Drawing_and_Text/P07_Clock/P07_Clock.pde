// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// A simple clock displaying the current time via typography

PFont font;

void setup()
{
  size(500, 500);
  rectMode(CENTER);
  font = loadFont("OCR-A-32.vlw");
  textFont(font);
}

void draw()
{
  background(240, 240, 240);

  noStroke();

  // Jump to the center of the sketch for drawing
  translate(width/2, height/2);
  
  pushMatrix();
  fill(0, 0, 0);
  rotate(second() * (PI/30) - PI/2);
  text(second(), 150, 0);
  popMatrix();
  
  pushMatrix();
  rotate(minute() * (PI/30) - PI/2);
  text(minute(), 150, 0);
  popMatrix();
  
  pushMatrix();
  rotate(hour() * (PI/6) - PI/2);
  text(hour(), 150, 0);
  popMatrix();
}

