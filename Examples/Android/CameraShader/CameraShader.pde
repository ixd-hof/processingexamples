import ketai.camera.*;

KetaiCamera cam;

// Based on https://github.com/SableRaf/Processing-Experiments
PShader myShader;
PImage img, dot;
PGraphics canvas;

void setup() {
  size(displayWidth, displayHeight, P2D);
  orientation(LANDSCAPE);
  frameRate(30);
  noStroke();
  
  cam = new KetaiCamera(this, 320, 240, 24);

  img = loadImage("streetview.jpg");
  dot = loadImage("dot.png");
  
  canvas = createGraphics(width, height, P3D);
  canvas.background(100);

  myShader = loadShader("distortion.glsl");
  
  //myShader.set("resolution", float(width), float(height));   
  myShader.set("colorMap", cam); //img
  myShader.set("noiseMap", canvas);
}

void draw()
{
  background(0);
  
  if (millis() > 1000 && cam.isStarted() == false)
    cam.start();
    
  canvas.beginDraw();
  //canvas.background(100);
  canvas.noStroke();
  //canvas.fill(200, 10);
  //canvas.rect(0, 0, canvas.width, canvas.height);
  
  canvas.fill(255, 100);
  //canvas.ellipse(mouseX, mouseY, 50, 50);
  //canvas.filter(BLUR, 3);
  canvas.image(dot, mouseX, mouseY, 100, 100);
  canvas.endDraw();

  myShader.set("time", millis() / 1000.0);
  
  shader(myShader);
  image(cam, 0, 0, width, height);
  resetShader();
  image(canvas, 0, 0, 180, 120);
}

void onCameraPreviewEvent()
{
  cam.read();
}

