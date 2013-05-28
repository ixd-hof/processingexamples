import SimpleOpenNI.*;
import traer.physics.*;

SimpleOpenNI context;

ParticleSystem physics;

PVector last_vector = new PVector();
PVector user_velocity = new PVector();

void setup()
{
  size(640, 480, P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);

  // Comment out for live image
  context.openFileRecording("test.oni");
  println("This file has " + context.framesPlayer() + " frames.");

  // disable mirror
  context.setMirror(false);

  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  // enable the scene, to get the floor
  context.enableScene();
  
  physics = new ParticleSystem(1, 0);

  textAlign(CENTER, CENTER);
  noStroke();
}

void draw()
{
  background(0);

  // update the cam
  context.update();
  
  physics.tick();

  int userCount = context.getNumberOfUsers();
  int[] userMap = null;

  if (userCount > 0)
  {
    userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    for (int y=0; y<context.depthHeight(); y+=20)
    {
      for (int x=0; x<context.depthWidth(); x+=20)
      {
        int index = x + y * context.depthWidth();
        if (userMap[index] > 0)
        {
        fill(255);
        //text(userMap[index], x, y);
        Particle p = physics.makeParticle( 1.0, x, y, 0 );
        p.velocity().add(user_velocity.x+random(5), user_velocity.y+random(5), 0);
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
    
    user_velocity.x = proj_pos.x - last_vector.x;
    user_velocity.y = proj_pos.y - last_vector.y;
    
    pushMatrix();
    translate(proj_pos.x, proj_pos.y, 0);
    fill(255, 0, 100);
    ellipse(0, 0, 20, 20);
    fill(255);
    text(userId, 0, 0);
    popMatrix();
    
    last_vector = proj_pos;
  }
  
  for (int i=0; i<physics.numberOfParticles(); i++)
  {
    Particle p = physics.getParticle(i);
    
    fill(255, 0, 100, 255-p.age()*10);
    ellipse(p.position().x(), p.position().y(), 10, 10);
    
    if (p.age() > 100)
    {
      physics.removeParticle(p);
    }
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

