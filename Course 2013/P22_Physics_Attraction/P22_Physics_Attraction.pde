import traer.physics.*;

Particle mouse, p;
ParticleSystem physics;

void setup()
{
  size(500, 500);
  physics = new ParticleSystem();
  // ParticleSystem( float gravityY, float drag )
  
  mouse = physics.makeParticle();
  mouse.makeFixed();

  p = physics.makeParticle(1.0, random( 0, width), random(0, height ), 0);
  // makeParticle( float mass, float x, float y, float z )

  physics.makeAttraction(mouse, p, 1000, 100);
  // makeAttraction( Particle a, Particle b, float strength, float minimumDistance )
}

void draw()
{
  mouse.position().set(mouseX, mouseY, 0 ;
  physics.tick();

  background(255);

  stroke(0);
  noFill();
  ellipse(mouse.position().x(), mouse.position().y(), 35, 35);

  fill(0);
  ellipse(p.position().x(), p.position().y(), 35, 35);
}

