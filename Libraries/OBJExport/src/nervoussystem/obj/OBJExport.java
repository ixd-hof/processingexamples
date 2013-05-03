/*
 * OBJExport - Exports obj files from processing with beginRecord and endRecord
 * by Jesse Louis-Rosenberg 
 * http://n-e-r-v-o-u-s.com
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * <p/>
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU Lesser General
 * Public License along with the Processing project; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place,
 * Suite 330, Boston, MA  02111-1307  USA
 */

package nervoussystem.obj;

import java.io.*;
import java.util.HashMap;
import processing.core.*;
//import processing.core.PConstants;
//import processing.opengl.*;

public class OBJExport extends PGraphics implements PConstants {
  File file;
  PrintWriter writer;
  PVector[] pts;
  int[][] lines;
  int[][] faces;
  int lineCount;
  int faceCount;
  int objectMode = 0;
  HashMap<String,String> ptMap;
  
  int DEFAULT_VERTICES = 4096;
  int VERTEX_FIELD_COUNT = 36;
  float vertices[][];
  int vertexCount = 0;
  PApplet parent;
  
  public OBJExport() {
    vertices = new float[DEFAULT_VERTICES][VERTEX_FIELD_COUNT];
  }

  public void setPath(String path) {
    this.path = path;
    if (path != null) {
      file = new File(path);
      if (!file.isAbsolute()) file = null;
    }
    if (file == null) {
      throw new RuntimeException("OBJExport requires an absolute path " +
        "for the location of the output file.");
    }
  }

  protected void allocate() {
  }

  public void dispose() {
    writer.flush();
    writer.close();
    writer = null;
  }

  public boolean displayable() {
    return false;  // just in case someone wants to use this on its own
  }

  public void beginDraw() {
    // have to create file object here, because the name isn't yet
    // available in allocate()
    if (writer == null) {
      try {
        writer = new PrintWriter(new FileWriter(file));
      } 
      catch (IOException e) {
        throw new RuntimeException(e);
      }
      pts = new PVector[4096];
      lines = new int[4096][];
      faces = new int[4096][];
      lineCount = 0;
      faceCount = 0;
      ptMap = new HashMap<String,String>();
    }
  }

  public void endDraw() {
    //write vertices and initialize ptMap
    writeVertices();
    writeLines();
    writeFaces();
  }
  
  private void writeVertices() {
    for(int i=0;i<ptMap.size();++i) {
      PVector v = pts[i];
      writer.println("v " + v.x + " " + v.y + " " + v.z);
    }
  }
  
  private void writeLines() {
    for(int i=0;i<lineCount;++i) {
      int[] l = lines[i];
      String output = "l";
      for(int j=0;j<l.length;++j) {
        output += " " + l[j];
      }
      writer.println(output);
    }
  }

  private void writeFaces() {
    for(int i=0;i<faceCount;++i) {
      int[] f = faces[i];
      String output = "f";
      for(int j=0;j<f.length;++j) {
        output += " " + f[j];
      }
      writer.println(output);
    }
  }

  public void beginShape(int kind) {
    shape = kind;
    vertexCount = 0;
  }

  public void vertex(float x, float y) {
    vertex(x,y,0);
  }

  public void vertex(float x, float y,float z) {
    float vertex[] = vertices[vertexCount];
    if(!ptMap.containsKey(x+"_"+y+"_"+z)) {
      if(ptMap.size() >= pts.length) {
      PVector newPts[] = new PVector[pts.length*2];
      System.arraycopy(pts,0,newPts,0,pts.length);
      pts = newPts;
      }
      pts[ptMap.size()] = new PVector(x,y,z);
      ptMap.put(x+"_"+y+"_"+z,""+(ptMap.size()+1));
    }
    vertex[X] = x;  // note: not mx, my, mz like PGraphics3
    vertex[Y] = y;
    vertex[Z] = z;

    if (fill) {
      vertex[R] = fillR;
      vertex[G] = fillG;
      vertex[B] = fillB;
      vertex[A] = fillA;
    }

    if (stroke) {
      vertex[SR] = strokeR;
      vertex[SG] = strokeG;
      vertex[SB] = strokeB;
      vertex[SA] = strokeA;
      vertex[SW] = strokeWeight;
    }

    if (textureImage != null) {  // for the future?
      vertex[U] = textureU;
      vertex[V] = textureV;
    }
    vertexCount++;   
  }

