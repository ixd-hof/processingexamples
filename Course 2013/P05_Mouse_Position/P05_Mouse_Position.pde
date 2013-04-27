void setup()
{
  size(250, 250);
}
void draw()
{
  background(200);
  text("X: " + mouseX, 20, 20);
  text("Y: " + mouseY, 20, 40);
  translate(mouseX, mouseY);
  ellipse(0, 0, 50, 50);
}

