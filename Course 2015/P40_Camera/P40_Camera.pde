import processing.video.*;

Capture video;

void setup()
{
  size(640, 480);

  // Webcam starten
  video = new Capture(this, 640, 480);
  video.start();
}

void draw()
{
  colorMode(HSB, 360, 100, 100);
  tint(millis()%360, 100, 100);
  // Video anzeigen
  image(video, 0, 0);
}

// Aktuelles Videobild laden, da evtl. Framerates Sketch / Video unterschiedlich
void captureEvent(Capture c)
{
  c.read();
}

