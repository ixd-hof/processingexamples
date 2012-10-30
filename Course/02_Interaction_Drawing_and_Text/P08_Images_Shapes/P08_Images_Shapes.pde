// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Drawing and layering images
// Photo by NASA Commons https://secure.flickr.com/photos/nasacommons/7611655852/
// Icon by Noun Project http://thenounproject.com/noun/pointer/#icon-No2030

size(400, 400);

// load image
PImage img = loadImage("duke.jpg");
// display image at left / top
image(img, 0, 0);

//imageMode(CENTER);
//translate(width/2, height/2);
//scale(0.5, 0.5);
//rotate(PI/2);
//rotate(PI/4);
//image(img, 0, 0);

// load SVG vector graphic
PShape icon = loadShape("hand.svg");
// display vector graphic  10 pixels from top / left
shape(icon, 10, 10);
