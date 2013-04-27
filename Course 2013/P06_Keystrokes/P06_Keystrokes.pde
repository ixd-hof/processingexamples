PFont myFont;
void setup()
{
  size(250, 250);
  myFont = createFont("sans-serif", 50);
  textAlign(CENTER, CENTER);
  textFont(myFont);
}
void draw()
{
  background(200);
  fill(100);
  text(key, width/2, height/2);
}

