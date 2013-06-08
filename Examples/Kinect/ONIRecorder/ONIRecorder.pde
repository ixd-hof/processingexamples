import SimpleOpenNI.*;

SimpleOpenNI  context;
boolean record = false;

void setup()
{
  size(640, 480, P3D);

  context = new SimpleOpenNI(this);

  context.enableScene();
  context.enableDepth();
  context.enableRGB();

  String filename = "recording_" + year() + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" + nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2) + ".oni";
  context.enableRecorder(SimpleOpenNI.RECORD_MEDIUM_FILE, filename);
  context.addNodeToRecording(SimpleOpenNI.NODE_DEPTH, SimpleOpenNI.CODEC_16Z_EMB_TABLES);
  context.addNodeToRecording(SimpleOpenNI.NODE_IMAGE, SimpleOpenNI.CODEC_JPEG);
}

void draw()
{
  context.update(); 

  if (record == false)
  {
    background(0);
  }
  else
  {
    background(255, 0, 0);
    tint(255, 0, 0);
  }
  
  image(context.depthImage(), 0, 0);
}

void mousePressed()
{
  if (record == true)
    exit();
  else
    record = true;
}

