////RobbRain/////Textrain Spinoff, after Camille Utterback
////2013/////www.robb.cc//////////////////

import processing.video.*; ///add the library

Capture video;

int threshold = 99; //brightness value to count as dark
int letterSize = 20; //diameter of circles, real or imaginary that bound the falling shapes
int columnWidth = 30; //how wide you want the columns to be
int columnQty; //dependent on above
int numPix; //dependent, how many pixels are there?
int[] fallingY; //array of all the y values of our objects


void setup() {
  size(640, 480, P2D); // Change size to 320 x 240 if too slow at 640 x 480
  video = new Capture(this, width, height);
  video.start();  
  colorMode(HSB); //easy rainbows man
  noCursor(); //cursors are for sissys
  noStroke();//as are strokes
  smooth();//doesn't work.

  numPix = video.width*video.height; //calc the pixel qty
  columnQty = width/columnWidth; //calc the column qty

  fallingY = new int[columnQty]; //size that array
  for (int i = 0; i<columnQty;i++) { //itit to zero
    fallingY[i] = 10;
  }
}

void draw() {
  if (video.available()) {
    video.read();
    image(video, 0, 0);///Put up the regular video at 0,0
    video.loadPixels();

    for (int i = 0; i<columnQty;i++) { //populate array with pretty things.
      int sampleX= i*columnWidth+letterSize; //which pixel column?
      boolean touch;//this makes it easier for me to think.

      if (brightnessXY(sampleX, fallingY[i]+letterSize) < threshold) {///is base of circle on dark??
        touch = true;
      }
      else {
        touch = false;
      }
      
      if (!touch) {//if it isn't touching somehting, it should be.
        fallingY[i] +=5;
      }

      if (touch && brightnessXY(sampleX, fallingY[i]-5) < threshold) { ///if it is touhing something, but could be even higher, it should go for its dreams.
        fallingY[i] -=5;
      }

      if (fallingY[i] > height||fallingY[i]<0) {//if it falls off the bottom or top, it should go again. no giving up
        fallingY[i] = 10;
      }
      fallingLetter(sampleX, fallingY[i], i); ///draws the thing.
    }
  }
}


void fallingLetter(int letterX, int letterY, int letter) {
  fill(map(letter, 0, 21, 0, 255), 255, 255);
  ellipse(letterX, letterY, letterSize, letterSize);
  fill(0);
  text(letter, letterX-letterSize/2, letterY+letterSize/5);
}


int brightnessXY(int xxx, int yyy) { ///this lil guy calc the brightness of a video pixel and returns it as an int.
  int  videoIndex = constrain(yyy * video.width + xxx, 0, numPix-1);   //index = y*videoWidth + x
  int briteSpot = int(brightness(video.pixels[videoIndex]));
  return briteSpot;
}

void mouseTrack() { //useful for finding the proper threshold.
  float briteMouse = brightnessXY(mouseX, mouseY);
  if (briteMouse > threshold) { 
    fill(0);
  } 
  else { 
    fill(100);
  }
  rect(mouseX, mouseY, 20, 20);
}
