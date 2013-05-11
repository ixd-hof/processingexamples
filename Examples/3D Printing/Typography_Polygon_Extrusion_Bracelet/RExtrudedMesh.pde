class RExtrudedMesh
{
  float depth = 10;
  RPoint[][] points;
  RMesh m;
  boolean poly;
  float strength = 0.25;
  boolean front, back, sides;

  RExtrudedMesh(RShape grp, float d, boolean front, boolean back, boolean sides)
  {
    depth = d;
    m = grp.toMesh();
    points = grp.getPointsInPaths();

    this.front = front;
    this.back = back;
    this.sides = sides;
  }

  void set_polygon(boolean p)
  {
    poly = p;
  }

  void set_strength(float s)
  {
    this.strength = s;
  }

  void draw()
  {
    if (poly == false)
    {
      if (front)
      {
        // Draw front
        for (int i=0; i<m.countStrips(); i++) {
          beginShape(PConstants.TRIANGLE_STRIP);
          //for (int j=0;j<m.strips[i].vertices.length;j++) {
          for (int j=m.strips[i].vertices.length-1; j>=0; j--) {
            vertex(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, 0);
          }
          endShape(PConstants.CLOSE);
        }
      }

      if (back)
      {
        // Draw back
        for (int i=0; i<m.countStrips(); i++) {
          beginShape(PConstants.TRIANGLE_STRIP);
          for (int j=0;j<m.strips[i].vertices.length;j++) {
            vertex(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, -depth);
          }
          endShape(PConstants.CLOSE);
        }
      }

      if (sides && points.length > 0)
      {
        // Draw side (from outline points)
        for (int i=0; i<points.length; i++) {
          //beginShape(PConstants.TRIANGLE_STRIP);
          beginShape(QUADS);
          for (int j=0; j<points[i].length-1; j++)
          {
            vertex(points[i][j].x, points[i][j].y, 0);
            vertex(points[i][j].x, points[i][j].y, -depth);
            vertex(points[i][j+1].x, points[i][j+1].y, -depth);
            vertex(points[i][j+1].x, points[i][j+1].y, 0);
            //vertex(points[i][j+1].x, points[i][j+1].y, 0);
          }
          //vertex(points[i][0].x, points[i][0].y, 0);
          endShape(CLOSE);
        }
      }
    }

    else if (poly == true)
    {
      float w = strength;
      if (front)
      {
        // Front
        for (int i=0; i<m.countStrips(); i++) {
          for (int j=0;j<m.strips[i].vertices.length-2;j++) {
            PVector v0 = new PVector(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, 0);
            PVector v1 = new PVector(m.strips[i].vertices[j+1].x, m.strips[i].vertices[j+1].y, 0);
            PVector m0 = PVector.lerp(v0, v1, 0.5);
            float d0 = v0.dist(v1) + w/2.0;
            //float a0 = PVector.angleBetween(v0, v1);
            float a0 = atan2(v0.y - v1.y, v0.x - v1.x);

            pushMatrix();
            translate(m0.x, m0.y, m0.z);
            rotate(a0);
            tbox(d0, w, w);
            popMatrix();

            PVector v2 = new PVector(m.strips[i].vertices[j+1].x, m.strips[i].vertices[j+1].y, 0);
            PVector v3 = new PVector(m.strips[i].vertices[j+2].x, m.strips[i].vertices[j+2].y, 0);
            PVector m1 = PVector.lerp(v2, v3, 0.5);
            float d1 = v2.dist(v3) + w/2.0;
            //float a1 = PVector.angleBetween(v2, v3);
            float a1 = atan2(v2.y - v3.y, v2.x - v3.x);

            pushMatrix();
            translate(m1.x, m1.y, m1.z);
            rotate(a1);
            tbox(d1, w, w);
            popMatrix();

            PVector v4 = new PVector(m.strips[i].vertices[j+2].x, m.strips[i].vertices[j+2].y, 0);
            PVector v5 = new PVector(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, 0);
            PVector m2 = PVector.lerp(v4, v5, 0.5);
            float d2 = v4.dist(v5) + w/2.0;
            //float a2 = PVector.angleBetween(v4, v5);
            float a2 = atan2(v4.y - v5.y, v4.x - v5.x);

            pushMatrix();
            translate(m2.x, m2.y, m2.z);
            rotate(a2);
            tbox(d2, w, w);
            popMatrix();
          }
        }
      }
      else
      {
        for (int i=0; i<points.length; i++) {
          for (int j=0;j<points[i].length-2;j++) {
            PVector v0 = new PVector(points[i][j].x, points[i][j].y, 0);
            PVector v1 = new PVector(points[i][j+1].x, points[i][j+1].y, 0);
            PVector m0 = PVector.lerp(v0, v1, 0.5);
            float d0 = v0.dist(v1) + w/2.0;
            //float a2 = PVector.angleBetween(v4, v5);
            float a0 = atan2(v0.y - v1.y, v0.x - v1.x);

            pushMatrix();
            translate(m0.x, m0.y, m0.z);
            rotateZ(a0);
            tbox(d0, w, w);
            popMatrix();
          }
        }
      }

      if (back)
      {
        // Back
        for (int i=0; i<m.countStrips(); i++) {
          for (int j=0;j<m.strips[i].vertices.length-2;j++) {
            PVector v0 = new PVector(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, -depth);
            PVector v1 = new PVector(m.strips[i].vertices[j+1].x, m.strips[i].vertices[j+1].y, -depth);
            PVector m0 = PVector.lerp(v0, v1, 0.5);
            float d0 = v0.dist(v1) + w/2.0;
            //float a0 = PVector.angleBetween(v0, v1);
            float a0 = atan2(v0.y - v1.y, v0.x - v1.x);

            pushMatrix();
            translate(m0.x, m0.y, m0.z);
            rotate(a0);
            tbox(d0, w, w);
            popMatrix();

            PVector v2 = new PVector(m.strips[i].vertices[j+1].x, m.strips[i].vertices[j+1].y, -depth);
            PVector v3 = new PVector(m.strips[i].vertices[j+2].x, m.strips[i].vertices[j+2].y, -depth);
            PVector m1 = PVector.lerp(v2, v3, 0.5);
            float d1 = v2.dist(v3) + w/2.0;
            //float a1 = PVector.angleBetween(v2, v3);
            float a1 = atan2(v2.y - v3.y, v2.x - v3.x);

            pushMatrix();
            translate(m1.x, m1.y, m1.z);
            rotate(a1);
            tbox(d1, w, w);
            popMatrix();

            PVector v4 = new PVector(m.strips[i].vertices[j+2].x, m.strips[i].vertices[j+2].y, -depth);
            PVector v5 = new PVector(m.strips[i].vertices[j].x, m.strips[i].vertices[j].y, -depth);
            PVector m2 = PVector.lerp(v4, v5, 0.5);
            float d2 = v4.dist(v5) + w/2.0;
            //float a2 = PVector.angleBetween(v4, v5);
            float a2 = atan2(v4.y - v5.y, v4.x - v5.x);

            pushMatrix();
            translate(m2.x, m2.y, m2.z);
            rotate(a2);
            tbox(d2, w, w);
            popMatrix();
          }
        }
      }
      else
      {
        for (int i=0; i<points.length; i++) {
          for (int j=0;j<points[i].length-2;j++) {
            PVector v0 = new PVector(points[i][j].x, points[i][j].y, -depth);
            PVector v1 = new PVector(points[i][j+1].x, points[i][j+1].y, -depth);
            PVector m0 = PVector.lerp(v0, v1, 0.5);
            float d0 = v0.dist(v1) + w/2.0;
            //float a2 = PVector.angleBetween(v4, v5);
            float a0 = atan2(v0.y - v1.y, v0.x - v1.x);

            pushMatrix();
            translate(m0.x, m0.y, m0.z);
            rotateZ(a0);
            tbox(d0, w, w);
            popMatrix();
          }
        }
      }

      if (sides)
      {
        // Sides
        for (int i=0; i<points.length; i++) {
          for (int j=0;j<points[i].length-1;j++) {
            PVector v0 = new PVector(points[i][j].x, points[i][j].y, 0);
            PVector v1 = new PVector(points[i][j].x, points[i][j].y, -depth);
            PVector m0 = PVector.lerp(v0, v1, 0.5);
            float d0 = v0.dist(v1) + w/2.0;
            //float a0 = PVector.angleBetween(v0, v1);
            float a0x = atan2(v0.y - v1.y, v0.z - v1.z);
            float a0y = atan2(v0.x - v1.x, v0.z - v1.z);
            float a0z = atan2(v0.y - v1.y, v0.x - v1.x);

            pushMatrix();
            translate(m0.x, m0.y, m0.z);
            //rotateY(PI/2.0);
            //rotateX(a0x);
            //rotateY(a0y);
            //rotateZ(a0z);
            tbox(w, w, d0);
            popMatrix();

            /*
          PVector v2 = new PVector(points[i][j].x, points[i][j].y, -depth);
             PVector v3 = new PVector(points[i][j+1].x, points[i][j+1].y, -depth);
             PVector m1 = PVector.lerp(v2, v3, 0.5);
             float d1 = v2.dist(v3);
             //float a1 = PVector.angleBetween(v2, v3);
             float a1 = atan2(v2.y - v3.y, v2.x - v3.x);
             
             pushMatrix();
             translate(m1.x, m1.y, m1.z);
             //rotateY(-PI/2.0);
             rotateZ(a1);
             tbox(w, w, d1);
             popMatrix();
             */

            PVector v4 = new PVector(points[i][j+1].x, points[i][j+1].y, -depth);
            PVector v5 = new PVector(points[i][j].x, points[i][j].y, 0);
            PVector m2 = PVector.lerp(v4, v5, 0.5);
            float d2 = v4.dist(v5) + w/2.0;
            //float a2 = PVector.angleBetween(v4, v5);
            float a2x = atan2(v4.y - v5.y, v4.z - v5.z);
            float a2y = atan2(v4.x - v5.x, v4.z - v5.z);
            float a2z = atan2(v4.y - v5.y, v4.x - v5.x);

            pushMatrix();
            translate(m2.x, m2.y, m2.z);
            //rotateY(PI/2.0);
            rotateX(a2x);
            rotateY(a2y);
            rotateZ(a2z);
            tbox(w, w, d2);
            popMatrix();
          }
        }
      }
    }
  }

  void tbox(float w, float h, float d) {
    beginShape(QUADS);
    scale(w/2, h/2, d/2);

    // +Z "front" face
    vertex(-1, -1, 1);
    vertex( 1, -1, 1);
    vertex( 1, 1, 1);
    vertex(-1, 1, 1);

    // -Z "back" face
    vertex( 1, -1, -1);
    vertex(-1, -1, -1);
    vertex(-1, 1, -1);
    vertex( 1, 1, -1);

    // +Y "bottom" face
    vertex(-1, 1, 1);
    vertex( 1, 1, 1);
    vertex( 1, 1, -1);
    vertex(-1, 1, -1);

    // -Y "top" face
    vertex(-1, -1, -1);
    vertex( 1, -1, -1);
    vertex( 1, -1, 1);
    vertex(-1, -1, 1);

    // +X "right" face
    vertex( 1, -1, 1);
    vertex( 1, -1, -1);
    vertex( 1, 1, -1);
    vertex( 1, 1, 1);

    // -X "left" face
    vertex(-1, -1, -1);
    vertex(-1, -1, 1);
    vertex(-1, 1, 1);
    vertex(-1, 1, -1);

    endShape();
  }
}

