import pi.*;
import pi.Minecraft.*;
import pi.Vec;

Minecraft mc;

void setup()
{
  size(500, 500);
  background(100);
  frameRate(10);
  
  // Connect to Minecraft server (localhost)
  mc = Minecraft.connect();
  // Connect to Minecraft server ip
  // mc = Minecraft.connect("192.168.0.23");
}

void draw()
{
}

void paint()
{
  // Get current position
  Vec position = mc.player.getPosition();
  // Generate blocks from mouse position
  int size = 20;
  int x = int(map(mouseX, 0, width, 0, size));
  int z = int(map(mouseY, 0, height, 0, size));
  mc.setBlock(x, y, position.z+size/2, Block.TNT);

  // Paint on screen
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void mousePressed()
{
  paint();
}

void mouseMoved()
{
  paint();
}

void keyPressed()
{
  background(100);
}