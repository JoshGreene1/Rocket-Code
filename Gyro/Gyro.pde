import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
PFont f; 
JSONObject json;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
  size(500,300);
  f = createFont("Arial",16,true);
  json = new JSONObject();
}


int m1 = 0;
    int m2 = 0;
void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
  val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  println(val); //print it out in the console
  background(255);
  textFont(f,16);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color 
  
  if (val != null){
    
    try{
    json = parseJSONObject(val);
    m1 = json.getInt("M1");
    m2 = json.getInt("M2");
    } catch (RuntimeException x){}
    
    text("Motor 1 = " + str(m1),20,225);
    text("Motor 2 = " + str(m2),20,275);
    circle(125,100,80);
    circle(375,100,80);
    fill(255);
    rect(0,100,500,80);
    stroke(255);
    lineAngle(125,100,m1,80);
    lineAngle(375,100,m2,80);
}  // STEP 5 Display Text
}




void lineAngle(int x, int y, float angle, float length)
{
  angle = radians(angle);
  line(x, y, x+cos(angle)*length, y-sin(angle)*length);
}
