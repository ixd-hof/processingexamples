PImage slice;
String file_name = "IM-0001-";
int max_file = 388;
int z_index = 0;
int color_filter = 255;
ArrayList slices = new ArrayList();

void setup()
{
  size(512, 512);

  // IM-0001-0000.jpg
  slice = loadImage("IM-0001-0000.jpg");

  for (int i=0; i<max_file; i++)
  {
    String index = "000" + i;
    if (i >= 10 && i < 100)
      index = "00" + i;
    else if (i >= 100 && i < 1000)
      index = "0" + i;

    PImage img = loadImage("IM-0001-" + index + ".jpg");
    slices.add(img);
  }
}


void draw()
{
  tint(color_filter);
  image((PImage)slices.get(z_index), 0, 0);
  noTint();
  
  text("z: " + z_index, 20, 20);
  text("color filter: " + color_filter, 20, 40);
}


void keyPressed() {
  if (keyCode == UP && z_index <max_file-1)
  {
    z_index ++;
  }
  else if (keyCode == DOWN && z_index > 0)
  {
    z_index --;
  }
  else if (keyCode == RIGHT && color_filter < 255)
  {
    color_filter ++;
  }
  else if (keyCode == LEFT && color_filter > 0)
  {
    color_filter --;
  }
}

