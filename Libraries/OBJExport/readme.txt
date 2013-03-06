OBJExport for Processing 2.0

Exports obj files from processing with beginRecord and endRecord
by Jesse Louis-Rosenberg (http://n-e-r-v-o-u-s.com)
updated by Michael Zoellner (http://ixd-hof.de)


Download:
https://github.com/ixd-hof/Processing/blob/master/Libraries/OBJExport/distribution/OBJExport-1/download/OBJExport.zip


Example:
import nervoussystem.obj.*;

boolean record;

void setup() {
  size(400,400,P3D);
  smooth();
}

void draw() {
  background(0);
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "filename.obj");
  }
  
  fill(255);
  translate(width/2, height/2);
  box(100,100,100);
  
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