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
  //image(video.filter(GRAY), 0, 0);
  
  rotateY(1+sin(millis()/1000.0));
  for (int y=0; y<480; y+=10)
  {
    for (int x=0; x<640; x+=10)
    {
      color c = video.get(x, y);
      noFill();
      stroke(c);
      ellipse(x, y, 5, 5);
      // brightness(c) -> 0-255
      //line(x, y, 0, x, y, brightness(c));
    }
  }
}

// Aktuelles Videobild laden, da evtl. Framerates Sketch / Video unterschiedlich
void captureEvent(Capture c)
{
  c.read();
}

