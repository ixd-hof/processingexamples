import SimpleOpenNI.*;

SimpleOpenNI context;

void setup()
{
  size(640, 480, P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);

  context.openFileRecording("test2.oni");
  println("This file has " + context.framesPlayer() + " frames.");

  // disable mirror
  context.setMirror(false);

  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  // enable the scene, to get the floor
  context.enableScene();

  textAlign(CENTER, CENTER);
  noStroke();
}

void draw()
{
  background(0);

  // update the cam
  context.update();

  int userCount = context.getNumberOfUsers();
  int[] userMap = null;

  if (userCount > 0)
  {
    userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    for (int y=0; y<context.depthHeight(); y+=10)
    {
      for (int x=0; x<context.depthWidth(); x+=10)
      {
        int index = x + y * context.depthWidth();
        if (userMap[index] > 0)
        {
        fill(255);
        text(userMap[index], x, y);
        }
      }
    }
  }
  else
  {
    image(context.depthImage(), 0, 0);
  }

  for (int userId=1; userId<=userCount; userId++)
  {
    PVector world_pos = new PVector();
    PVector proj_pos = new PVector();
    context.getCoM(userId, world_pos);
    context.convertRealWorldToProjective(world_pos, proj_pos);

    pushMatrix();
    translate(proj_pos.x, proj_pos.y, 0);
    fill(255, 0, 100);
    ellipse(0, 0, 20, 20);
    fill(255);
    text(userId, 0, 0);
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

