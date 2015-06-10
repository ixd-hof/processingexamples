import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture video;

OpenCV opencv;
Rectangle[] faces;

void setup()
{
  size(640, 480);

  // Webcam starten
  video = new Capture(this, 640, 480);
  video.start();

  // OpenCV starten
  opencv = new OpenCV(this, 640, 480);
  // Cascade zur Erkennung aktivieren
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw()
{
  // Videobild in OpenCV laden
  opencv.loadImage(video);
  // Anzeigen
  image(video, 0, 0);

  // Gesichter erkennen lassen und in Rectangle Array schreiben
  faces = opencv.detect();

  noFill();
  stroke(100, 255, 0);

  // Liste mit Gesichtern durchgehen und anzeigen
  if (faces.length != 0)
  {
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  } else
  {
  }
}

void captureEvent(Capture c)
{
  c.read();
}

