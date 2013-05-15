import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import wblut.hemesh.HET_Export;
import geomerative.*;

float radius = 1.0;
int steps = 200;
float dpi = 96.0;

String file = null;

WB_Render render;
WB_BSpline C;
WB_Point3d[] points;
HE_Mesh mesh;

void setup() {
  size(800, 800, P3D);

  RG.init(this);
  RG.ignoreStyles(true);
  RG.setPolygonizer(RG.ADAPTATIVE);

  selectInput("Select a file to process:", "fileSelected");
}

void draw() {
  background(255);

  fill(0);
  text("e: Export OBJ next to SVG", 20, 20);
  text("p: Open OBJ in MakerWare", 20, 40);
  text("+ / -: Radius ("+radius+")", 20, 60);

  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(400, 400, 500);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  stroke(0);

  if (render != null)
  {
    render.drawEdges(mesh);
    noStroke();
    render.drawFaces(mesh);
  }
}

void fileSelected(File selection)
{
  if (selection == null)
  {
    println("No file selected");
  }
  else
  {
    file = selection.getAbsolutePath();
    createTube();
  }
}

void createTube()
{

  RShape grp = RG.loadShape(file);
  grp.centerIn(g);

  RPoint[][] pointPaths = grp.getPointsInPaths();
  println(pointPaths[0].length);

  // Several WB_Curve classes are in development. HEC_SweepTube provides
  // a way of generating meshes from them.

  //Generate a BSpline
  points=new WB_Point3d[pointPaths[0].length];
  for (int i=0; i<pointPaths[0].length; i++)
  {
    // Conversion between SVG px to mm
    // Trial and error sonstant
    float x_mm = pointPaths[0][i].x / 8.0136;
    float y_mm = pointPaths[0][i].y / 8.0136;
    points[i] = new WB_Point3d(x_mm, y_mm, 0);
  }
  C = new WB_BSpline(points, 4);

  HEC_SweepTube creator = new HEC_SweepTube();
  creator.setCurve(C);//curve should be a WB_BSpline
  creator.setRadius(radius);
  creator.setSteps(steps);
  creator.setFacets(6);
  creator.setCap(true, true); // Cap start, cap end?

  mesh=new HE_Mesh(creator); 
  HET_Diagnosis.validate(mesh);
  render=new WB_Render(this);
}

void keyPressed()
{
  if (key == 'e') {
    HET_Export.saveToOBJ(mesh, file+".obj");
  }
  else if (key == 'p') {
    HET_Export.saveToOBJ(mesh, file+".obj");
    String[] params = { 
      "open", "/Applications/MakerWare.app", file+".obj"
    };
    exec(params);
  }
  else if (key == '+')
  {
    radius += 1;
    createTube();
  }
  else if (key == '-')
  {
    radius -= 1;
    createTube();
  }
}

