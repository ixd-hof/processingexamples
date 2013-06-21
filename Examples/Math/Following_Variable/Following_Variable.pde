// Follow Variable
float follow = 0;

PVector center, mouse;
int radius = 50;

void setup()
{
  size(500, 500);
  noStroke();

  center = new PVector(width/2, height/2);
  mouse = new PVector(width/2, height/2);
}

void draw()
{
  background(0);

  fill(255, 0, 0, follow);
  rect(0, 0, width, height);

  fill(255);
  ellipse(width/2, height/2, 10, 10);

  // Distance between mouse and center
  mouse.x = mouseX;
  mouse.y = mouseY;
  float d = center.dist(mouse);

  // If inside the area, decrease the value (largeer = faster)
  if (d < radius && follow > 0)
    follow -= 10;
  // If outside the area, increase the value
  else
    follow += 1;

  // Display current values
  text("Follow: " + follow, 20, 20);
  text("Distance: " + d, 20, 40);
  text("Mouse: " + mouseX + " " + mouseY, 20, 60);
}

