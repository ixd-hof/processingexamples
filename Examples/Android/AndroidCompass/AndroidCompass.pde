// Extended Ketai Sensor Library for Android Example
// Azimuth, Pitch and Roll!

import ketai.sensors.*;

KetaiSensor sensor;

PVector magneticField, accelerometer;
float azimuth, pitch, roll;

float[] matrixR = new float[9];
float[] matrixI = new float[9];
float[] matrixValues = new float[9];

void setup()
{
  size(displayWidth, displayHeight, P3D);
  
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  magneticField = new PVector();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(28);
}

void draw()
{
  background(0);
  
  fill(100);
  pushMatrix();
  translate(width/2, height/2, -300);
  rotateX(pitch);
  rotateY(azimuth);
  rotateZ(roll);
  box(200, 200, 200);
  popMatrix();

  fill(255);
  text("Accelerometer :" + "\n" 
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n" 
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n" 
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
    + "MagneticField :" + "\n" 
    + "x: " + nfp(magneticField.x, 1, 2) + "\n"
    + "y: " + nfp(magneticField.y, 1, 2) + "\n" 
    + "z: " + nfp(magneticField.z, 1, 2) + "\n"
    + "Orientation :" + "\n" 
    + "azimuth: " + azimuth + "\n"
    + "pitch: " + pitch + "\n" 
    + "roll: " + roll + "\n"
    , 20, 0, width, height);
}

void calculateOrientation()
{
  try {
    boolean success = android.hardware.SensorManager.getRotationMatrix(
    matrixR, 
    matrixI, 
    accelerometer.array(), 
    magneticField.array());

    if (success) {
      android.hardware.SensorManager.getOrientation(matrixR, matrixValues);

      azimuth = matrixValues[0];
      pitch = matrixValues[1];
      roll = matrixValues[2];
    }
  }
  catch (Exception e) { 
    println("Error: " + e);
  }
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  /*
  float kFilteringFactor = 0.3;
   accelerometer.x = x * kFilteringFactor + accelerometer.x * (1.0 - kFilteringFactor);
   accelerometer.y = y * kFilteringFactor + accelerometer.y * (1.0 - kFilteringFactor);
   accelerometer.z = z * kFilteringFactor + accelerometer.z * (1.0 - kFilteringFactor);
   */

  accelerometer.set(x, y, z);
  
  calculateOrientation();
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticField.set(x, y, z);
  /*valuesMagneticField[0] = x;
   valuesMagneticField[1] = y;
   valuesMagneticField[2] = z;*/
}
