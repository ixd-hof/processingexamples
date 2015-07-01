import ketai.camera.*;

import android.os.Bundle;
import android.view.WindowManager;

KetaiCamera cam;

PShader flipHalf;

void setup() {
  size(displayWidth, displayHeight, P3D);
  flipHalf = loadShader("cardboard.glsl");

  cam = new KetaiCamera(this, 640, 480, 24);
  cam.start();

  //getWindow().addFlags(this.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

  // Current fix for Android
  int w = displayWidth;
  int textureWidth = (int)pow(2, ceil(log(w) / log(2)));
  float displayCenter = map(0.5, 0, textureWidth, 0, w);
  println(w + " / " + textureWidth + " -> " + displayCenter);
  flipHalf.set("displayCenter", displayCenter);

  float factor = float(height)/float(cam.height);
  println("Faktor: " + height + " / " + cam.height + " -> " + factor);
}

void draw() {
  background(0);

  imageMode(CENTER);
  //image(cam, width/2, height/2);
  image(cam, width/4, height/2, cam.width*(float(height)/float(cam.height)), height);

  filter(flipHalf);
}

void onCameraPreviewEvent()
{
  cam.read();
}

void onCreate(Bundle bundle) {
  super.onCreate(bundle);
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

