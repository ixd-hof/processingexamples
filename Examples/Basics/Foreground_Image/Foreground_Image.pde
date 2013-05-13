// Drawing an image in front of the main scene (HUD)
// Based on Jonathan Feinberg's Peasycam

// IxD Hof Creative Coding Class
// http://ixd-hof.de

PMatrix3D originalMatrix;
PImage fg;

void setup() 
{
  size(500, 500, P3D);
  frameRate(30);

  // Save the original Matrix for restoring later
  originalMatrix = (PMatrix3D)getMatrix();
  
  // Load foreground image (matches sketch size)
  fg = loadImage("lines.png");
}

void draw()
{
  background(200);

  // Drawing the scene
  translate(width/2, height/2);
  rotateY(millis()/500.0);
  stroke(0);
  fill(255, 100, 0);
  box(200);
  
  // Draw foregound image
  foreground(fg);
}

void foreground(PImage img)
{
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  // Load the identity matrix.
  resetMatrix();
  // Apply the original Processing transformation matrix.
  applyMatrix(originalMatrix);

  // Draw the foreground
  image(img, 0, 0);
  
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