  public void endShape(int mode) {
    //if(stroke) endShapeStroke(mode);
    //if(fill) endShapeFill(mode);
    endShapeFill(mode);
 }

  
  public void endShapeFill(int mode) {
      switch(shape) {
      case TRIANGLES:
        {
        int stop = vertexCount-2;
          for (int i = 0; i < stop; i += 3) {
            int[] f = new int[3];
            f[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
            f[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
            f[2] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
            addFace(f);
          }
        }
        break;
      case TRIANGLE_STRIP:
      {
          int stop = vertexCount - 2;
          for (int i = 0; i < stop; i++) {
            // have to switch between clockwise/counter-clockwise
            // otherwise the feller is backwards and renderer won't draw
            if ((i % 2) == 0) {
              int[] f = new int[3];
              f[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
              f[1] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
              f[2] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
              addFace(f);
            } else {
              int[] f = new int[3];
              f[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
              f[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
              f[2] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
              addFace(f);
            }
          }
      }
      break;
      case POLYGON:
      {
        int[] f;
        boolean closed = vertices[0][X]!=vertices[vertexCount-1][X] || vertices[0][Y]!=vertices[vertexCount-1][Y] || vertices[0][Z]!=vertices[vertexCount-1][Z];
        if(closed) {
         f = new int[vertexCount];
        } else {
         f = new int[vertexCount-1];
        }
        int end = vertexCount;
        if(!closed) end--;
        for(int i=0;i<end;++i) {
          f[i] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
        }
        addFace(f);
      }
      break;
      case QUADS:
      {
        int stop = vertexCount-3;
        for (int i = 0; i < stop; i += 4) {
            int[] f = new int[4];
            f[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
            f[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
            f[2] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
            f[3] = PApplet.parseInt(ptMap.get(vertices[i+3][X]+"_"+vertices[i+3][Y]+"_"+vertices[i+3][Z]));
            addFace(f);
        }
      }
      break;

      case QUAD_STRIP:
      {
        int stop = vertexCount-3;
        for (int i = 0; i < stop; i += 2) {
            int[] f = new int[4];
            f[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
            f[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
            f[3] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
            f[2] = PApplet.parseInt(ptMap.get(vertices[i+3][X]+"_"+vertices[i+3][Y]+"_"+vertices[i+3][Z]));
            addFace(f);        }
      }
      break;
      case TRIANGLE_FAN:
      {
        int stop = vertexCount - 1;
        for (int i = 1; i < stop; i++) {
          int f[] = new int[3];
            f[0] = PApplet.parseInt(ptMap.get(vertices[0][X]+"_"+vertices[0][Y]+"_"+vertices[0][Z]));
            f[1] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
            f[2] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
            addFace(f);
        }
      }
      break;
    }    
  }
  
  //unused as of now
  public void endShapeStroke(int mode) {
      switch(shape) {
      case LINES:
        {
        int stop = vertexCount-1;
        for (int i = 0; i < stop; i += 2) {
              int[] l = new int[2];
              l[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
              l[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
              addLine(l);;
          }
        }
        break;
      case TRIANGLES:
        {
        int stop = vertexCount-2;
          for (int i = 0; i < stop; i += 3) {
            int[] l = new int[4];
            l[0] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
            l[1] = PApplet.parseInt(ptMap.get(vertices[i+1][X]+"_"+vertices[i+1][Y]+"_"+vertices[i+1][Z]));
            l[2] = PApplet.parseInt(ptMap.get(vertices[i+2][X]+"_"+vertices[i+2][Y]+"_"+vertices[i+2][Z]));
            l[3] = l[0];
            addLine(l);;
          }
        }
      
      break;
      case POLYGON:
      {
        int[] l;
        boolean closed = mode == CLOSE && (vertices[0][X]!=vertices[vertexCount-1][X] || vertices[0][Y]!=vertices[vertexCount-1][Y] || vertices[0][Z]!=vertices[vertexCount-1][Z]);
        if(closed) {
         l = new int[vertexCount+1];
        } else {
         l = new int[vertexCount];
        }
        for(int i=0;i<vertexCount;++i) {
          l[i] = PApplet.parseInt(ptMap.get(vertices[i][X]+"_"+vertices[i][Y]+"_"+vertices[i][Z]));
        }
        if(closed) l[vertexCount] = l[0];
        addLine(l);;
      }
      break;
    }
  }
  
  private void addFace(int[] f) {
   if(faceCount >= faces.length) {
    int newfaces[][] = new int[faces.length*2][];
    System.arraycopy(faces,0,newfaces,0,faces.length);
    faces = newfaces;
   }
   faces[faceCount++] = f;
  }
  
  private void addLine(int[] l) {
   if(lineCount >= lines.length) {
    int newLines[][] = new int[lines.length*2][];
    System.arraycopy(lines,0,newLines,0,lines.length);
    lines = newLines;
   }
   lines[lineCount++] = l;
  }
}