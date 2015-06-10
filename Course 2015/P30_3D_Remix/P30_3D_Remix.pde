PShape model;

public void setup() {
  size(500, 500, P3D);

  model = loadShape("Artjom_02.obj");
}

public void draw() {
  background(0);
  lights();

  translate(width/2, height/2 + 100, -200);
  float mouse_r = map(mouseX, 0, width, 0, 2*PI);
  rotateY(mouse_r);

  pushMatrix();

  rotateX(PI/2);
  scale(200);
  shape(model);
  popMatrix();

  //translate(width/2, height/2);
  noFill();
  stroke(255);
  for (int i=0; i<10; i++)
  {
    pushMatrix();
    float y = 100-(1+sin(millis()/1000.0+i/10.0)) * 200;
    translate(0, y, 0);
    rotateX(PI/2.0);
    ellipse(0, 0, 150, 150);
    popMatrix();
  }
}

