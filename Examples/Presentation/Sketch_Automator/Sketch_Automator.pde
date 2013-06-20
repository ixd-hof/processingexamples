Process p;
import java.io.BufferedReader;
import java.io.InputStreamReader;

// Time between sketches
int duration = 15000;
// Direct path to Folder with sketches (no subfolders)
String path = "/Users/m/Projekte/FH/Processing/Course 2013/";

int last_millis = 0;
String current_sketch;
String [] sketches;
int folder_index = 0;

void setup()
{
  size(displayWidth, displayHeight);
  
  File folder = new File(path);
  File[] listOfFiles = folder.listFiles();

  sketches = new String[0];
  for (File file : listOfFiles) {
    if (file.isDirectory()) {
      sketches = append(sketches, file.getName());
    }
  }

  current_sketch = sketches[0];

  thread("openSketch");
}

void draw()
{
  background(0);
  
  if (millis()-last_millis > duration)
  {
    //p.destroy();
    //thread("openSketch");
    killSketch();
    last_millis = millis();

    if (folder_index < sketches.length-1)
      folder_index ++;
    else
      folder_index = 0;
    current_sketch = sketches[folder_index];

    delay(500);

    thread("openSketch");
  }
}

void openSketch()
{
  println(current_sketch);

  String[] cmd = {
    "/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java", 
    "-cp", 
    "lib/pde.jar:lib/antlr.jar:lib/jna.jar:lib/ant.jar:lib/ant-launcher.jar:core/library/core.jar:lib/org.eclipse.osgi_3.8.1.v20120830-144521.jar:lib/jdi.jar:lib/jdimodel.jar:lib/com.ibm.icu_4.4.2.v20110823.jar", 
    "processing.mode.java.Commander", 
    "--sketch=" + path + current_sketch, 
    "--output=~/Desktop/P5Temp", 
    "--present", 
    "--force"
  };

  try {
    p = Runtime.getRuntime().exec(cmd, null, new File("/Applications/Processing.app/Contents/Resources/Java"));

    BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));

    String line = null;

    while (input.ready () == false) {
    }

    while ( (line = input.readLine ()) != null) {
      System.out.println(line);
    }
    println(p.waitFor());
  } 
  catch (Exception e) { 
    println(e);
  }
}

void killSketch()
{
  try {
    p = Runtime.getRuntime().exec("pgrep -f " + current_sketch);

    BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));

    String line = null;

    while (input.ready () == false) {
    }

    while ( (line = input.readLine ()) != null) {
      System.out.println(line);
      Runtime.getRuntime().exec("kill " + line);
    }
    println(p.waitFor());
  } 
  catch (Exception e) { 
    println(e);
  }
}
