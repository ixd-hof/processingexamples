import traer.physics.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

ParticleSystem physics;

float size = 40;

void setup()
{
  size(500, 800, P3D);
  smooth();

  minim = new Minim(this);
  player = minim.loadFile("sonemusik.mp3");

  // Plays the file on start once
  player.play();

  physics = new ParticleSystem(0.001, 0);

    Particle p = physics.makeParticle( 0.1, width/2, 0, 0);
    p.velocity().add(random(-0.01, 0.01), 0, 0);
}

void draw()
{
  physics.tick();
  
  if (size > 2)
    size -= 0.05;

  //background(200);
  
  fill(100);
  noStroke();

  // Displa0 the level
  float mix_level = map(player.mix.level(), 0, 0.25, 0, 2);

  for (int i=0; i<physics.numberOfParticles (); i++)
  {
    Particle p = physics.getParticle(i);
    //p.velocity().add(random(-0.01, 0.01), 0, 0);
    ellipse(p.position().x(), p.position().y(), size, size);
  }
}

void mousePressed()
{
  float num = random(5);
  for (int x=0; x<num; x+=1)
  {
    int root_index = int(random(physics.numberOfParticles())-1);
    Particle p_root = physics.getParticle(root_index);
    
    Particle p = physics.makeParticle( 0.1, p_root.position().x(), p_root.position().y(), 0);
    p.velocity().add(random(-0.5, 0.5), 0, 0);
    
    for (int i=0; i<physics.numberOfParticles(); i++)
    {
      //Attraction a = physics.makeAttraction(physics.getParticle(i), p, -0.1, 1.0);
    }
  }
}

