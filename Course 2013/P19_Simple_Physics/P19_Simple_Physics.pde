import traer.physics.*;

ParticleSystem physics;
Particle p;

void setup()
{
  size(500, 500);
  frameRate(30);

  physics = new ParticleSystem(0.1, 0.01);
  // ParticleSystem( float gravityY, float drag )

  p = physics.makeParticle(1.0, width/2, height/2, 0);
  // makeParticle( float mass, float x, float y, float z )
}

void draw()
{
  // Update physics
  physics.tick();

  background(255);

  fill(0);
  ellipse(p.position().x(), p.position().y(), 20, 20);
}

void mousePressed()
{
  p.position().set(mouseX, mouseY, 0);
}

