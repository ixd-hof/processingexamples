import java.util.Iterator;

DicomObject dcmObj;
DicomInputStream din = null;
try {
  din = new DicomInputStream(new File(dataPath("test.dcm")));
  dcmObj = din.readDicomObject();

  Iterator<DicomElement> data = dcmObj.datasetIterator();
  while (data.hasNext ())
  {
    DicomElement element = data.next();
    //println(element);
    if(!element.isEmpty())
    {
      //String str = element.getString(new SpecificCharacterSet("UTF-8"), false);
      String str = new String(element.getBytes(), "UTF-8");
      println(element.length() + " " + str);
    }
  }
}
catch (IOException e) {
  e.printStackTrace();
  return;
}
