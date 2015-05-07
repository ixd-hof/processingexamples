// Thanks to https://github.com/jherico/
// and 38leinaD https://developer.oculusvr.com/forums/viewtopic.php?f=20&t=88&p=39427#p977
// Image: NASA https://commons.wikimedia.org/wiki/File:Buzz_Aldrin_Apollo_Spacesuit.jpg

// A very basic example hwo to render a sketch on Oculus Rift

import oscP5.*;
import netP5.*;
import javax.vecmath.Matrix4f;

OscP5 oscP5;
Matrix4f matrix4x4 = new Matrix4f();

Matrix4f invertx_matrix4x4 = new Matrix4f();

PShader barrel;
PGraphics fb;
PGraphics scene;
PImage img;

int eye_width = 640;
int eye_height = 800;

void setup() {
  size(1280, 800, P3D);

  oscP5 = new OscP5(this, 10000);

  // Load background image
  img = loadImage("buzz.jpg");

  // Create framebuffer
  fb = createGraphics(width, height, P3D);
  // Create PGraphics for actual scene
  scene = createGraphics(eye_width, eye_height, P3D);

  // Load fragment shader for oculus rift barrel distortion
  barrel = loadShader("barrel_frag.glsl");
}

void draw() {
  background(0);

  lights();

  // Draw actual scene
  // Bg image and a rotating box
  scene.beginDraw();
  scene.background(0);

  float pos_x = width/2;
  float pos_y = height/2;
  float pos_z = -433; // ?
  /*
  scene.applyMatrix(matrix4x4[0], matrix4x4[1], matrix4x4[2], pos_x, 
  matrix4x4[4], matrix4x4[5], matrix4x4[6], pos_y, 
  matrix4x4[8], matrix4x4[9], matrix4x4[10], 0, 
  matrix4x4[12], matrix4x4[13], matrix4x4[14], matrix4x4[15]);
  */
  
  scene.applyMatrix(matrix4x4.m00, matrix4x4.m01, matrix4x4.m02, pos_x, 
  matrix4x4.m10, matrix4x4.m11, matrix4x4.m12, pos_y, 
  matrix4x4.m20, matrix4x4.m21, matrix4x4.m22, 0, 
  matrix4x4.m30, matrix4x4.m31, matrix4x4.m32, matrix4x4.m33);

  //printMatrix();

  scene.translate(0, 0, pos_z);
  //scene.noFill();
  //scene.stroke(255);
  scene.fill(255);
  scene.box(150);
  scene.translate(-200, 0, 0);
  scene.fill(255, 0, 100);
  scene.box(150);
  scene.fill(100, 0, 255);
  scene.translate(400, 0, 0);
  scene.box(150);
  /*
  scene.image(img, 0, 0);
   scene.fill(200, 200, 200, 100);
   scene.translate(scene.width/2, scene.height/2, 100);
   scene.rotateX(millis()/1000.0);
   scene.rotateY(millis()/900.0);
   scene.box(100, 100, 100);
   */
  scene.endDraw();

  blendMode(ADD);

  // Render left eye
  set_shader("left");
  shader(barrel);
  fb.beginDraw();
  fb.background(0);
  fb.image(scene, 50, 0, eye_width, eye_height);
  fb.endDraw();
  image(fb, 0, 0);

  resetShader();

  // Render right eye
  set_shader("right");
  shader(barrel);
  fb.beginDraw();
  fb.background(0);
  fb.image(scene, eye_width-50, 0, eye_width, eye_height);
  fb.endDraw();
  image(fb, 0, 0);
}

void set_shader(String eye)
{
  float x = 0.0;
  float y = 0.0;
  float w = 0.5;
  float h = 1.0;
  float DistortionXCenterOffset = 0.25;
  float as = w/h;

  float K0 = 1.0f;
  float K1 = 0.22f;
  float K2 = 0.24f;
  float K3 = 0.0f;

  float scaleFactor = 0.7f;

  if (eye == "left")
  {
    x = 0.0f;
    y = 0.0f;
    w = 0.5f;
    h = 1.0f;
    DistortionXCenterOffset = 0.25f;
  }
  else if (eye == "right")
  {
    x = 0.5f;
    y = 0.0f;
    w = 0.5f;
    h = 1.0f;
    DistortionXCenterOffset = -0.25f;
  }

  barrel.set("LensCenter", x + (w + DistortionXCenterOffset * 0.5f)*0.5f, y + h*0.5f);
  barrel.set("ScreenCenter", x + w*0.5f, y + h*0.5f);
  barrel.set("Scale", (w/2.0f) * scaleFactor, (h/2.0f) * scaleFactor * as);
  barrel.set("ScaleIn", (2.0f/w), (2.0f/h) / as);
  barrel.set("HmdWarpParam", K0, K1, K2, K3);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/headsetorientation")) {
    for (int r=0; r<3; r++)
    {
      for (int c=0; c<3; c++)
      {
        matrix4x4.setElement(r, c, theOscMessage.get(r*3+c).floatValue());
        //matrix4x4[i] = theOscMessage.get(i).floatValue();
      }
    }
  }
  println(theOscMessage.get(0).floatValue(), matrix4x4.m00);
  //println(matrix4x4.toString());
  /*
  println(matrix4x4[0] + " " + matrix4x4[1] + " " + matrix4x4[2] + " " + matrix4x4[3]);
  println(matrix4x4[4] + " " + matrix4x4[5] + " " + matrix4x4[6] + " " + matrix4x4[7]);
  println(matrix4x4[8] + " " + matrix4x4[9] + " " + matrix4x4[10] + " " + matrix4x4[11]);
  println(matrix4x4[12] + " " + matrix4x4[13] + " " + matrix4x4[14] + " " + matrix4x4[15]);
  println();
  */
  //println(matrix4x4[3] + " " + matrix4x4[7] + " " + matrix4x4[11]);
}

