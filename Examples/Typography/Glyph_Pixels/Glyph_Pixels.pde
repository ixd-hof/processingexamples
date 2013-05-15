PFont myFont;
char glyph = 'a';
PFont.Glyph pglyph;

void setup() {
  size(500, 500);

  myFont = createFont("OCR-A", 32);

  textFont(myFont);
  textAlign(CENTER, CENTER);

  pglyph = myFont.getGlyph(glyph);
  
  noLoop();
}

void draw()
{
  background(0);
  
  translate(100, 100);

  for (int y=0; y<pglyph.image.height; y++)
  {
    for (int x=0; x<pglyph.image.width; x++)
    {
      int c = pglyph.image.get(x, y);
      if (c <= 200)
      {
        fill(random(150, 255), 0, 0);
        float r = random(5, 15);
        ellipse(x*10, y*10, r, r);
      }
      else
      {
        fill(0, random(150, 255), 0);
        float r = random(5, 15);
        ellipse(x*10, y*10, r, r);
      }
    }
  }
}

void keyTyped()
{
  pglyph = myFont.getGlyph(key);
  redraw();
}

