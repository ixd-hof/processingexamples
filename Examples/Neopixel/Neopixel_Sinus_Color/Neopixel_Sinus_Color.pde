import processing.serial.*;

Serial myPort;
int val;

void setup() 
{
  size(255, 255);
  frameRate(25);

  println(Serial.list()); 
  
  // Open serial port
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  
  // Reset all LEDs (may flicker)
  myPort.write("123 0 0 0\n");
}

void draw()
{
  background(255);
  
  // Fade one LED from off to white
  int c = int(map(sin(millis()/1000.0)), -1, 1, 0, 255);
  myPort.write("0 " + c + " " + c + " " + c + "\n");
  
  // Knight Rider light
  /*
  for (int i=0; i<8; i++)
  {
    int c = int(map(sin(millis()/1000.0 + i)), -1, 1, 0, 255);
    myPort.write(i + " " + c + " " + c + " " + c + "\n");
  }
  */
}

void mouseDragged()
{
  // Reset all LEDs (may flicker)
  myPort.write("123 0 0 0\n");
  // Alternative directly disable LED
  // myPort.write("0 0 0 0\n");
  // myPort.write("1 0 0 0\n");

  // Map mouseY to 0-16
  int p = int(map(mouseY, 0, height, 0, 16));

  // Activate only one LED to color 50 50 50
  // Protocol: "led r g b\n"
  myPort.write(p + " 50 50 50\n");
  
  // Set random color
  // myPort.write(p + " " + int(random(255)) + " " + int(random(255)) + " " + int(random(255)) + "\n");
}

