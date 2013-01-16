import SimpleOpenNI.*;
import fingertracker.*;

PImage depth_img;
PImage rgb_img;
Fingers lefthand, righthand;

SimpleOpenNI context;

Colortracker colortracker_red;

void setup()
{
  size(640, 480, P3D);
  //smooth();
  noStroke();
  fill(255, 100, 0);

  frameRate(20);

  // Enable OpenNI
  context = new SimpleOpenNI(this);
  context.setMirror(true);
  context.enableDepth(); // Kinect depth image
  context.enableRGB(); // Kinect color image
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL); // enable skeleton
  context.alternativeViewPointDepthToImage(); // align depth data to image data

  // Initialize finger tracking.
  // init_fingers(this, boolean only_hand);
  lefthand = new Fingers(this, true);

  righthand = new Fingers(this, true);
  
  // Color Tracker
  color finger_red = color(255, 0, 0);
  colortracker_red = new Colortracker(finger_red);
}

void draw()
{
  background(0);

  // update OpenNI
  context.update();
  // get depth and color image
  depth_img = context.depthImage();
  rgb_img = context.rgbImage();

  // display depth image
  image(rgb_img, 0, 0);
  //tint(255, 126);
  image(depth_img, 0, 0);
  noTint();

  // update skeleton
  boolean tracking = updateSketeton();

  if (tracking = true)
  {
    fill(255, 100, 0);
    pushMatrix();
    translate(SKEL_LEFT_HAND.x, SKEL_LEFT_HAND.y, 0);
    ellipse(0, 0, 20, 20);
    popMatrix();

    // Detect and draw fingers of the left hand
    lefthand.update(context.depthMap(), SKEL_LEFT_HAND);
    lefthand.draw_fingers();
    lefthand.draw_contour();

    int num_fingers_left = lefthand.count_fingers();
    text("Fingers left: " + num_fingers_left, 20, 40);

    if (num_fingers_left > 0)
    {
      PVector[] fingers = lefthand.get_fingers();

      for (int i=0; i<num_fingers_left; i++)
      {
        fill(0, 255, 255);
        pushMatrix();
        text(i, fingers[i].x, fingers[i].y);
        popMatrix();
        
        color f = rgb_img.get((int)fingers[i].x, (int)fingers[i].y);
        fill(f);
        rect(50*i, 0, 50, 50);
      }
    }
    
    // Color tracker
   boolean color_found = colortracker_red.update(rgb_img, SKEL_LEFT_HAND);
  }

  /*
  
   fill(255, 100, 255);
   pushMatrix();
   translate(SKEL_RIGHT_HAND.x, SKEL_RIGHT_HAND.y, 0);
   ellipse(0, 0, 20, 20);
   popMatrix();
   
   // Detect and draw fingers of the right hand
   righthand.update(context.depthMap(), SKEL_RIGHT_HAND);
   righthand.draw_fingers();
   righthand.draw_contour();
   
   int num_fingers_right = righthand.count_fingers();
   text("Fingers right: " + num_fingers_right, 20, 60);
   
   if (num_fingers_right > 0)
   {
   PVector[] fingers = righthand.get_fingers();
   
   for (int i=0; i<num_fingers_right; i++)
   {
   fill(0, 255, 255);
   text(i, fingers[i].x , fingers[i].y);
   }
   }
   */
}

void mousePressed()
{
  colortracker_red.set_color(rgb_img.get(mouseX, mouseY));
}
