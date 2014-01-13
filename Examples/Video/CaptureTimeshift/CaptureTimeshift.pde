/**
 * Time Displacement
 * by David Muth 
 * 
 * Keeps a buffer of video frames in memory and displays pixel rows
 * taken from consecutive frames distributed over the y-axis 
 */

import processing.video.*;

Capture video;
int signal = 0;
boolean record = false;
boolean play = false;
int max_frames = 50;
int current_image = 0;

//the buffer for storing video frames
ArrayList frames = new ArrayList();

void setup() {
  size(640, 480);

  video = new Capture(this, width, height);

  video.start();
}

void captureEvent(Capture camera)
{
  if (record == true)
  {
    camera.read();

    // Copy the current video frame into an image, so it can be stored in the buffer
    PImage img = createImage(width, height, RGB);
    video.loadPixels();
    arrayCopy(video.pixels, img.pixels);

    frames.add(img);

    // Once there are enough frames, remove the oldest one when adding a new one
    if (frames.size() > max_frames)
    {
      //frames.remove(0);
      record = false;
    }
  }
}

void draw()
{
  background(0);

  loadPixels();

  if (record == false && play == false)
  {
    image(video, 0, 0);
  }
  else if (record == true && play == false)
  {
    image(video, 0, 0);
    fill(255, 0, 0, 100);
    rect(0, 0, width, height);
  }
  else if (record == false && play == true)
  {

    if (current_image < frames.size())
    {
      PImage img = (PImage)frames.get(current_image);

      if (img != null) {
        img.loadPixels();
      }

      image(img, 0, 0);
      // Increase the image counter
      current_image++;
    } 
    else {
      current_image = 0;
    }

    updatePixels();
  }

  // For recording an image sequence
  //saveFrame("frame-####.jpg");
}

void keyPressed()
{
  if (key == '1')
  {
    record = false;
    play = false;
    println("show");
  }
  else if (key == '2')
  {
    record = true;
    play = false;
    println("record");
  }
  else if (key == '3')
  {
    record = false;
    play = true;
    println("play");
  }
}

