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
