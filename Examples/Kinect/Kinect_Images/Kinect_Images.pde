import SimpleOpenNI.*;

SimpleOpenNI context;

void setup()
{
  context = new SimpleOpenNI(this);

  // mirror is by default enabled
  context.setMirror(true);
  context.enableDepth();
  context.enableRGB();
  context.enableIR();
  context.enableScene();


  size(1280, 960);
}

void draw()
{
  // update the cam
  context.update();

  background(0);

  image(context.rgbImage(), 0, 0);
  image(context.depthImage(), 640, 0);
  image(context.sceneImage(), 640, 480);
  tint(0, 255, 0);
  image(context.irImage(), 0, 480);
  noTint();
}

