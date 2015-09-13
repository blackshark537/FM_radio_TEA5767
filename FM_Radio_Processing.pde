import processing.serial.*;

PFont f;
PImage img;
PGraphics ico;
int u = 5;
int d = 7;
int c = 8;
int x = 1;
int reg;
String [] Char = {
  ".", " ", "1"
};
String [] Num = {
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
};
Serial myPort;

//--------------------------------------------------
void setup() {
  size(200, 200);
  smooth(255);
  println(myPort.list());  
  myPort = new Serial(this, Serial.list()[0/*Change for Arduino Port*/], 9600);   //Setup Arduino SerialPort
  f = createFont("Arial", 32, true);
  img = loadImage("radio.png");
  ico = createGraphics(16, 16, JAVA2D);
  frame.setTitle("FM radio v1.0");
  ico.beginDraw();
  ico.image(img, 0, 0, 20, 20);
  ico.endDraw();
  frame.setIconImage(ico.image);
}
//------------------------------------------------
void draw() {
  background(0);
  fill(0, 255, 0);
  textFont(f);
  text(Char[x], 20, 100);
  text(Num[c], 40, 100);
  text(Num[d], 60, 100);
  text(Char[0], 80, 100);
  text(Num[u], 90, 100);
  text("FM", 110, 100);
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(30, 180, 20, 20);
  rect(170, 180, 20, 20);

  //------------------------------------------------
}

void mousePressed() {
  if (mouseX > 10 && mouseX < 50) {
    if (mouseY > 150 && mouseY < 190) {
      myPort.write(48);
    }
  }

  if (mouseX > 150 && mouseX < 190) {
    if (mouseY > 150 && mouseY < 190) {
      myPort.write(49);
    }
  }
}
//--------------------------------------------
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      myPort.write(48);
    }
  }
  /*if (key == CODED) {*/
  if (keyCode == RIGHT) {
    myPort.write(49);
    // }
  }
}


//--------------------------------------------

void serialEvent(Serial myPort) {
  reg = myPort.read();
  println(reg);
  if (reg == 48) {
    u --;
    if (u<0) {
      d --;
      u =9;
      if (d<0) {
        c--; 
        d =9;
        if (c<0) {
          c = 9;
          x = 1;
        }
      }
    }
    if (u == 4 && d == 7 && c == 8) {
      u =9;
      d =7;
      c =0;
      x =2;
      myPort.write(50);
    }
  }

  else   if ( reg == 49) {
    u ++;
    if (u>9) {
      d ++;
      u =0;
      if (d>9) {
        c++; 
        d =0;
        if (c>9) {
          c = 0;
          x = 2;
        }
      }
    }
    if (u == 0 && d == 8 && c == 0 && x == 2) {
      u =5;
      d =7;
      c =8;
      x =1;
      myPort.write(51);
    }
  }
}
/*-------------------------------
 |                               |
 |           END :)              |
 |                               |
 --------------------------------*/
