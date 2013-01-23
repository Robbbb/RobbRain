/**
 * Brightness Thresholding 
 * by Golan Levin. 
 *
 * Determines whether a test location (such as the cursor) is contained within
 * the silhouette of a dark object. 
 */


import processing.video.*;

color black = color(0);
color white = color(255);
int numPixels;
Capture video;

int letterSize = 20;
int columnWidth = 30;
int columnQty;

void setup() {
  size(640, 480, P2D); // Change size to 320 x 240 if too slow at 640 x 480
  strokeWeight(5);
  columnQty = width/columnWidth;
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, width, height);
  video.start();  
  numPixels = video.width * video.height;
  noCursor();
  smooth();
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    int threshold = 66; // Set the threshold value
    float pixelBrightness; // Declare variable to store a pixel's color
    // Turn each pixel in the video frame black or white depending on its brightness
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
      pixelBrightness = brightness(video.pixels[i]);
      if (pixelBrightness > threshold) { // If the pixel is brighter than the
        pixels[i] = white; // threshold value, make it white
      } 
      else { // Otherwise,
        pixels[i] = black; // make it black
      }
    }
    updatePixels();
    // Test a location to see where it is contained. Fetch the pixel at the test
    // location (the cursor), and compute its brightness
    int testValue = get(mouseX, mouseY);
    float testBrightness = brightness(testValue);
    if (testBrightness > threshold) { // If the test location is brighter than
      fill(black); // the threshold set the fill to black
    } 
    else { // Otherwise,
      fill(white); // set the fill to white
    }
    ellipse(mouseX, mouseY, 20, 20);

     for (int i = 0; i<columnQty;i++) {
    okaygetthis(i);
     }
  }
}







void okaygetthis(int stripeIndex) {
  //int stripeIndex = 3;
  int sampleX= stripeIndex*columnWidth+letterSize; //which pixel column?
int sampleY = 0 ; 

  int threshold = 66; // Set the threshold valu


  int testValue = get(sampleX, sampleY);
  //println(testValue);
  if (sampleY > height) {//loop?
    sampleY = 0;
  }
  if (testValue==-1) {
    sampleY ++;
  }

  else {

  }
 noStroke();
  fill(255, 0, 0);//red
  ellipse( sampleX, sampleY, 20, 20); //dot
}


//
//  noStroke();
//  //println(columnQty);
//  for (int i = 0; i<columnQty;i++) {
//    int hardStop =sampleStripe(i);
//    fallingLetter(i, 50, i);
//  }
//}
//

//void fallingLetter(int letterIndex, float letterY, int letter) {
//  fill(0, 255, 0);
//  ellipse(letterIndex*columnWidth+letterSize, letterY, letterSize, letterSize);
//  fill(0);
//  text(letter, letterIndex*columnWidth+letterSize/2, letterY+letterSize/4);
//}

