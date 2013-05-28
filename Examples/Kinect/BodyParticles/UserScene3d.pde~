/* --------------------------------------------------------------------------
 * SimpleOpenNI UserScene3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhkd / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 * this demos is at the moment only for 1 user, will be implemented later
 * ----------------------------------------------------------------------------
 */
 
import SimpleOpenNI.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);
color[]      userColors = { color(255,0,0), color(0,255,0), color(0,0,255), color(255,255,0), color(255,0,255), color(0,255,255) };
color[]      userCoMColors = { color(255,100,100), color(100,255,100), color(100,100,255), color(255,255,100), color(255,100,255), color(100,255,255) };

void setup()
{
  size(1024,768,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
   
  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  if(context.enableDepth() == false)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  
  // enable the scene, to get the floor
  context.enableScene();
  
  stroke(255,255,255);
  smooth();  
  perspective(radians(45),
              float(width)/float(height),
              10,150000);
 }

void draw()
{
  // update the cam
  context.update();

  background(0,0,0);
  
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  int[]   depthMap = context.depthMap();
  int     steps   = 3;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
 
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera

  int userCount = context.getNumberOfUsers();
  int[] userMap = null;
  if(userCount > 0)
  {
    userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
  }
  
  for(int y=0;y < context.depthHeight();y+=steps)
  {
    for(int x=0;x < context.depthWidth();x+=steps)
    {
      index = x + y * context.depthWidth();
      if(depthMap[index] > 0)
      { 
        // get the realworld points
        realWorldPoint = context.depthMapRealWorld()[index];
        
        // check if there is a user
        if(userMap != null && userMap[index] != 0)
        {  // calc the user color
          int colorIndex = userMap[index] % userColors.length;
          stroke(userColors[colorIndex]); 
        }
        else
          // default color
          stroke(100); 
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
      }
    } 
  } 
  
  // draw the center of mass
  PVector pos = new PVector();
  pushStyle();
    strokeWeight(15);
    for(int userId=1;userId <= userCount;userId++)
    {
      context.getCoM(userId,pos);
   
      stroke(userCoMColors[userId % userCoMColors.length]);
      point(pos.x,pos.y,pos.z);
    }  
  popStyle();
  
  /*
  // draw the floor
  PVector floorCenter = new PVector();
  PVector floorNormal = new PVector();
  PVector floorEnd = new PVector();
  
  context.getSceneFloor(floorCenter,floorNormal);
  floorEnd = PVector.add(floorCenter,PVector.mult(floorNormal,1000));
  println(floorCenter + " - " + floorEnd);
  pushStyle();
    strokeWeight(8);
    stroke(0,255,255);
    line(floorCenter.x,floorCenter.y,floorCenter.z,
         floorEnd.x,floorEnd.y,floorEnd.z);
     stroke(0,255,100);     
    line(floorEnd.x,floorEnd.y,floorEnd.z,
         0,0,0);
  popStyle();
  */ 
  
  // draw the kinect cam
  context.drawCamFrustum();
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


// -----------------------------------------------------------------
// Keyboard events

void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }
    
  switch(keyCode)
  {
    case LEFT:
      rotY += 0.1f;
      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;
      break;
    case UP:
      if(keyEvent.isShiftDown())
        zoomF += 0.01f;
      else
        rotX += 0.1f;
      break;
    case DOWN:
      if(keyEvent.isShiftDown())
      {
        zoomF -= 0.01f;
        if(zoomF < 0.01)
          zoomF = 0.01;
      }
      else
        rotX -= 0.1f;
      break;
  }
}
