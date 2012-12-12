Controller c;
ControllerEnvironment ce;
HashMap<String,Float> ct = new HashMap<String,Float>();

void initController(int id)
{
  c = ce.getControllers()[id];
  
  // Initial values
  ct.put("x", 0.0);
  ct.put("y", 0.0);
  ct.put("z", 0.0);
  ct.put("rx", 0.0);
  ct.put("ry", 0.0);
  ct.put("rz", 0.0);
  ct.put("b0", 0.0);
  ct.put("b1", 0.0);
}

HashMap updateController()
{
  c.poll();
  EventQueue queue = c.getEventQueue();
  Event event = new Event();

  while (queue.getNextEvent (event))
  {
    Component comp = event.getComponent();

    if (comp.getName() == "x")
      ct.put("x", (float)event.getValue());
    else if (comp.getName() == "y")
      ct.put("z", (float)event.getValue()); //ok
    else if (comp.getName() == "z")
      ct.put("y", (float)event.getValue());
    else if (comp.getName() == "rx")
      ct.put("rx", -(float)event.getValue());
    else if (comp.getName() == "ry")
      ct.put("rz", -(float)event.getValue());
    else if (comp.getName() == "rz")
      ct.put("ry", -(float)event.getValue());
    else if (comp.getName() == "0")
      ct.put("b0", (float)event.getValue());
    else if (comp.getName() == "1")
      ct.put("b1", (float)event.getValue());
  }
  return ct;
}

void listControllers()
{
  ce = ControllerEnvironment.getDefaultEnvironment();

  Controller[] cs = ce.getControllers();

  if (cs.length == 0) {
    System.out.println("No controllers found");
    System.exit(0);
  }

  for (int i = 0; i < cs.length; i++)
    System.out.println(i + ". " +
      cs[i].getName() + ", " + cs[i].getType() );
}

