import processing.serial.*;

Serial port;     

int Sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
int heart = 0;   // This variable times the heart image 'pulse' on screen
boolean beat = false;    // set when a heart beat is detected, then cleared when the BPM graph is advanced

PFont myFont;


void setup()
{
  size(100, 100);
  frameRate(100);  

  // GO FIND THE ARDUINO
  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Arduino
  port = new Serial(this, Serial.list()[0], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return

  myFont = createFont("Helvetica", 32);
  textFont(myFont);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  fill(255, 0, 0);
  text(BPM, width/2, height/2);
}

void serialEvent(Serial port) { 
  String inData = port.readStringUntil('\n');
  inData = trim(inData);                 // cut off white space (carriage return)

  if (inData.charAt(0) == 'S') {          // leading 'S' for sensor data
    inData = inData.substring(1);        // cut off the leading 'S'
    Sensor = int(inData);                // convert the string to usable int
  }
  if (inData.charAt(0) == 'B') {          // leading 'B' for BPM data
    inData = inData.substring(1);        // cut off the leading 'B'
    BPM = int(inData);                   // convert the string to usable int
    beat = true;                         // set beat flag to advance heart rate graph
    heart = 20;                          // begin heart image 'swell' timer
  }
  if (inData.charAt(0) == 'Q') {            // leading 'Q' means IBI data 
    inData = inData.substring(1);        // cut off the leading 'Q'
    IBI = int(inData);                   // convert the string to usable int
  }
}

