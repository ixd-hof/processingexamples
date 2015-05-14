int h = 5;
float last_min_degrees;

// Position der Uhr
PVector center = new PVector();

void setup()
{
  size(500, 500);
  center.x = width/2;
  center.y = height/2;
}

void draw()
{
  background(255);
  
  // Winkel zwischen Maus und Uhr
  float min_angle = atan2(center.y-mouseY, center.x-mouseX)+PI/2.0; // 0° fängt in Geo bei 3h an
  float min_degrees = map(min_angle, -PI, PI, 0, 360); // In Grad umrechnen
  min_degrees = (min_degrees + 360) % 360; // Von 0-360 normieren (statt -180-180)
  println(h+ " " + last_min_degrees + " " + min_degrees);

  // Stunde einstellen
  // Wenns über die 0 von links nach rechts geht eins drauf
  if (last_min_degrees > 270 && min_degrees < 90)
    h += 1;
  // Eins runter
  else if (last_min_degrees < 90 && min_degrees > 270)
    h-=1;
  last_min_degrees = min_degrees;
  
  float hour_hangle = map(h, 0, 12, 0, 2*PI);

  // Stundenzeiger
  stroke(50);
  pushMatrix();
  translate(width/2, height/2);
  rotate(hour_hangle);
  line(0, 0, 0, -100);
  popMatrix();

  // Minutenzeiger
  stroke(150);
  pushMatrix();
  translate(width/2, height/2);
  rotate(min_angle);
  line(0, 0, 0, -150);
  popMatrix();
  
  ellipse(mouseX, mouseY, 5, 5);
}

