import geomerative.*;
import nervoussystem.obj.*;

RExtrudedMesh e0;
String typo = "Hello";

boolean record;

void setup() {
  size(600, 400, P3D);

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  RShape s = RG.getText(typo, "FreeSans.ttf", 50, CENTER);
  // Or load a SVG File
  //RShape s = RG.loadShape("Make_Red_Robot.svg");
  //s = RG.centerIn(s0, g);
  
  // Set the polygonizer detail (lower = more details)
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(1);

  // Create an extruded mesh
  e0 = new RExtrudedMesh(s, 20);

  // Enable smoothing
  smooth();
}

void draw()
{
  background(255);

  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", typo+".obj");
  }

  lights();

  fill(255, 100, 0);
  noStroke();
  
  translate(width/2, height/2, 200);
  //rotateY(millis()/1000.0);

  // Draw mesh
  e0.draw();

  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed()
{
  if (key == 'r') {
    record = true;
  }
}
