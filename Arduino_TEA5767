// TEA5767 Example
//download library http://playground.arduino.cc/Main/TEA5767Radio

#include <Wire.h>
#include <TEA5767Radio.h>
float freq = 87.5;  //start freq
TEA5767Radio radio = TEA5767Radio();

void setup()
{ 
  Serial.begin(9600);
  Wire.begin();
  radio.setFrequency(freq); // pick your own frequency
}

void loop()
{
}

void serialEvent() {
  if (Serial.available()){
    char x = Serial.read();
    if( x == 49){
      freq += 0.10;
      Serial.write(x);
    }
    else if(x == 48){
      freq -= 0.10;
      Serial.write(x);
    }
    else if(x == 50){
      freq = 107.9;
      Serial.write(x);
    }
    else if(x == 51){
      freq = 87.5;
      Serial.write(x);
    }
    radio.setFrequency(freq);
  }
}
