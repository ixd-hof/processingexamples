import geomerative.*;
//import processing.dxf.*;
import nervoussystem.obj.*;

RFont f;
RShape s0,s1,s2,s3,s4;
RExtrudedMesh e0,e1;
int z = 250;
float a = 0.0;
float p = 1;
float d = 0.25;
boolean top = true, bottom = true, sides = true;
boolean polygon;

String out;

boolean record;

void setup() {
  size(1000, 600, P3D);

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  s0 = RG.getText("CAMPUS MÜNCHBERG", "FreeSans.ttf", 50, CENTER);

  // Set the polygonizer detail (lower = more details)
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(1);

  // Create an extruded mesh
  

  // Enable smoothing
  smooth();
}

void draw()
{
  background(100);

  if (record) {
    out = millis() + ".obj"; //dxf";
    //beginRaw(DXF, out);
    beginRecord("nervoussystem.obj.OBJExport", out);
  }

  lights();

  fill(255);
  //noStroke();
  
  translate(width/2, height-height/2.2, z);
  rotateY(a);
  
  RG.setPolygonizerLength(p);
  //translate(0, 0, -20);
  e1 = new RExtrudedMesh(s0, 10, top, bottom, sides);
  e1.set_polygon(polygon);
  e1.set_strength(d);
  e1.draw();

  if (record) {
    //endRaw();
    endRecord();
    record = false;
  }
}

void keyPressed()
{
  if (key == 'r') {
    record = true;
  }
  else if (key == 'p') {
    //String[] params = { "/Applications/meshconv", sketchPath("")+"/" + out, "-c", "stl" };
    //String[] params = { "open", "-a", "MakerWare", "--args", sketchPath("")+"/" + out };
    String[] params = { "open", "/Applications/MakerWare.app", sketchPath("")+"/" + out };
    println(params);
    exec(params);
  }
  else if (keyCode == RIGHT)
    a += 0.1;
  else if (keyCode == LEFT)
    a -= 0.1;
  else if (keyCode == UP)
    z += 10;
  else if (keyCode == DOWN)
    z -= 10;
  else if (key == 'w')
  {
    p += 0.01;
  }
  else if (key == 'q')
  {
    p -= 0.01;
  }
  else if (key == 'f')
  {
    p += 0.1;
  }
  else if (key == 'd')
  {
    p -= 0.1;
  }
  else if (key == 'a')
  {
    d -= 0.05;
  }
  else if (key == 's')
  {
    d += 0.05;
  }
  else if (key == 'l')
    sides = !sides;
  else if (key == 'k')
    top = !top;
  else if (key == 'j')
    bottom = !bottom;
  else if (key == 'y')
    polygon = !polygon;
}

