import SimpleOpenNI.*;

PImage depth_img;
PImage rgb_img;

SimpleOpenNI context;

void setup()
{
  size(640, 480, P3D);
  //smooth();
  noStroke();
  fill(255, 100, 0);
  
  frameRate(20);

  // Enable OpenNI
  context = new SimpleOpenNI(this);
  
  // Load recorded scene
  // Comment out for live image
  context.openFileRecording("test.oni");
  
  context.setMirror(true);
  context.enableDepth(); // Kinect depth image
  context.enableRGB(); // Kinect color image
  context.enableUser(); // enable skeleton
}

void draw()
{
  background(0);

  // update OpenNI
  context.update();
  // get depth and color image
  depth_img = context.depthImage();
  rgb_img = context.rgbImage();
  
  // display despth image
  image(depth_img, 0, 0);
  //image(rgb_img, 0, 0);
  
  // update skeleton
  boolean tracking = updateSketeton();
  
  if (tracking = true)
  {
    // distance from head to hands
    float d_left = SKEL_LEFT_HAND.y - SKEL_HEAD.y;
    float d_right = SKEL_RIGHT_HAND.y - SKEL_HEAD.y;
    
    if (d_left < 100)
    {
    // adjust max value until it fits your color
    float hue = map(d_left, 0, 320, 0, 360);
    
    colorMode(HSB, 360, 100, 100);
    tint(hue, 100, 100);
    image(depth_img, 0, 0);
    noTint();
    }
    else
    {
     fill(0, 0, 100);
    }
    
    /*
    // if right hand over head
    if (d_right < 0)
    {
      pointLight(200, 200, 200, 200, 200, 200);
    }
    else
    {
      noLights();
    }
    */
    
    fill(255, 100, 0);
    pushMatrix();
    translate(SKEL_LEFT_HAND.x, SKEL_LEFT_HAND.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();
    
    fill(255, 100, 255);
    pushMatrix();
    translate(SKEL_RIGHT_HAND.x, SKEL_RIGHT_HAND.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();
    
    fill(255, 100, 0);
    pushMatrix();
    translate(SKEL_HEAD.x, SKEL_HEAD.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();
  }
}
