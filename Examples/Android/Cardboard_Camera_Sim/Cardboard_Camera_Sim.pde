//import ketai.camera.*;

//import android.os.Bundle;
//import android.view.WindowManager;

import processing.video.*;

//KetaiCamera cam;
Capture cam;

PShader flipHalf;

void setup() {
  //size(displayWidth, displayHeight, P3D);
  size(800, 600, P3D);
  flipHalf = loadShader("cardboard.glsl");

  //cam = new KetaiCamera(this, 640, 480, 24);
  //cam.start();
  
  cam = new Capture(this, 320, 240);
  cam.start(); 

  //getWindow().addFlags(this.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

  // Current fix for Android
  int w = displayWidth;
  int textureWidth = (int)pow(2, ceil(log(w) / log(2)));
  float displayCenter = map(0.5, 0, textureWidth, 0, w);
  println(w + " / " + textureWidth + " -> " + displayCenter);
  displayCenter = 0.5;
  flipHalf.set("displayCenter", displayCenter);

  float factor = float(height)/float(cam.height);
  println("Faktor: " + height + " / " + cam.height + " -> " + factor);
}

void draw() {
  background(0);


  imageMode(CENTER);
  //image(cam, width/2, height/2);
  PImage cam_copy = cam.get(0, 0, cam.width, cam.height);
  cam_copy.filter(BLUR, 8);
  image(cam_copy, width/4, height/2, cam.width*(float(height)/float(cam.height)), height);

  // Clone camera image
  filter(flipHalf);
}

/*
void onCreate(Bundle bundle) {
  super.onCreate(bundle);
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

void onCameraPreviewEvent()
{
  cam.read();
}
*/

void captureEvent(Capture c) {
  c.read();
}

