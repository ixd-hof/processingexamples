// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Create colors with loops and HSB

size(500, 100);
background(0);

// set to HSB color mode instead of RGB
// http://processing.org/reference/colorMode_.html
// https://en.wikipedia.org/wiki/HSL_and_HSV
colorMode(HSB, 100);

// iterate from 0 to 100
for (int i=0; i<100; i+=1)
{
  // set the stroke color to H:i (0-100), S:50, B:100
  stroke(i, 50, 100);
  // draw a line at an exponential x position from top to bottom (y) -> play arount with the values and see the result
  line (pow(i, 2)/8.0, 0, pow(i, 2)/8.0, 100);
  
  // set the fill color
  fill(i, 50, 100);
  // draw an ellipse in the middle of the line
  ellipse(pow(i, 2)/8.0, 50, pow(i, 2)/200.0, pow(i, 2)/200.0);
}

// save the result
saveFrame("space.png");
