import geomerative.*;
import traer.physics.*;

Particle mouse, p;
ParticleSystem physics;

RShape grp;

void setup()
{
  size(800, 500);
  background(255);

  physics = new ParticleSystem(1, 0.01);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);

  //frameRate(2);
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();

  for (int i=0; i<points.length; i++)
  {
    Particle p_point = physics.makeParticle(1.0, points[i].x, points[i].y, 0 );
    p_point.makeFixed();

    Particle p_random = physics.makeParticle(1.0, random(width), random(height), 0 );

    physics.makeSpring( p_point, p_random, 0.1, 1, 150);
  }
}

void draw()
{
  background(255);
  
  physics.tick();

  translate(width/2, height/2);
  //grp.draw();

  for (int i=0; i<physics.numberOfParticles(); i++)
  {
    p = physics.getParticle(i);
    ellipse(p.position().x(), p.position().y(), 10, 10);
  }
}

void mousePressed()
{
  for (int i=0; i<physics.numberOfParticles(); i++)
  {
    p = physics.getParticle(i);
    p.velocity().add(random(2), 0, 0);
  }
}

