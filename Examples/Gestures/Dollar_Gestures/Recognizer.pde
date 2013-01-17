// 1$ Gesture Recognizer
// Based on http://depts.washington.edu/aimgroup/proj/dollar/
// Ported to Processing by Norman Papernick http://www.openprocessing.org/sketch/600

// Recognizer class constants
//
int NumTemplates = 16;
int NumPVectors = 64;
float SquareSize = 250.0;
float HalfDiagonal = 0.5 * sqrt(250.0 * 250.0 + 250.0 * 250.0);
float AngleRange = 45.0;
float AnglePrecision = 2.0;
float Phi = 0.5 * (-1.0 + sqrt(5.0)); // Golden Ratio

// simple class for recording points
class Recorder
{
  PVector [] points;
  boolean recording;
  boolean hasPVectors;
  
  Recorder()
  {
     points = new PVector[0];
     recording = false;
  }
  
  /*
  void update()
  {
    if( recording)
    {
      if( mousePressed )
      {
        points = (PVector[])append(points, new PVector( mouseX, mouseY));
      }
      else
      {
        recording = false;
        if( points.length > 5)
        {
          hasPVectors = true;
        }
      }
    }
    else
    {
      if( mousePressed)
      {
        points = new PVector[0];
        recording = true;
        hasPVectors = false;
      }
    }
    */
  }
  
  /*
  void draw( )
  {
     color c = color(0,0,0);
     if( recording )
     {
       c = color(255, 255, 0);
     }
     if( points.length > 1)
     {
       for( int i = 1; i < points.length; i++)
       {
         stroke( c );
         line( points[i-1].x, points[i-1].y, 
               points[i  ].x, points[i  ].y);
       }
     }
  }
  
}
*/
float Infinity = 1e9;


// What follows here is a translation of the javascript to java.
// There is probably a better way to do it, but this works. 

// Base point class. 

/*
class PVector
{
  float X;
  float Y;
  PVector( float x, float y)
  {
    X = x;
    Y = y;
  }
  
  float distance( PVector other)
  {
    return dist( X, Y, other.x, other.y);
  }
}
*/

class Rectangle
{
  float X;
  float Y;
  float Width;
  float Height;
  Rectangle( float x, float y, float width, float height)
  {
    X = x;
    Y = y;
    Width = width;
    Height = height;
  }
}

// A template holds a name and a set of reduced points that represent
// a single gesture.  
class Template
{
  String Name;
  PVector [] PVectors;
  Template( String name, PVector [] points)
  {
    Name = name;
    PVectors = Resample( points, NumPVectors);   
    PVectors = RotateToZero( PVectors );    
    PVectors = ScaleToSquare( PVectors, SquareSize);    
    PVectors = TranslateToOrigin( PVectors );
  }
}

class Result
{
  String Name;
  float Score;
  float Ratio;
  Result( String name, float score, float ratio)
  {
    Name = name;
    Score = score;
    Ratio = ratio;
  }
}


