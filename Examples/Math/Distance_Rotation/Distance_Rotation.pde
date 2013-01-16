PVector center = new PVector(0, 0);
PVector current = new PVector(0, 0);

void setup()
{
 size(500, 500); 
}

void draw()
{
  background(255);
  
  float distance = center.dist(current);
  float angle = atan2(center.y - current.y, center.x - current.x);
  
  fill(50);
  text("Distance: " + distance + "px", 20, 20);
  text("Angle: " + degrees(angle), 20, 40);
  
  noFill();
  stroke(100, 100, 100);
  line(center.x, center.y, current.x, current.y);
  
  stroke(255, 100, 0);
  ellipse(current.x, current.y, 20, 20);
  
  rectMode(CENTER);
  translate(center.x, center.y);
  rotate(angle);
  stroke(255, 0, 100);
  rect(0, 0, 20, 20);
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
