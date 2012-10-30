// IxD Hof Creative Coding Class 2012
// http://ixd-hof.de
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// Comparing strings and trigger effects
// Play around with the string and it's case

String t = "Hello";

// if t equals a lower case "hello"
if (t == "hello")
{
  println (t + ": lower case");
}
// if t is written with a upper case H
else if (t == "Hello")
{
  println (t + ": upper case");
}
// does not match anything
else
{
  println("something else: " + t);
}