class Recognizer
{
   Template [] Templates = {};
   Recognizer( )
   {
     
     // These predefines come from the sample code, and can be replaced or revised.
     // it is left as an exercise for the reader to implement a file format for reading
     // and saving templates. 
     
     // triangle
      PVector [] point0 = {new PVector(137,139),new PVector(135,141),new PVector(133,144),new PVector(132,146),
                         new PVector(130,149),new PVector(128,151),new PVector(126,155),new PVector(123,160),
                         new PVector(120,166),new PVector(116,171),new PVector(112,177),new PVector(107,183),
                         new PVector(102,188),new PVector(100,191),new PVector(95,195),new PVector(90,199),
                         new PVector(86,203),new PVector(82,206),new PVector(80,209),new PVector(75,213),
                         new PVector(73,213),new PVector(70,216),new PVector(67,219),new PVector(64,221),
                         new PVector(61,223),new PVector(60,225),new PVector(62,226),new PVector(65,225),
                         new PVector(67,226),new PVector(74,226),new PVector(77,227),new PVector(85,229),
                         new PVector(91,230),new PVector(99,231),new PVector(108,232),new PVector(116,233),
                         new PVector(125,233),new PVector(134,234),new PVector(145,233),new PVector(153,232),
                         new PVector(160,233),new PVector(170,234),new PVector(177,235),new PVector(179,236),
                         new PVector(186,237),new PVector(193,238),new PVector(198,239),new PVector(200,237),
                         new PVector(202,239),new PVector(204,238),new PVector(206,234),new PVector(205,230),
                         new PVector(202,222),new PVector(197,216),new PVector(192,207),new PVector(186,198),
                         new PVector(179,189),new PVector(174,183),new PVector(170,178),new PVector(164,171),
                         new PVector(161,168),new PVector(154,160),new PVector(148,155),new PVector(143,150),
                         new PVector(138,148),new PVector(136,148) };
     AddTemplate("triangle", point0);
     
      // x
     PVector [] point1 = { new PVector(87,142),new PVector(89,145),new PVector(91,148),new PVector(93,151),
                          new PVector(96,155),new PVector(98,157),new PVector(100,160),new PVector(102,162),
                         new PVector(106,167),new PVector(108,169),new PVector(110,171),new PVector(115,177),
                         new PVector(119,183),new PVector(123,189),new PVector(127,193),new PVector(129,196),
                         new PVector(133,200),new PVector(137,206),new PVector(140,209),new PVector(143,212),
                         new PVector(146,215),new PVector(151,220),new PVector(153,222),new PVector(155,223),
                         new PVector(157,225),new PVector(158,223),new PVector(157,218),new PVector(155,211),
                         new PVector(154,208),new PVector(152,200),new PVector(150,189),new PVector(148,179),
                         new PVector(147,170),new PVector(147,158),new PVector(147,148),new PVector(147,141),
                         new PVector(147,136),new PVector(144,135),new PVector(142,137),new PVector(140,139),
                         new PVector(135,145),new PVector(131,152),new PVector(124,163),new PVector(116,177),
                         new PVector(108,191),new PVector(100,206),new PVector(94,217),new PVector(91,222),
                         new PVector(89,225),new PVector(87,226),new PVector(87,224) } ;
      AddTemplate("x", point1);
      
      // rectangle
      PVector [] point2 = {new PVector(78,149),new PVector(78,153),new PVector(78,157),new PVector(78,160),
                         new PVector(79,162),new PVector(79,164),new PVector(79,167),new PVector(79,169),
                         new PVector(79,173),new PVector(79,178),new PVector(79,183),new PVector(80,189),
                         new PVector(80,193),new PVector(80,198),new PVector(80,202),new PVector(81,208),
                         new PVector(81,210),new PVector(81,216),new PVector(82,222),new PVector(82,224),
                         new PVector(82,227),new PVector(83,229),new PVector(83,231),new PVector(85,230),
                         new PVector(88,232),new PVector(90,233),new PVector(92,232),new PVector(94,233),
                         new PVector(99,232),new PVector(102,233),new PVector(106,233),new PVector(109,234),
                         new PVector(117,235),new PVector(123,236),new PVector(126,236),new PVector(135,237),
                         new PVector(142,238),new PVector(145,238),new PVector(152,238),new PVector(154,239),
                         new PVector(165,238),new PVector(174,237),new PVector(179,236),new PVector(186,235),
                         new PVector(191,235),new PVector(195,233),new PVector(197,233),new PVector(200,233),
                         new PVector(201,235),new PVector(201,233),new PVector(199,231),new PVector(198,226),
                         new PVector(198,220),new PVector(196,207),new PVector(195,195),new PVector(195,181),
                         new PVector(195,173),new PVector(195,163),new PVector(194,155),new PVector(192,145),
                         new PVector(192,143),new PVector(192,138),new PVector(191,135),new PVector(191,133),
                         new PVector(191,130),new PVector(190,128),new PVector(188,129),new PVector(186,129),
                         new PVector(181,132),new PVector(173,131),new PVector(162,131),new PVector(151,132),
                         new PVector(149,132),new PVector(138,132),new PVector(136,132),new PVector(122,131),
                         new PVector(120,131),new PVector(109,130),new PVector(107,130),new PVector(90,132),
                         new PVector(81,133),new PVector(76,133)};
       AddTemplate("rectangle", point2);
       
       // circle
       PVector [] point3 = {new PVector(127,141),new PVector(124,140),new PVector(120,139),new PVector(118,139),
                          new PVector(116,139),new PVector(111,140),new PVector(109,141),new PVector(104,144),
                          new PVector(100,147),new PVector(96,152),new PVector(93,157),new PVector(90,163),
                          new PVector(87,169),new PVector(85,175),new PVector(83,181),new PVector(82,190),
                          new PVector(82,195),new PVector(83,200),new PVector(84,205),new PVector(88,213),
                          new PVector(91,216),new PVector(96,219),new PVector(103,222),new PVector(108,224),
                          new PVector(111,224),new PVector(120,224),new PVector(133,223),new PVector(142,222),
                          new PVector(152,218),new PVector(160,214),new PVector(167,210),new PVector(173,204),
                          new PVector(178,198),new PVector(179,196),new PVector(182,188),new PVector(182,177),
                          new PVector(178,167),new PVector(170,150),new PVector(163,138),new PVector(152,130),
                          new PVector(143,129),new PVector(140,131),new PVector(129,136),new PVector(126,139)};

       AddTemplate("circle", point3);

       // check
      PVector [] point4 = {new PVector(91,185),new PVector(93,185),new PVector(95,185),new PVector(97,185),new PVector(100,188),
                         new PVector(102,189),new PVector(104,190),new PVector(106,193),new PVector(108,195),new PVector(110,198),
                         new PVector(112,201),new PVector(114,204),new PVector(115,207),new PVector(117,210),new PVector(118,212),
                         new PVector(120,214),new PVector(121,217),new PVector(122,219),new PVector(123,222),new PVector(124,224),
                         new PVector(126,226),new PVector(127,229),new PVector(129,231),new PVector(130,233),new PVector(129,231),
                         new PVector(129,228),new PVector(129,226),new PVector(129,224),new PVector(129,221),new PVector(129,218),
                         new PVector(129,212),new PVector(129,208),new PVector(130,198),new PVector(132,189),new PVector(134,182),
                         new PVector(137,173),new PVector(143,164),new PVector(147,157),new PVector(151,151),new PVector(155,144),
                         new PVector(161,137),new PVector(165,131),new PVector(171,122),new PVector(174,118),new PVector(176,114),
                         new PVector(177,112),new PVector(177,114),new PVector(175,116),new PVector(173,118) };
       AddTemplate("check", point4);
       
       // caret
       PVector [] point5 = {new PVector(79,245),new PVector(79,242),new PVector(79,239),new PVector(80,237),new PVector(80,234),
                          new PVector(81,232),new PVector(82,230),new PVector(84,224),new PVector(86,220),new PVector(86,218),
                          new PVector(87,216),new PVector(88,213),new PVector(90,207),new PVector(91,202),new PVector(92,200),
                          new PVector(93,194),new PVector(94,192),new PVector(96,189),new PVector(97,186),new PVector(100,179),
                          new PVector(102,173),new PVector(105,165),new PVector(107,160),new PVector(109,158),new PVector(112,151),
                          new PVector(115,144),new PVector(117,139),new PVector(119,136),new PVector(119,134),new PVector(120,132),
                          new PVector(121,129),new PVector(122,127),new PVector(124,125),new PVector(126,124),new PVector(129,125),
                          new PVector(131,127),new PVector(132,130),new PVector(136,139),new PVector(141,154),new PVector(145,166),
                          new PVector(151,182),new PVector(156,193),new PVector(157,196),new PVector(161,209),new PVector(162,211),
                          new PVector(167,223),new PVector(169,229),new PVector(170,231),new PVector(173,237),new PVector(176,242),
                          new PVector(177,244),new PVector(179,250),new PVector(181,255),new PVector(182,257) };
       AddTemplate("caret", point5);

       // question
       PVector [] point6 = {new PVector(104,145),new PVector(103,142),new PVector(103,140),new PVector(103,138),new PVector(103,135),
                          new PVector(104,133),new PVector(105,131),new PVector(106,128),new PVector(107,125),new PVector(108,123),
                          new PVector(111,121),new PVector(113,118),new PVector(115,116),new PVector(117,116),new PVector(119,116),
                          new PVector(121,115),new PVector(124,116),new PVector(126,115),new PVector(128,114),new PVector(130,115),
                          new PVector(133,116),new PVector(135,117),new PVector(140,120),new PVector(142,121),new PVector(144,123),
                          new PVector(146,125),new PVector(149,127),new PVector(150,129),new PVector(152,130),new PVector(154,132),
                          new PVector(156,134),new PVector(158,137),new PVector(159,139),new PVector(160,141),new PVector(160,143),
                          new PVector(160,146),new PVector(160,149),new PVector(159,153),new PVector(158,155),new PVector(157,157),
                          new PVector(155,159),new PVector(153,161),new PVector(151,163),new PVector(146,167),new PVector(142,170),
                          new PVector(138,172),new PVector(134,173),new PVector(132,175),new PVector(127,175),new PVector(124,175),
                          new PVector(122,176),new PVector(120,178),new PVector(119,180),new PVector(119,183),new PVector(119,185),
                          new PVector(120,190),new PVector(121,194),new PVector(122,200),new PVector(123,205),new PVector(123,211),
                          new PVector(124,215),new PVector(124,223),new PVector(124,225)};
       AddTemplate("question", point6);
       
       // arrow
       PVector [] point7 = {new PVector(68,222),new PVector(70,220),new PVector(73,218),new PVector(75,217),new PVector(77,215),new PVector(80,213),new PVector(82,212),new PVector(84,210),new PVector(87,209),new PVector(89,208),new PVector(92,206),new PVector(95,204),new PVector(101,201),new PVector(106,198),new PVector(112,194),new PVector(118,191),new PVector(124,187),new PVector(127,186),new PVector(132,183),new PVector(138,181),new PVector(141,180),new PVector(146,178),new PVector(154,173),new PVector(159,171),new PVector(161,170),new PVector(166,167),new PVector(168,167),new PVector(171,166),new PVector(174,164),new PVector(177,162),new PVector(180,160),new PVector(182,158),new PVector(183,156),new PVector(181,154),new PVector(178,153),new PVector(171,153),new PVector(164,153),new PVector(160,153),new PVector(150,154),new PVector(147,155),new PVector(141,157),new PVector(137,158),new PVector(135,158),new PVector(137,158),new PVector(140,157),new PVector(143,156),new PVector(151,154),new PVector(160,152),new PVector(170,149),new PVector(179,147),new PVector(185,145),new PVector(192,144),new PVector(196,144),new PVector(198,144),new PVector(200,144),new PVector(201,147),new PVector(199,149),new PVector(194,157),new PVector(191,160),new PVector(186,167),new PVector(180,176),new PVector(177,179),new PVector(171,187),new PVector(169,189),new PVector(165,194),new PVector(164,196)};
       AddTemplate("arrow", point7);

       // left square bracket
       PVector [] point8 = {new PVector(140,124),new PVector(138,123),new PVector(135,122),new PVector(133,123),new PVector(130,123),new PVector(128,124),new PVector(125,125),new PVector(122,124),new PVector(120,124),new PVector(118,124),new PVector(116,125),new PVector(113,125),new PVector(111,125),new PVector(108,124),new PVector(106,125),new PVector(104,125),new PVector(102,124),new PVector(100,123),new PVector(98,123),new PVector(95,124),new PVector(93,123),new PVector(90,124),new PVector(88,124),new PVector(85,125),new PVector(83,126),new PVector(81,127),new PVector(81,129),new PVector(82,131),new PVector(82,134),new PVector(83,138),new PVector(84,141),new PVector(84,144),new PVector(85,148),new PVector(85,151),new PVector(86,156),new PVector(86,160),new PVector(86,164),new PVector(86,168),new PVector(87,171),new PVector(87,175),new PVector(87,179),new PVector(87,182),new PVector(87,186),new PVector(88,188),new PVector(88,195),new PVector(88,198),new PVector(88,201),new PVector(88,207),new PVector(89,211),new PVector(89,213),new PVector(89,217),new PVector(89,222),new PVector(88,225),new PVector(88,229),new PVector(88,231),new PVector(88,233),new PVector(88,235),new PVector(89,237),new PVector(89,240),new PVector(89,242),new PVector(91,241),new PVector(94,241),new PVector(96,240),new PVector(98,239),new PVector(105,240),new PVector(109,240),new PVector(113,239),new PVector(116,240),new PVector(121,239),new PVector(130,240),new PVector(136,237),new PVector(139,237),new PVector(144,238),new PVector(151,237),new PVector(157,236),new PVector(159,237)};
       AddTemplate("left square bracket", point8);
       
       // right square bracket.
       PVector [] point9 = {new PVector(112,138),new PVector(112,136),new PVector(115,136),new PVector(118,137),new PVector(120,136),new PVector(123,136),new PVector(125,136),new PVector(128,136),new PVector(131,136),new PVector(134,135),new PVector(137,135),new PVector(140,134),new PVector(143,133),new PVector(145,132),new PVector(147,132),new PVector(149,132),new PVector(152,132),new PVector(153,134),new PVector(154,137),new PVector(155,141),new PVector(156,144),new PVector(157,152),new PVector(158,161),new PVector(160,170),new PVector(162,182),new PVector(164,192),new PVector(166,200),new PVector(167,209),new PVector(168,214),new PVector(168,216),new PVector(169,221),new PVector(169,223),new PVector(169,228),new PVector(169,231),new PVector(166,233),new PVector(164,234),new PVector(161,235),new PVector(155,236),new PVector(147,235),new PVector(140,233),new PVector(131,233),new PVector(124,233),new PVector(117,235),new PVector(114,238),new PVector(112,238)};
       AddTemplate( "right square bracket", point9);
       
       // v
       PVector [] point10 = {new PVector(89,164),new PVector(90,162),new PVector(92,162),new PVector(94,164),new PVector(95,166),new PVector(96,169),new PVector(97,171),new PVector(99,175),new PVector(101,178),new PVector(103,182),new PVector(106,189),new PVector(108,194),new PVector(111,199),new PVector(114,204),new PVector(117,209),new PVector(119,214),new PVector(122,218),new PVector(124,222),new PVector(126,225),new PVector(128,228),new PVector(130,229),new PVector(133,233),new PVector(134,236),new PVector(136,239),new PVector(138,240),new PVector(139,242),new PVector(140,244),new PVector(142,242),new PVector(142,240),new PVector(142,237),new PVector(143,235),new PVector(143,233),new PVector(145,229),new PVector(146,226),new PVector(148,217),new PVector(149,208),new PVector(149,205),new PVector(151,196),new PVector(151,193),new PVector(153,182),new PVector(155,172),new PVector(157,165),new PVector(159,160),new PVector(162,155),new PVector(164,150),new PVector(165,148),new PVector(166,146)};
       AddTemplate( "v", point10);
       
       // delete
       PVector [] point11 = {new PVector(123,129),new PVector(123,131),new PVector(124,133),new PVector(125,136),new PVector(127,140),new PVector(129,142),new PVector(133,148),new PVector(137,154),new PVector(143,158),new PVector(145,161),new PVector(148,164),new PVector(153,170),new PVector(158,176),new PVector(160,178),new PVector(164,183),new PVector(168,188),new PVector(171,191),new PVector(175,196),new PVector(178,200),new PVector(180,202),new PVector(181,205),new PVector(184,208),new PVector(186,210),new PVector(187,213),new PVector(188,215),new PVector(186,212),new PVector(183,211),new PVector(177,208),new PVector(169,206),new PVector(162,205),new PVector(154,207),new PVector(145,209),new PVector(137,210),new PVector(129,214),new PVector(122,217),new PVector(118,218),new PVector(111,221),new PVector(109,222),new PVector(110,219),new PVector(112,217),new PVector(118,209),new PVector(120,207),new PVector(128,196),new PVector(135,187),new PVector(138,183),new PVector(148,167),new PVector(157,153),new PVector(163,145),new PVector(165,142),new PVector(172,133),new PVector(177,127),new PVector(179,127),new PVector(180,125)};
       AddTemplate( "delete", point11);
       
       // left curly brace
       PVector [] point12 = {new PVector(150,116),new PVector(147,117),new PVector(145,116),new PVector(142,116),new PVector(139,117),new PVector(136,117),new PVector(133,118),new PVector(129,121),new PVector(126,122),new PVector(123,123),new PVector(120,125),new PVector(118,127),new PVector(115,128),new PVector(113,129),new PVector(112,131),new PVector(113,134),new PVector(115,134),new PVector(117,135),new PVector(120,135),new PVector(123,137),new PVector(126,138),new PVector(129,140),new PVector(135,143),new PVector(137,144),new PVector(139,147),new PVector(141,149),new PVector(140,152),new PVector(139,155),new PVector(134,159),new PVector(131,161),new PVector(124,166),new PVector(121,166),new PVector(117,166),new PVector(114,167),new PVector(112,166),new PVector(114,164),new PVector(116,163),new PVector(118,163),new PVector(120,162),new PVector(122,163),new PVector(125,164),new PVector(127,165),new PVector(129,166),new PVector(130,168),new PVector(129,171),new PVector(127,175),new PVector(125,179),new PVector(123,184),new PVector(121,190),new PVector(120,194),new PVector(119,199),new PVector(120,202),new PVector(123,207),new PVector(127,211),new PVector(133,215),new PVector(142,219),new PVector(148,220),new PVector(151,221)};
       AddTemplate( "left curly brace", point12);
       
       // right curly brace
       PVector [] point13 = {new PVector(117,132),new PVector(115,132),new PVector(115,129),new PVector(117,129),new PVector(119,128),new PVector(122,127),new PVector(125,127),new PVector(127,127),new PVector(130,127),new PVector(133,129),new PVector(136,129),new PVector(138,130),new PVector(140,131),new PVector(143,134),new PVector(144,136),new PVector(145,139),new PVector(145,142),new PVector(145,145),new PVector(145,147),new PVector(145,149),new PVector(144,152),new PVector(142,157),new PVector(141,160),new PVector(139,163),new PVector(137,166),new PVector(135,167),new PVector(133,169),new PVector(131,172),new PVector(128,173),new PVector(126,176),new PVector(125,178),new PVector(125,180),new PVector(125,182),new PVector(126,184),new PVector(128,187),new PVector(130,187),new PVector(132,188),new PVector(135,189),new PVector(140,189),new PVector(145,189),new PVector(150,187),new PVector(155,186),new PVector(157,185),new PVector(159,184),new PVector(156,185),new PVector(154,185),new PVector(149,185),new PVector(145,187),new PVector(141,188),new PVector(136,191),new PVector(134,191),new PVector(131,192),new PVector(129,193),new PVector(129,195),new PVector(129,197),new PVector(131,200),new PVector(133,202),new PVector(136,206),new PVector(139,211),new PVector(142,215),new PVector(145,220),new PVector(147,225),new PVector(148,231),new PVector(147,239),new PVector(144,244),new PVector(139,248),new PVector(134,250),new PVector(126,253),new PVector(119,253),new PVector(115,253)};
       AddTemplate( "right curly brace", point13);
       
       // star
       PVector [] point14 = {new PVector(75,250),new PVector(75,247),new PVector(77,244),new PVector(78,242),new PVector(79,239),new PVector(80,237),new PVector(82,234),new PVector(82,232),new PVector(84,229),new PVector(85,225),new PVector(87,222),new PVector(88,219),new PVector(89,216),new PVector(91,212),new PVector(92,208),new PVector(94,204),new PVector(95,201),new PVector(96,196),new PVector(97,194),new PVector(98,191),new PVector(100,185),new PVector(102,178),new PVector(104,173),new PVector(104,171),new PVector(105,164),new PVector(106,158),new PVector(107,156),new PVector(107,152),new PVector(108,145),new PVector(109,141),new PVector(110,139),new PVector(112,133),new PVector(113,131),new PVector(116,127),new PVector(117,125),new PVector(119,122),new PVector(121,121),new PVector(123,120),new PVector(125,122),new PVector(125,125),new PVector(127,130),new PVector(128,133),new PVector(131,143),new PVector(136,153),new PVector(140,163),new PVector(144,172),new PVector(145,175),new PVector(151,189),new PVector(156,201),new PVector(161,213),new PVector(166,225),new PVector(169,233),new PVector(171,236),new PVector(174,243),new PVector(177,247),new PVector(178,249),new PVector(179,251),new PVector(180,253),new PVector(180,255),new PVector(179,257),new PVector(177,257),new PVector(174,255),new PVector(169,250),new PVector(164,247),new PVector(160,245),new PVector(149,238),new PVector(138,230),new PVector(127,221),new PVector(124,220),new PVector(112,212),new PVector(110,210),new PVector(96,201),new PVector(84,195),new PVector(74,190),new PVector(64,182),new PVector(55,175),new PVector(51,172),new PVector(49,170),new PVector(51,169),new PVector(56,169),new PVector(66,169),new PVector(78,168),new PVector(92,166),new PVector(107,164),new PVector(123,161),new PVector(140,162),new PVector(156,162),new PVector(171,160),new PVector(173,160),new PVector(186,160),new PVector(195,160),new PVector(198,161),new PVector(203,163),new PVector(208,163),new PVector(206,164),new PVector(200,167),new PVector(187,172),new PVector(174,179),new PVector(172,181),new PVector(153,192),new PVector(137,201),new PVector(123,211),new PVector(112,220),new PVector(99,229),new PVector(90,237),new PVector(80,244),new PVector(73,250),new PVector(69,254),new PVector(69,252)};
       AddTemplate( "star", point14);
  
       // pig tail
       PVector [] point15 = {new PVector(81,219),new PVector(84,218),new PVector(86,220),new PVector(88,220),new PVector(90,220),new PVector(92,219),new PVector(95,220),new PVector(97,219),new PVector(99,220),new PVector(102,218),new PVector(105,217),new PVector(107,216),new PVector(110,216),new PVector(113,214),new PVector(116,212),new PVector(118,210),new PVector(121,208),new PVector(124,205),new PVector(126,202),new PVector(129,199),new PVector(132,196),new PVector(136,191),new PVector(139,187),new PVector(142,182),new PVector(144,179),new PVector(146,174),new PVector(148,170),new PVector(149,168),new PVector(151,162),new PVector(152,160),new PVector(152,157),new PVector(152,155),new PVector(152,151),new PVector(152,149),new PVector(152,146),new PVector(149,142),new PVector(148,139),new PVector(145,137),new PVector(141,135),new PVector(139,135),new PVector(134,136),new PVector(130,140),new PVector(128,142),new PVector(126,145),new PVector(122,150),new PVector(119,158),new PVector(117,163),new PVector(115,170),new PVector(114,175),new PVector(117,184),new PVector(120,190),new PVector(125,199),new PVector(129,203),new PVector(133,208),new PVector(138,213),new PVector(145,215),new PVector(155,218),new PVector(164,219),new PVector(166,219),new PVector(177,219),new PVector(182,218),new PVector(192,216),new PVector(196,213),new PVector(199,212),new PVector(201,211)};       
       AddTemplate( "pigtail", point15);
     }
     
