int pts = 10; 
float angle = 0;
float radius = 99;
float cylinderLength = 95;
int x = 0;
int y = 0;
PrintWriter output;
import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
JSONObject json;
//vertices
PVector vertices[][];
boolean isPyramid = false;


void setup(){
  output = createWriter("positions.txt");
  size(640, 360, P3D);
  noStroke();
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
}

void draw(){
  if ( myPort.available() > 0) 
  {  // If data is available,
  val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  if (val != null){
    
    try{
    json = parseJSONObject(val);
    x = json.getInt("M1")-90;
    y = json.getInt("M2")-90;
    output.println(val+"\n");
    output.flush(); 
    } catch (RuntimeException x){}}
  println(val); 
  background(170, 95, 95);
  lights();
  fill(255, 200, 200);
  translate(width/2, height/2);
  rotateX(radians(x));
  rotateY(radians(y));
  rotateZ(0);

  // initialize vertex arrays
  vertices = new PVector[2][pts+1];

  // fill arrays
  for (int i = 0; i < 2; i++){
    angle = 0;
    for(int j = 0; j <= pts; j++){
      vertices[i][j] = new PVector();
      if (isPyramid){
        if (i==1){
          vertices[i][j].x = 0;
          vertices[i][j].y = 0;
        }
        else {
          vertices[i][j].x = cos(radians(angle)) * radius;
          vertices[i][j].y = sin(radians(angle)) * radius;
        }
      } 
      else {
        vertices[i][j].x = cos(radians(angle)) * radius;
        vertices[i][j].y = sin(radians(angle)) * radius;
      }
      vertices[i][j].z = cylinderLength; 
      // the .0 after the 360 is critical
      angle += 360.0/pts;
    }
    cylinderLength *= -1;
  }

  // draw cylinder tube
  beginShape(QUAD_STRIP);
  for(int j = 0; j <= pts; j++){
    vertex(vertices[0][j].x, vertices[0][j].y, vertices[0][j].z);
    vertex(vertices[1][j].x, vertices[1][j].y, vertices[1][j].z);
  }
  endShape();

  //draw cylinder ends
  for (int i = 0; i < 2; i++){
    beginShape();
    for(int j = 0; j < pts; j++){
      vertex(vertices[i][j].x, vertices[i][j].y, vertices[i][j].z);
    }
    endShape(CLOSE);
  }
}


/*
 up/down arrow keys control
 polygon detail.
 */
void keyPressed(){
  if(key == CODED) { 
    // pts
    if (keyCode == UP) { 
      if (pts < 90){
        pts++;
      } 
    } 
    else if (keyCode == DOWN) { 
      if (pts > 4){
        pts--;
      }
    } 
  }
}
