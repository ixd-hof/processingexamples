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
  pushMatrix();
  translate(width/2, height/2, 0);
  box(100,100,100);
  popMatrix();
  
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
  else if (key == 'p') {
    String[] params = { "/Applications/MakerWare.app", "-help" };
    open(params);
  }
}
