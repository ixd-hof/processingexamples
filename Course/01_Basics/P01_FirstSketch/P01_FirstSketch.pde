// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Simple drawing with Processing

// Define the size of the sketch (width, height)
size(500, 500);
// Set the background color (red, green, blue)
background(255, 255, 255);

// Your first ellipse
// Set the fill color of the ellipse (red, green, blue)
fill(255, 100, 0);
// Set no stroke color
noStroke();
// Draw a ellipse at position 0,0 (x,y) with a 200px radius
ellipse(0, 0, 200, 200);

// Your first rectangle
// Set no fill color
noFill();
// Set the stroke color
stroke(255, 0, 100);
// Draw a rectangle at position 250,250 (x,y) and 100px wide and high
rect(200, 200, 100, 100);

// Draw a line
// Set the stroke color to black
stroke(0, 0, 0);
// Draw a diagonal line von left/top (0, 0) to right/bottom (500, 500)
line(0, 0, 500, 500);
