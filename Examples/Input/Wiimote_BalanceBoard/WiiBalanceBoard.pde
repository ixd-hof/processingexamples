// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

import wiiremotej.*;
import wiiremotej.event.*;


public class WiiBalanceBoard extends BalanceBoardAdapter
{
	 private BalanceBoard remote;
	 public double totalmass, front, back, left, right, x, y;
	 public boolean button;
	 
    public WiiBalanceBoard()
    {
        //basic console logging options...
        WiiRemoteJ.setConsoleLoggingAll();
        //WiiRemoteJ.setConsoleLoggingOff();
        
        try
        {   
            //Find and connect to a Wii Remote
            BalanceBoard remote = WiiRemoteJ.findBalanceBoard();
            //WiiRemote remote = WiiRemoteJ.connectToRemote("btl2cap://0017AB29BB7B");
            remote.addBalanceBoardListener(this);
        }
        catch(Exception e){e.printStackTrace();}
    }
    
    /*
    public IRBalanceBoard(BalanceBoard remote)
    {
        this.remote = remote;
    }
    */
    
    public void disconnected()
    {
        System.out.println("Remote disconnected... Please Wii again.");
        System.exit(0);
    }
    
    public void buttonInputReceived(BBButtonEvent evt)
    {
    	button = evt.isPressed();
    }
    
    public void massInputReceived(BBMassEvent evt)
    {
    	totalmass = evt.getTotalMass();
    	double mass00 = evt.getMass(0, 0);
    	double mass01 = evt.getMass(0, 1);
    	double mass10 = evt.getMass(1, 0);
    	double mass11 = evt.getMass(1, 1);
    	
    	front = (mass00 + mass01) / totalmass;
    	back = (mass10 + mass11) / totalmass;
    	right = (mass00 + mass10) / totalmass;
    	left = (mass01 + mass11) / totalmass;
    	
    	x = front;
    	y = left;
    }
}
