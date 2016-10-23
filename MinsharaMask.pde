// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;
import gab.opencv.*;

//create Capture
Capture cam;
Capture screenshotCam;
float comparVal = 0.23;
private int[] screenshotImage;
PImage src, dilated, eroded, both;
OpenCV opencv;


void setup() {
  //size(1260,960);
  fullScreen();
  colorMode(HSB, 1,1,1);
  cam = new Capture(this,width,height);
  cam.start();
  screenshotCam = new Capture(this,width,height);
  screenshotCam.start();
  screenshotImage = new int[width*height];
  
  src = createImage(width,width,HSB);
  loadPixels();
}

void draw() {
  if(cam.available()) {
    cam.read();
      //fill array of pixel values pixels[]
  cam.loadPixels();
 
  
    for (int i = 0; i < width*height; i++) {
       color currentColor = cam.pixels[i];
       color screenshotColor = screenshotImage[i];
       
       float currHue = hue(currentColor);
       float currSaturation = saturation(currentColor);
       
       float screenshotHue = hue(screenshotColor);
       float screenshotSaturation = saturation(screenshotColor);

       float saturationDiff = abs(currHue - screenshotHue);
       
       //COSINE RULE
       double diffHueSat = Math.pow(currSaturation,2) + Math.pow(screenshotSaturation,2) - 2*currSaturation*screenshotSaturation* cos(saturationDiff);
       
       //root
       diffHueSat = sqrt((float)diffHueSat);
       
       if (diffHueSat > comparVal) {
         pixels[i] = color(0.5,1,1);
       } else {
         pixels[i] = color(0,0,0);
       }
       
       //put pixels into PImage for openCV
       if(i % 2 ==0){
       src.set(i/2 % width, i/2 / width, pixels[i]);
       }
    } 
      updatePixels();
      
      opencv = new OpenCV(this, src);
      // Dilate and Erode both need a binary image
      // So, we'll make it gray and threshold it.
      opencv.gray();
      opencv.threshold(100);

       // save a snapshot to use in both operations
      src = opencv.getSnapshot();
    
      // erode and save snapshot for display
      opencv.erode();
      eroded = opencv.getSnapshot();
    
      // reload un-eroded image and dilate it
      opencv.loadImage(src);
      opencv.dilate();
      // save dilated version for display
      dilated = opencv.getSnapshot();
      // now erode on top of dilated version to close holes
      opencv.loadImage(src);
      
      opencv.erode();
      opencv.dilate();
      both = opencv.getSnapshot();
      src.resize(width/2,height);
      image(src, 0, 0);
      image(eroded, width/2, 0);
      image(dilated, 0, height/2);  
      image(both, width/2, height/2);  
      
      textSize(20);
      fill(0,255,50);
      text("original", 20, 20);
      text("erode", width/2 + 20, 20);
      text("dilate", 20, height/2 +20);
      text("dilate then erode", width/2 +20, height/2 +20);
  }
}

void mouseClicked() {
    for(int x = 0; x < width*height; x++){
      screenshotImage[x] = cam.pixels[x];
    }
}

void keyPressed() {
  println(comparVal);
  if (key == 'u') {
    comparVal += 0.01;
  } else {
    comparVal -= 0.01;
  }
}