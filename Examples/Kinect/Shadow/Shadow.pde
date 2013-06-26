import SimpleOpenNI.*;

SimpleOpenNI context;

PGraphics persons;
PGraphics shadows;

// Pixel resolution
int dot_res = 5;

void setup()
{
  size(640, 480, P3D);
  context = new SimpleOpenNI(this);
  frameRate(30);

  // Comment out for live image
  //context.openFileRecording("test.oni");
  //println("This file has " + context.framesPlayer() + " frames.");

  // disable mirror
  context.setMirror(false);

  context.enableDepth();
  context.enableRGB();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  // enable the scene, to get the floor
  context.enableScene();

  persons = createGraphics(640, 480);
  shadows = createGraphics(640, 480);
}

void draw()
{
  background(200);

  // update the cam
  context.update();

  //image(context.depthImage(), 0, 0);

  int userCount = context.getNumberOfUsers();

  if (userCount > 0)
  {
    int[] userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);

    shadows.beginDraw();
    shadows.background(0, 0);
    shadows.fill(0);
    shadows.noStroke();
    for (int y=0; y<context.depthHeight(); y+=dot_res)
    {
      for (int x=0; x<context.depthWidth(); x+=dot_res)
      {
        int index = x + y * context.depthWidth();
        // == 0 to create a mask
        // > 0 to create a slhouette
        if (userMap[index] > 0)
        {
          shadows.rect(x, y, dot_res, dot_res);
        }
      }
    }
    shadows.endDraw();
    
    persons.beginDraw();
    persons.background(0, 0);
    persons.noStroke();
    for (int y=0; y<context.depthHeight(); y+=dot_res)
    {
      for (int x=0; x<context.depthWidth(); x+=dot_res)
      {
        int index = x + y * context.depthWidth();
        if (userMap[index] > 0)
        {
          // .rgbImage() for color silhouette
          persons.fill(context.depthImage().get(x, y));
          persons.rect(x, y, dot_res, dot_res);
        }
      }
    }
    persons.endDraw();

    pushMatrix();
    translate(20, 10, -100);
    image(shadows, 0, 0);
    popMatrix();
    pushMatrix();
    translate(0, 0, 0);
    image(persons, 0, 0);
    popMatrix();
  }
}


// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}

