import net.java.games.input.*;

Controller gamepad;
Component [] components;

void setup()
{
  size(500, 500);
  
  ControllerEnvironment ca = ControllerEnvironment.getEnvironment();
  Controller[] controllers = ca.getControllers();
  for (int i=0; i<controllers.length; i++)
  {
    System.out.println(i + ": " + controllers[i].getName());
  }

  gamepad = controllers[6];
  components = gamepad.getComponents();
  println(components);
}

void draw()
{
  background(0);
  
  gamepad.poll();

  float x = components[14].getPollData();
  float y = components[15].getPollData();

  println("x: " + x + " | y: " + y);

  float xs = map(x, -1, 1, 0, width);
  float ys = map(y, -1, 1, 0, height);
  
  noFill();
  stroke(255);
  ellipse(xs, ys, 100, 100);
  fill(255);
  noStroke();
  ellipse(xs, ys, 25, 25);
}