     Result Recognize( PVector [] points)
     {
        points = Resample( points, NumPVectors);
        points = RotateToZero( points );
        points = ScaleToSquare(points, SquareSize);
        points = TranslateToOrigin(points);
        float best = Infinity;
        float sndBest = Infinity;
        int t = -1;
        for( int i = 0; i < Templates.length; i++)
        {
          float d = DistanceAtBestAngle( points, Templates[i], -AngleRange, AngleRange, AnglePrecision);
          if( d < best )
          {
            sndBest = best;
            best = d;
            t = i;
          }
          else if( d < sndBest)
          {
            sndBest = d;
          }
        }
        float score = 1.0 - (best / HalfDiagonal);
        float otherScore = 1.0 - (sndBest / HalfDiagonal);
        float ratio = otherScore / score;
        // The threshold of 0.7 is arbitrary, and not part of the original code.
        if( t > -1 && score > 0.7)
        {
          return new Result( Templates[t].Name, score, ratio );
        }
        else
        {
          return new Result( "- none - ", 0.0, 1.0);
        }
     }
     
     int AddTemplate( String name, PVector [] points)
     {
          Templates = (Template []) append( Templates, new Template(name, points)); 
          int num = 0;
          for( int i = 0; i < Templates.length; i++)
          {
            if( Templates[ i ].Name == name)
            {
              num++;
            }
          } 
          return num;    
     }
     
