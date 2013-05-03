// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Wiimote Example using WiiRemoteJ.jar and Bluecove

//WiiMote wm;
WiiBalanceBoard bb;

void setup()
{
  size(500, 500);
  wm = new WiiMote();
  bb = new WiiBalanceBoard();
}

void draw()
{
  /*
  // Wiimote
  text("Wiimote:", 20, 20);
  text("still: " + wm.still, 20, 40);
  text("button_A: " + wm.button_A, 20, 60);
  text("button_B: " + wm.button_B, 20, 80);
  // More buttons:
  // button_UP, button_DOWN, button_LEFT, button_RIGHT, button_ONE, button_TWO, button_PLUS, button_MINUS, button_HOME
  text("pitch: " + wm.pitch, 20, 100);
  text("roll: " + wm.roll, 20, 120);
  text("Acceleration: x " + wm.acc_x + " | y " + wm.acc_y + " | z " + wm.acc_z, 20, 140);
  */
  text("left: " + bb.left, 20, 20);
}

