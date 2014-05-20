import de.yadrone.base.IARDrone;
import de.yadrone.base.command.CommandManager;
import de.yadrone.base.command.LEDAnimation;

IARDrone drone;

void setup()
{
  drone = new ARDrone();
  drone.addExceptionListener(new IExceptionListener() {
    public void exeptionOccurred(ARDroneException exc)
    {
      exc.printStackTrace();
    }
  }
  );

  drone.start();
  
  drone.getCommandManager().setLedsAnimation(LEDAnimation.BLINK_ORANGE, 3, 10);
}

void draw()
{
}

void keyPressed()
{
  if (keyCode == UP)
    drone.getCommandManager().takeOff();
  else if (keyCode == DOWN)
    drone.getCommandManager().landing();
    /*
  else if (keyCode == LEFT)
    send_command(rotate_left);
  else if (keyCode == RIGHT)
    send_command(rotate_right);
    */
}

void send_command(String command)
{
}