     void DeleteUserTemplates( )
     {
       Templates = (Template [])subset(Templates, 0, NumTemplates);
     }
     
}

float PathLength( PVector [] points)
{
  float d = 0.0;
  for( int i = 1; i < points.length; i++)
  {
    d += points[i-1].dist( points[i]);
  }
  return d;
}

float PathDistance( PVector [] pts1, PVector [] pts2)
{
   if( pts1.length != pts2.length)
   {
     println( "Lengths differ. " + pts1.length + " != " + pts2.length);
     return Infinity;
   }
   float d = 0.0;
   for( int i = 0; i < pts1.length; i++)
   {
     d += pts1[i].dist( pts2[i]);
   }
   return d / (float)pts1.length;
}

Rectangle BoundingBox( PVector [] points)
{
  float minX = Infinity;
  float maxX = -Infinity;
  float minY = Infinity;
  float maxY = -Infinity;

  for( int i = 1; i < points.length; i++)
  {
    minX = min( points[i].x, minX);
    maxX = max( points[i].x, maxX);
    minY = min( points[i].y, minY);
    maxY = max( points[i].y, maxY);
  }
  return new Rectangle( minX, minY, maxX - minX, maxY - minY);
}

PVector Centroid( PVector [] points)
{
  PVector centriod = new PVector(0.0, 0.0);
  for( int i = 1; i < points.length; i++)
  {
      centriod.x += points[i].x;
      centriod.y += points[i].y;
  }  
  centriod.x /= points.length;
  centriod.y /= points.length;
  return centriod;
}

