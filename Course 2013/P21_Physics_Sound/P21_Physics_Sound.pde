import traer.physics.*;
import ddf.minim.*;

Minim minim;
AudioInput in;

ParticleSystem physics;
Particle p;

void setup()
{
  size(500, 500);
  frameRate(30);

  physics = new ParticleSystem(0.1, 0);
  // ParticleSystem( float gravityY, float drag )

  p = physics.makeParticle(1.0, width/2, height/2, 0);
  // makeParticle( float mass, float x, float y, float z )

  minim = new Minim(this);

  // Read the microphones sound
  in = minim.getLineIn();
}

void draw()
{
  // Update physics
  physics.tick();

  background(255);

  if (in.mix.level() > 0.1)
  {
    p.velocity().add(0, -in.mix.level()*20, 0);
  }

  fill(0);
  ellipse(p.position().x(), p.position().y(), 20, 20);
}

