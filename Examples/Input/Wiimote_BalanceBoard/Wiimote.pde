// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

import wiiremotej.*;
import wiiremotej.event.*;

public class WiiMote extends WiiRemoteAdapter
{
  private WiiRemote remote;
  public float acc_x, acc_y, acc_z;
  private float last_acc_x, last_acc_y, last_acc_z;
  public float relative_acc_x, relative_acc_y, relative_acc_z;
  public float pitch, roll;
  public boolean still = true;
  public boolean button_A, button_B, button_UP, button_DOWN, button_LEFT, button_RIGHT, button_ONE, button_TWO, button_PLUS, button_MINUS, button_HOME;

  public WiiMote()
  {
    WiiRemoteJ.setConsoleLoggingAll();
    //WiiRemoteJ.setConsoleLoggingOff();

    try
    {   
      WiiRemote remote = WiiRemoteJ.findRemote();
      remote.addWiiRemoteListener(this);
      remote.setAccelerometerEnabled(true);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  public void disconnected()
  {
    System.out.println("Remote disconnected... Please Wii again.");
    System.exit(0);
  }

  public void buttonInputReceived(WRButtonEvent evt)
  {
    button_A = evt.isPressed(WRButtonEvent.A);
    button_B = evt.isPressed(WRButtonEvent.B);
    button_UP = evt.isPressed(WRButtonEvent.UP);
    button_DOWN = evt.isPressed(WRButtonEvent.DOWN);
    button_LEFT = evt.isPressed(WRButtonEvent.LEFT);
    button_RIGHT = evt.isPressed(WRButtonEvent.RIGHT);
    button_ONE = evt.isPressed(WRButtonEvent.ONE);
    button_TWO = evt.isPressed(WRButtonEvent.TWO);
    button_PLUS = evt.isPressed(WRButtonEvent.PLUS);
    button_MINUS = evt.isPressed(WRButtonEvent.MINUS);
    button_HOME = evt.isPressed(WRButtonEvent.HOME);
  }

  public void accelerationInputReceived(WRAccelerationEvent evt)
  {
    acc_x = (float)evt.getXAcceleration();
    acc_y = (float)evt.getYAcceleration();
    acc_z = (float)evt.getZAcceleration();
    
    relative_acc_x = last_acc_x - acc_x;
    relative_acc_y = last_acc_y - acc_y;
    relative_acc_z = last_acc_z - acc_z;
    
    last_acc_x = acc_x;
    last_acc_y = acc_y;
    last_acc_z = acc_z;
    
    pitch = (float)evt.getPitch();
    roll = (float)evt.getRoll();
    
    still = evt.isStill();
  }
}

