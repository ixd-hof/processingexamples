import net.java.games.input.*;
import net.java.games.input.Event;
import net.java.games.input.EventQueue;

HashMap spaceNavigator = new HashMap();

void setup()
{
  size(500, 500, P3D);

  // Print the available controllers
  listControllers();
  // Initialize the right controller
  initController(2);
}

void draw()
{
  background(0);

  // Update controller values and put them in a HashMap
  // x, y, z, rx, ry, rz, b0, b1
  spaceNavigator = updateController();

  fill(255);
  text("x: " + spaceNavigator.get("x"), 20, 20);
  text("y: " + spaceNavigator.get("y"), 20, 40);
  text("z: " + spaceNavigator.get("z"), 20, 60);
  text("rx: " + spaceNavigator.get("rx"), 20, 80);
  text("ry: " + spaceNavigator.get("ry"), 20, 100);
  text("rz: " + spaceNavigator.get("rz"), 20, 120);
  text("b0: " + spaceNavigator.get("b0"), 20, 140);
  text("b1: " + spaceNavigator.get("b1"), 20, 160);
  
  spacebox();
}

void spacebox()
{

  float mt = 40.0;
  float mr = 1.0;
  float xx = (Float)spaceNavigator.get("x");
  float yy = (Float)spaceNavigator.get("y");
  float zz = (Float)spaceNavigator.get("z");
  float rx = (Float)spaceNavigator.get("rx");
  float ry = (Float)spaceNavigator.get("ry");
  float rz = (Float)spaceNavigator.get("rz");
  float b0 = (Float)spaceNavigator.get("b0");
  float b1 = (Float)spaceNavigator.get("b1");

  pushMatrix();

  fill(100);
  translate(width/2, height/2);
  translate(xx * mt, yy * mt, zz * mt);
  rotateX(rx * mr);
  rotateY(ry * mr);
  rotateZ(rz * mr);

  box(150, 150, 150);

  popMatrix();
}

