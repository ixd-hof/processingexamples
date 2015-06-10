PShape model;
  
public void setup() {
  size(500, 500, P3D);
    
  model = loadShape("Artjom_02.obj");
  model.disableStyle();
  model.scale(200);
}

public void draw() {
  background(0);
  lights();
  
  translate(width/2, height/2 + 100, -200);
  rotateX(PI/2);
  
  float mouse_r = map(mouseX, 0, width, 0, 2*PI);
  rotateZ(mouse_r);
  stroke(0);
  fill(255, 0, 0);
  shape(model);
}
