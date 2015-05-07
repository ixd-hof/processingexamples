import geomerative.*;
import traer.physics.*;

Particle mouse, p;
ParticleSystem physics;

String [] text;

RShape grp;

void setup()
{
  size(800, 500);
  background(255);

  physics = new ParticleSystem(0, 0.01);

  RG.init(this);

  grp = RG.getText("Code", "FiraMono-Medium.ttf", 200, CENTER);

  //frameRate(2);
  RG.setPolygonizer(RG.UNIFORMLENGTH); //BYPOINT);
  RG.setPolygonizerLength(10);

  RPoint[] points = grp.getPoints();
  
  text = new String[points.length];
  
  println(points.length);

  for (int i=0; i<points.length; i++)
  {
    Particle p_point = physics.makeParticle(1.0, points[i].x, points[i].y, 0 );
    p_point.makeFixed();

    Particle p_random = physics.makeParticle(1.0, points[i].x+random(-100, 100), points[i].y+random(-100, 100), 0 );

    //physics.makeSpring( p_point, p_random, 0.5, 2, 1);
    physics.makeAttraction( p_point, p_random, 1000, 200);
    
    text[i] = char((int)random(65, 90)) + "";
  }
}

void draw()
{
  background(255);

  physics.tick();

  translate(width/2, height/2);
  //grp.draw();

  for (int i=0; i<physics.numberOfParticles ()-2; i++)
  {
    p = physics.getParticle(i);
    //Particle p2 = physics.getParticle(i+1);
    //ellipse(p.position().x(), p.position().y(), 10, 10);
    fill(0);
    text(text[i/2], p.position().x(), p.position().y());
    //line(p.position().x(), p.position().y(), p2.position().x(), p2.position().y());

    if (mousePressed)
    {
      p.velocity().add(random(-2, 2), 0, 0);
    }
  }
}

