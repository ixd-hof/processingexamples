// https://gitorious.org/interact_workshop/interact_workshop

import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.speech.RecognizerIntent;

import ketai.sensors.*;

int VOICE_RECOGNITION_REQUEST_CODE = 1234;

KetaiSensor sensor;

void setup()
{ 
  java.util.List activities = getPackageManager().queryIntentActivities(
  new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH), 0);
  
  // Accelerometer
  sensor = new KetaiSensor(this);
  sensor.start();
}

void draw() {
}
 
void mousePressed() {
  startVoiceRecognitionActivity();
}

void onAccelerometerEvent(float x, float y, float z)
{
  float all = pow(x, 2) + pow(y, 2) + pow(z, 2);
  float xyz = sqrt(all);
  //println(xyz);
  if (xyz > 12)
    startVoiceRecognitionActivity();
}
 
void startVoiceRecognitionActivity() {
  Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
  intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
  //intent.putExtra(RecognizerIntent.EXTRA_PROMPT, "Speech recognition demo");
  startActivityForResult(intent, VOICE_RECOGNITION_REQUEST_CODE);
}
 
void onActivityResult(int requestCode, int resultCode, Intent data) {
  if (requestCode == VOICE_RECOGNITION_REQUEST_CODE && resultCode == RESULT_OK) {
    background(0);

    String str = new String();
    ArrayList matches = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
    
    fill(255);
    for (int i=0; i<matches.size(); i++)
    {
      str += matches.get(i);
    }
    
    text(str, 20, 20);
    
    if (str.indexOf("suchwort") != -1)
    {
       // 
    }
  }
 
  super.onActivityResult(requestCode, resultCode, data);
}
