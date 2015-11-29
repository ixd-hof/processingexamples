import SimpleOpenNI.*;
import java.util.Date;
import java.text.SimpleDateFormat;

SimpleOpenNI  kinect;

void setup()
{
  size(1280, 480);

  // initialize for recording
  kinect = new SimpleOpenNI(this);
  String date = new SimpleDateFormat("yy-MM-dd_kk-mm").format(new Date());
  kinect.enableRecorder("recording_"+date+".oni");

  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();

  // select the recording channels
  kinect.addNodeToRecording(SimpleOpenNI.NODE_DEPTH, true);
  kinect.addNodeToRecording(SimpleOpenNI.NODE_IMAGE, true);
  kinect.addNodeToRecording(SimpleOpenNI.NODE_USER, true);
  kinect.addNodeToRecording(SimpleOpenNI.NODE_SCENE, true);
}

void draw()
{
  kinect.update();

  image(kinect.depthImage(), 0, 0);
  image(kinect.rgbImage(), 640, 0);
  
  noStroke();
  fill(255, 0, 0, 100);
  rect(0, 0, width, height);
}