PVector [] RotateBy( PVector [] points, float theta)
{
   PVector c = Centroid( points );
   float Cos = cos( theta );
   float Sin = sin( theta );
   
   PVector [] newpoints = {};
   for( int i = 0; i < points.length; i++)
   {
     float qx = (points[i].x - c.x) * Cos - (points[i].y - c.y) * Sin + c.x;
     float qy = (points[i].x - c.x) * Sin + (points[i].y - c.y) * Cos + c.y;
     newpoints = (PVector[]) append(newpoints, new PVector( qx, qy ));
   }
   return newpoints;
}

PVector [] RotateToZero( PVector [] points)
{
   PVector c = Centroid( points );
   float theta = atan2( c.y - points[0].y, c.x - points[0].x);
   return RotateBy( points, -theta);
}

PVector [] Resample( PVector [] points, int n)
{
   float I = PathLength( points ) / ( (float)n -1.0 );
   float D = 0.0;
   PVector [] newpoints = {};
   Stack stack = new Stack();
   for( int i = 0; i < points.length; i++)
   {
     stack.push( points[ points.length -1 - i]);
   }   
   
   while( !stack.empty())
   {
       PVector pt1 = (PVector) stack.pop();
       
       if( stack.empty())
       {
         newpoints = (PVector [])append( newpoints, pt1);
         continue;
       }
       PVector pt2 = (PVector) stack.peek();
       float d = pt1.dist( pt2);
       if( (D + d) >= I)
       {
          float qx = pt1.x + (( I - D ) / d ) * (pt2.x - pt1.x);
          float qy = pt1.y + (( I - D ) / d ) * (pt2.y - pt1.y);
          PVector q = new PVector( qx, qy);
          newpoints = (PVector [])append( newpoints, q);
          stack.push( q );
          D = 0.0;
       } else {
         D += d;
       }
   }
   
   if( newpoints.length == (n -1) )
   {
     newpoints = (PVector [])append( newpoints, points[ points.length -1 ]);
   }
   return newpoints;
   
}

