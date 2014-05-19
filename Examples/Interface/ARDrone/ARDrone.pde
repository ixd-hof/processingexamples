import java.net.*;
import java.util.*;

String ip = "192.168.1.1";
byte[] ip_bytes;

// commands
String takeoff = "AT*REF=101,290718208";
String landing = "AT*REF=102,290717696";
String rotate_left = "AT*ANIM=401,0,1000"; // -30
String rotate_right = "AT*ANIM=402,1,1000"; // +30

void setup()
{

  // IP to bytes
  StringTokenizer st = new StringTokenizer(ip, ".");
  ip_bytes = new byte[4];

  if (st.countTokens() == 4) {
    for (int i = 0; i < 4; i++) {
      ip_bytes[i] = (byte)Integer.parseInt(st.nextToken());
    }
  }
}

void draw()
{
}

void keyPressed()
{
  if (keyCode == UP)
    send_command(takeoff);
  else if (keyCode == DOWN)
    send_command(landing);
  else if (keyCode == LEFT)
    send_command(rotate_left);
  else if (keyCode == RIGHT)
    send_command(rotate_right);
}

void send_command(String command)
{
  try {
  DatagramSocket socket = new DatagramSocket();
  socket.setSoTimeout(3000);
  byte[] buffer = command.getBytes();
  DatagramPacket packet = new DatagramPacket(buffer, buffer.length, InetAddress.getByAddress(ip_bytes), 5556);
  socket.send(packet);
  socket.receive(packet);
  } catch (Exception e) { println(e); }
}


/*

 Documentation by MAPGPS
 https://projects.ardrone.org/attachments/192/ARDrone.java
 
 UI_BIT:
 00010001010101000000000000000000
 |   | | | |        || | ||||+--0: Button turn to left
 |   | | | |        || | |||+---1: Button altitude down (ah - ab)
 |   | | | |        || | ||+----2: Button turn to right
 |   | | | |        || | |+-----3: Button altitude up (ah - ab)
 |   | | | |        || | +------4: Button - z-axis (r1 - l1)
 |   | | | |        || +--------6: Button + z-axis (r1 - l1)
 |   | | | |        |+----------8: Button emergency reset all
 |   | | | |        +-----------9: Button Takeoff / Landing
 |   | | | +-------------------18: y-axis trim +1 (Trim increase at +/- 1??/s)
 |   | | +---------------------20: x-axis trim +1 (Trim increase at +/- 1??/s)
 |   | +-----------------------22: z-axis trim +1 (Trim increase at +/- 1??/s)
 |   +-------------------------24: x-axis +1
 +-----------------------------28: y-axis +1
 
 AT*REF=<sequence>,<UI>
 AT*PCMD=<sequence>,<enable>,<pitch>,<roll>,<gaz>,<yaw>
 (float)0.01 = (int)1008981770    (float)-0.01 = (int)-1138501878
 (float)0.05 = (int)1028443341    (float)-0.05 = (int)-1119040307
 (float)0.1  = (int)1036831949    (float)-0.1  = (int)-1110651699
 (float)0.2  = (int)1045220557    (float)-0.2  = (int)-1102263091
 (float)0.5  = (int)1056964608    (float)-0.5  = (int)-1090519040
 AT*ANIM=<sequence>,<animation>,<duration>
 AT*CONFIG=<sequence>,\"<name>\",\"<value>\"
 
 altitude max2m:  java ARDrone 192.168.1.1 AT*CONFIG=1,\"control:altitude_max\",\"2000\"
 Takeoff:  java ARDrone 192.168.1.1 AT*REF=101,290718208
 Landing:  java ARDrone 192.168.1.1 AT*REF=102,290717696
 Hovering:  java ARDrone 192.168.1.1 AT*PCMD=201,1,0,0,0,0
 gaz 0.1:  java ARDrone 192.168.1.1 AT*PCMD=301,1,0,0,1036831949,0
 gaz -0.1:  java ARDrone 192.168.1.1 AT*PCMD=302,1,0,0,-1110651699,0
 pitch 0.1:  java ARDrone 192.168.1.1 AT*PCMD=303,1,1036831949,0,0,0
 pitch -0.1:  java ARDrone 192.168.1.1 AT*PCMD=304,1,-1110651699,0,0,0
 yaw 0.1:  java ARDrone 192.168.1.1 AT*PCMD=305,1,0,0,0,1036831949
 yaw -0.1:  java ARDrone 192.168.1.1 AT*PCMD=306,1,0,0,0,-1110651699
 roll 0.1:  java ARDrone 192.168.1.1 AT*PCMD=307,1,0,1036831949,0,0
 roll -0.1:  java ARDrone 192.168.1.1 AT*PCMD=308,1,0,-1110651699,0,0
 pitch -30 deg:  java ARDrone 192.168.1.1 AT*ANIM=401,0,1000
 pitch 30 deg:  java ARDrone 192.168.1.1 AT*ANIM=402,1,1000
 */
