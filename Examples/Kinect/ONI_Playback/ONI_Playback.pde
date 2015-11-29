import SimpleOpenNI.*;

SimpleOpenNI  kinect;

void setup()
{
  size(1280, 480);

  // initialize for playback
  kinect = new SimpleOpenNI(this, "recording_15-11-29_16_11.oni");

  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();
}

void draw()
{
  kinect.update();
  background(0);

  image(kinect.depthImage(), 0, 0);
  image(kinect.rgbImage(), 640, 0);
}

