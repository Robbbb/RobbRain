////RobbRain/////Textrain Spinoff, after Camille Utterback
////2013/////www.robb.cc//////////////////

import processing.video.*;

Capture video;

int threshold = 99; 
int letterSize = 20;
int columnWidth = 30;
int columnQty;
int numPix;
int[] fallingY;


void setup() {
  size(640, 480, P2D); // Change size to 320 x 240 if too slow at 640 x 480
  video = new Capture(this, width, height);
  video.start();  

  noCursor();
  noStroke();
  smooth();

  numPix = video.width*video.height;
  columnQty = width/columnWidth;

  fallingY = new int[columnQty];
  for (int i = 0; i<columnQty;i++) {
    fallingY[i] = 0;
  }
}

void draw() {
  if (video.available()) {
    video.read();
    image(video, 0, 0);///Put up the regular video at 0,0
    video.loadPixels();


    for (int i = 0; i<columnQty;i++) {



      int stripeIndex = i;
      int sampleX= stripeIndex*columnWidth+letterSize; //which pixel column?
      //    int  videoIndex = constrain(fallingY[i] * video.width + sampleX, 0, numPix-1);   //index = y*videoWidth + x
      //    float briteSpot = brightness(video.pixels[videoIndex]);

      if (brightnessXY(sampleX, fallingY[i]) > threshold) {
        fallingY[i] ++;
      }


      if (fallingY[i] > height) {//loop!
        fallingY[i] = 0;
      }
      fallingLetter(sampleX, fallingY[i], i);
    }
  }



  float briteMouse = brightnessXY(mouseX, mouseY);
  if (briteMouse > threshold) { 
    fill(0); 
  } 
  else { 
    fill(100); 
  }
  rect(mouseX, mouseY, 20, 20);
}


void fallingLetter(int letterX, int letterY, int letter) {
  fill(0, map(1, 0, 21, 0, 255), 0);
  ellipse(letterX, letterY, letterSize, letterSize);
  fill(0);
  text(letter, letterX+letterSize/2, letterY+letterSize/4);
}


int brightnessXY(int xxx, int yyy) {
  int  videoIndex = constrain(yyy * video.width + xxx, 0, numPix-1);   //index = y*videoWidth + x
  int briteSpot = int(brightness(video.pixels[videoIndex]));
  return briteSpot;
}

