// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Draw Mondrian's Composition II in Red, Blue, and Yellow
// http://en.wikipedia.org/wiki/Piet_Mondrian#Paris_1919.E2.80.931938

// Define the size of the sketch
size(500, 500);
// Set the background color to black
background(0, 0, 0);

// Draw a red rectangle
fill(200, 0, 0);
noStroke();
rect(0, 0, 200, 290);

// Draw the first white rectangle
fill(240, 240, 240);
noStroke();
rect(210, 0, 290, 290);

// Draw the second white rectangle
fill(240, 240, 240);
noStroke();
rect(0, 300, 200, 200);

// Draw the third white rectangle
fill(240, 240, 240);
noStroke();
rect(210, 300, 230, 170);

// Small yellow rectangle
fill(200, 180, 50);
noStroke();
rect(210, 480, 110, 20);

// Small white rectangle
fill(240, 240, 240);
noStroke();
rect(330, 480, 110, 20);

// Blue rectangle
fill(50, 50, 200);
noStroke();
rect(450, 380, 50, 120);

// Save the sketch as jpg image to your sketch folder
saveFrame("mondrain.jpg");
