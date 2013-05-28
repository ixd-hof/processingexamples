import traer.physics.*;

ParticleSystem physics;

void setup()
{
  size(500, 500);
  frameRate(30);
  
  physics = new ParticleSystem(0.1, 0);
  // ParticleSystem( float gravityY, float drag )
  
  Particle p = physics.makeParticle(1.0, width/2, height/2, 0);
  // makeParticle( float mass, float x, float y, float z )
}

void draw()
{
  // Update physics
  physics.tick();

  background(255);
  
  for (int i=0; i<physics.numberOfParticles(); i++)
  {
    Particle p = physics.getParticle(i);
    
    fill(0);
    ellipse(p.position().x(), p.position().y(), 20, 20);
    
    if (p.age() > 500)
    {
      physics.removeParticle(p);
    }
  }
}

void mouseDragged()
{
 Particle p = physics.makeParticle( 1.0, mouseX, mouseY, 0 );
  // makeParticle( float mass, float x, float y, float z ) 
}
