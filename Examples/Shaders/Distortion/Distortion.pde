// Based on https://github.com/SableRaf/Processing-Experiments
PShader myShader;
PImage img, perlin_noise;
PGraphics canvas;

void setup() {
  size(640, 480, P2D);
  frameRate(30);
  noStroke();

  img = loadImage("streetview.jpg");
  perlin_noise = loadImage("perlin_noise.jpg");
  
  canvas = createGraphics(width, height, P3D);
  canvas.background(100);

  myShader = loadShader("shader.glsl");
  
  //myShader.set("resolution", float(width), float(height));   
  myShader.set("colorMap", img); //img
  myShader.set("noiseMap", canvas);
}

void draw()
{
  background(0);
  
  canvas.beginDraw();
  //canvas.background(100);
  canvas.noStroke();
  //canvas.fill(200, 10);
  //canvas.rect(0, 0, canvas.width, canvas.height);
  
  canvas.fill(255, 100);
  canvas.ellipse(mouseX, mouseY, 50, 50);
  canvas.filter(BLUR, 3);
  canvas.endDraw();

  myShader.set("time", millis() / 1000.0);
  
  shader(myShader);
  image(img, 0, 0, width, height);
  resetShader();
  image(canvas, 0, 0, 180, 120);
}

