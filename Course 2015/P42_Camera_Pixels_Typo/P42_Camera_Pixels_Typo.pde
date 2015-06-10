import processing.video.*;

Capture video;

void setup()
{
  size(640, 480, P3D);

  // Webcam starten
  video = new Capture(this, 640, 480);
  video.start();
}

void draw()
{
  background(0);
  // Video anzeigen
  //image(video, 0, 0);

  for (int y=0; y<480; y+=10)
  {
    for (int x=0; x<640; x+=10)
    {
      color c = video.get(x, y);
      int ascii = int(map(brightness(c), 0, 255, 33, 90));
      text(char(ascii), x, y);
    }
  }
}

// Aktuelles Videobild laden, da evtl. Framerates Sketch / Video unterschiedlich
void captureEvent(Capture c)
{
  c.read();
}

