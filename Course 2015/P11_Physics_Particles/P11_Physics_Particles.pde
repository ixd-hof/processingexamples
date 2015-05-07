import traer.physics.*;

ParticleSystem physics;
Particle p;

void setup()
{
  size(500, 500);

  physics = new ParticleSystem(1, 0.05);
  // ParticleSystem( float gravityY, float drag )

  p = physics.makeParticle(1, width/2, 0, 0 );
  // makeParticle( float mass, float x, float y, float z )
}

void draw()
{
  physics.tick();

  background(255);

  for (int i = 0; i < physics.numberOfParticles (); i++)
  {
    p = physics.getParticle(i);
    ellipse(p.position().x(), p.position().y(), 35, 35);
  }

  if (mousePressed)
  {
    p = physics.makeParticle(1, mouseX, mouseY, 0 );
  }
}

/*
void mousePressed()
 {
 p = physics.makeParticle(1, mouseX, mouseY, 0 );
 }
 */
