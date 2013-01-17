// Based on:
// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

class Colortracker
{

  // A variable for the color we are searching for.
  color trackColor;
  int crop = 200;
  boolean tracked = false;
  PVector trackedColor = new PVector(0,0);

  Colortracker(color c) {
    // Start off tracking for red
    trackColor = c;
  }

  boolean update(PImage rgb_img, PVector hand) {
    PImage hand_image = rgb_img.get(int(hand.x-crop/2), int(hand.y-crop/2), crop, crop);

    // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
    float worldRecord = 500; 

    // XY coordinate of closest color
    int closestX = 0;
    int closestY = 0;

    // Begin loop to walk through every pixel
    for (int x = 0; x < hand_image.width; x ++ ) {
      for (int y = 0; y < hand_image.height; y ++ ) {
        int loc = x + y*hand_image.width;
        // What is current color
        color currentColor = hand_image.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(trackColor);
        float g2 = green(trackColor);
        float b2 = blue(trackColor);

        // Using euclidean distance to compare colors
        float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

        // If current color is more similar to tracked color than
        // closest color, save current location and current difference
        if (d < worldRecord) {
          worldRecord = d;
          closestX = x + (int)hand.x;
          closestY = y + (int)hand.y;
        }
      }
    }

    // We only consider the color found if its color distance is less than 10. 
    // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
    if (worldRecord < 10) { 
      // Draw a circle at the tracked pixel
      fill(trackColor);
      //strokeWeight(4.0);
      stroke(255);
      ellipse(closestX, closestY, 16, 16);
      trackedColor.x = closestX;
      trackedColor.y = closestY;
      
      tracked = true;
    }
    else
    {
      tracked = false;
    }
    
    return tracked;
  }

  PVector get_color()
  {
    return trackedColor;
  }
  
  void set_color(color c)
  {
    trackColor = c;
    println("New color: " + red(trackColor) + " " + green(trackColor) + " " + blue(trackColor));
  }
}

void mousePressed()
{
  colortracker_red.set_color(rgb_img.get(mouseX, mouseY));
}

