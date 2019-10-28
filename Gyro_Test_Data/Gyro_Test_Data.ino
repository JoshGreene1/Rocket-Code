#include <Servo.h>

#define delaytime 100
#define incrient 10

Servo M1;
Servo M2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  M1.attach(4);
  M2.attach(5);
  M1.write(0); 
  M2.write(0); 
}

void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i<=180;i+=incrient){
    Serial.print("{\"M1\":");
    Serial.print(i);
    Serial.print(",\"M2\":");
    Serial.print(180-i);
    Serial.println("}\n");
    M1.write(i); 
    M2.write(180-i); 
    delay(delaytime);
  }
  for (int i = 180; i>=0;i-=incrient){
    Serial.print("{\"M1\":");
    Serial.print(i);
    Serial.print(",\"M2\":");
    Serial.print(180-i);
    Serial.println("}\n");
    M1.write(i); 
    M2.write(180-i); 
    delay(delaytime);
  }
}