PVector [] ScaleToSquare( PVector [] points, float sz)
{
    Rectangle B = BoundingBox( points );
    PVector [] newpoints = {};
    for( int i = 0; i < points.length; i++)
    {
       float qx = points[i].x * (sz / B.Width);
       float qy = points[i].y * (sz / B.Height);
       newpoints = (PVector [])append( newpoints,  new PVector(qx, qy));
    }
    return newpoints;
}

float DistanceAtBestAngle( PVector [] points, Template T, float a, float b, float threshold)
{
   float x1 = Phi * a + (1.0 - Phi) * b;
   float f1 = DistanceAtAngle(points, T, x1);
   float x2 = (1.0 - Phi) * a + Phi * b;
   float f2 = DistanceAtAngle(points, T, x2);
   while( abs( b - a ) > threshold)
   {
     if( f1 < f2 )
     {
       b = x2;
       x2 = x1;
       f2 = f1;
       x1 = Phi * a + (1.0 - Phi) * b;
       f1 = DistanceAtAngle(points, T, x1);
     }
     else
     {
       a = x1;
       x1 = x2;
       f1 = f2;
       x2 = (1.0 - Phi) * a + Phi * b;
       f2 = DistanceAtAngle(points, T, x2);
     }
   }
   return min(f1, f2);
}


float DistanceAtAngle( PVector [] points, Template T, float theta)
{
  PVector [] newpoints = RotateBy( points, theta);
  return PathDistance( newpoints, T.PVectors);
}


PVector [] TranslateToOrigin( PVector [] points)
{
   PVector c = Centroid( points);
   PVector [] newpoints = {};
   for( int i = -0; i < points.length; i++)
   {
     float qx = points[i].x - c.x;
     float qy = points[i].y - c.y;
     newpoints = (PVector [])append( newpoints,  new PVector(qx, qy));
   }
   return newpoints;
}
