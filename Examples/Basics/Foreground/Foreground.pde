// Drawing objects in front of the main scene (HUD)
// Based on Jonathan Feinberg's Peasycam

// IxD Hof Creative Coding Class
// http://ixd-hof.de

PMatrix3D originalMatrix;

void setup() 
{
  size(500, 500, P3D);
  frameRate(30);

  // Save the original Matrix for restoring later
  originalMatrix = (PMatrix3D)getMatrix();
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
  // ...
  
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  // Load the identity matrix.
  resetMatrix();
  // Apply the original Processing transformation matrix.
  applyMatrix(originalMatrix);

  // Draw the foreground
  noStroke();
  fill(0);
  rect(0, height/2-10, width, 20);
  rect(0, height/2-50, width, 20);
  rect(0, height/2+30, width, 20);
  // ...
  
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
