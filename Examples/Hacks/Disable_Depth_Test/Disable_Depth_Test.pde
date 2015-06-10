import processing.video.*;

Capture video;

void setup()
{
  size(1280, 960, P3D);
  
  video = new Capture(this, 640, 480);
  video.start();
}

void draw()
{
  background(0);
  hint(DISABLE_DEPTH_TEST);
  image(video, 0, 0, width, height);
  
  translate(width/2, height/2, 0);
  rotateY(millis()/1000.0);
  box(200);
}

void captureEvent(Capture c)
{
  c.read();
}
