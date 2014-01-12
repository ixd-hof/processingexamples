import processing.serial.*;

Serial myPort;  // Create object from Serial class
String rfid_sn;      // Data received from the serial port

void setup() 
{
  size(400, 200);

  println(Serial.list());
  String portName = Serial.list()[15];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{

  while ( myPort.available () > 0)
  {
    int in = myPort.read();
    
    if (in == 2) // start
    {
      rfid_sn = "";
    }
    else if (in == 10) // end
    {
      // detected serial number
      println("RFID Serial Number: " + rfid_sn);
      
      // call your own function
      rfid_detected(rfid_sn);
    }
    else // add bytes to seriel number
    {
      rfid_sn += (char)in;
    }
    
    //println(myPort.read());
  }
}

void rfid_detected(String id)
{
  // do something
  // if (id.equals("abcdefg")
  // ...
}
