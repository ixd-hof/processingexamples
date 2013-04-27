PFont myFont;

void setup()
{
  size(500, 500);
  
  println(PFont.list());

  myFont = createFont("Helvetica", 32);
}

void draw()
{
  textFont(myFont);

  text("Helvetica", 100, 100);

  text("The quick brown fox jumped over the lazy dog.", 100, 200, 200, 400);
}

