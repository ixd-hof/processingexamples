PVector center = new PVector();
PVector current = new PVector();

void setup()
{
  size(500, 500);
}

void draw()
{
  background(255);
  
  float distance = center.dist(current);
  float angle = atan2(current.y - center.y, current.x - center.x);
  
  pushMatrix();
  translate(center.x, center.y);
  rotate(angle);
  noFill();
  stroke(255, 0, 0);
  rectMode(CENTER);
  rect(0, 0, 50, 50);
  popMatrix();
  
  pushMatrix();
  translate(current.x, current.y);
  fill(255, 100, 0);
  noStroke();
  ellipse(0, 0, 20, 20);
  popMatrix();
  
  stroke(100);
  line(center.x, center.y, current.x, current.y);
  
}

void mousePressed()
{
  center.x = mouseX;
  center.y = mouseY;
}

void mouseDragged()
{
  current.x = mouseX;
  current.y = mouseY;
}

