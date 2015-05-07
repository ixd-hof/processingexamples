import SimpleOpenNI.*;

SimpleOpenNI context;

void setup()
{
  size(640, 480);

  context = new SimpleOpenNI(this);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser();
}

void draw()
{
  // update the cam
  context.update();

  // draw depthImageMap
  image(context.depthImage(), 0, 0);
  //image(context.userImage(),0,0);


  int[] userList = context.getUsers();
  println(userList.length);

  if (userList.length > 0)
  {
    //tint(0, 255, 100, 100);
    //noStroke();
    //rect(0, 0, width, height);
    
    PVector com = new PVector(); 
    PVector com2d = new PVector(); 
    
    if(context.getCoM(userList[0], com))
    {
      context.convertRealWorldToProjective(com,com2d);
      translate(com2d.x, com2d.y);
      ellipse(0, 0, 20, 20);
    }
  }
}

