import geomerative.*;
//import processing.dxf.*;
import nervoussystem.obj.*;

RFont f;
RShape s0, s1, s2, s3, s4;
RShape [] glyphs;
//RExtrudedMesh e0,e1;
int z = 250;
float a = 0.0;
float p = 1;
float d = 0.25;
float kerning = 40;
boolean top = true, bottom = true, sides = true;
boolean polygon;

String out;

boolean record;

void setup() {
  size(1000, 600, P3D);

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  String str = "CAMPUSMUNCHBERG";
  glyphs = new RShape[str.length()];
  for (int i=0; i<str.length(); i++)
  {
    //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
    String c = str.charAt(i)+"";
    //println(c);
    RShape s = RG.getText(c, "OCRA.ttf", 50, CENTER);
    glyphs[i] = s;
  }

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
  noStroke();

  translate(width/2, height-height/2.2, z);
  rotateY(a);

  RG.setPolygonizerLength(p);

  for (int i=0; i<glyphs.length; i++)
  {
    //fill(random(255), random(255), 100);
    pushMatrix();
    
    rotateZ(i*2*PI/glyphs.length);
    translate(0, kerning, 0);
    translate(glyphs[i].getWidth()/4.5, 0, 0);
    rotateZ(PI);
    
    /*
    rotateZ(i*2*PI/glyphs.length);
    translate(0, kerning, 0);
    translate(glyphs[i].getWidth()/4.5, 0, 0);
    rotateZ(PI);
    */
    
    RExtrudedMesh e = new RExtrudedMesh(glyphs[i], 10, top, bottom, sides);
    e.set_polygon(polygon);
    e.set_strength(d);
    e.draw();
    popMatrix();
  }

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
    String[] params = { 
      "open", "/Applications/MakerWare.app", sketchPath("")+"/" + out
    };
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
  else if (key == 'i')
  {
    kerning += 1;
  }
  else if (key == 'u')
  {
    kerning -= 1;
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

