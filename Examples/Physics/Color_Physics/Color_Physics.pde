import traer.physics.*;

ParticleSystem physics;
color [] colors = {
};

void setup()
{
  size(500, 500);
  frameRate(30);

  physics = new ParticleSystem(0.1, 0);
  // ParticleSystem( float gravityY, float drag )
}

void draw()
{
  // Update physics
  physics.tick();

  background(255);

  for (int i=0; i<physics.numberOfParticles(); i++)
  {
    Particle p = physics.getParticle(i);
    
    // Get color from color array at position i
    fill(colors[i]);
    ellipse(p.position().x(), p.position().y(), 20, 20);

    if (p.age() > 500)
    {
      physics.removeParticle(p);
      
      // Cut color at position i
      color [] colors_left = subset(colors, 0, i-1);
      color [] colors_right = subset(colors, i+1);
      colors = concat(colors_left, colors_right);
    }
  }
}

void mouseDragged()
{
  // Create new particle
  Particle p = physics.makeParticle( 1.0, mouseX, mouseY, 0 );
  // Add color of particle to the color array
  colors = append(colors, color(random(255), random(255), 255));
  // makeParticle( float mass, float x, float y, float z )
}

