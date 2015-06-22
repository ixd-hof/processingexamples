import SimpleOpenNI.*;

SimpleOpenNI context;

void setup()
{
  size(640, 480, P3D);
  
  // Enable Kinect
  context = new SimpleOpenNI(this);
  
  // or
  // Enable and load recording in data folder
  //context = new SimpleOpenNI(this, "Kinect_02.oni");
  
  context.setMirror(false);
  context.enableDepth();

  // Enable skeleton generation for all joints
  context.enableUser();

  noStroke();
}

void draw()
{
  background(0);

  // Update Kinect
  context.update();
  
  // Draw depth image
  image(context.depthImage(), 0, 0, 80, 60);
  
  // Get number of users in scene
  int userCount = context.getNumberOfUsers();
  
  textAlign(LEFT, LEFT);
  text("Users: " + userCount, 20, 20);

  // Draw ellipse at each user's position
  for (int userId=1; userId<=userCount; userId++)
  {
    // Calculate position
    PVector world_pos = new PVector();
    PVector proj_pos = new PVector();
    context.getCoM(userId, world_pos);
    context.convertRealWorldToProjective(world_pos, proj_pos);
    
    // Top view
    int x = int(proj_pos.x); // Mirror: width - int(proj_pos.x);
    int y = int(map(proj_pos.z, 0, 5000, 0, height)); // 0-5000: Kinect max depth
    ellipse(x, y, 20, 20);
    
    println(proj_pos.x + " " + proj_pos.y + " " + proj_pos.z + " / " + y);
    
    // Draw user id
    textAlign(CENTER, CENTER);
    fill(255);
    text(userId, x, y);
  }
}
