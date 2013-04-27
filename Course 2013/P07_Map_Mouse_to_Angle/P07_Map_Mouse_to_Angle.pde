void setup()
{
  size(250, 250);
}
void draw()
{
  float my_angle = map(mouseX, 0, width, 0, 2*PI);
  translate(width/2, height/2);
  rotate(my_angle);
  rectMode(CENTER);
  rect(0, 0, 100, 100);
}

