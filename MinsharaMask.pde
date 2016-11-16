// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;
import gab.opencv.*;

//create Capture
Capture cam;
Capture screenshotCam;
float comparVal = 0.23;
private int[] screenshotImage;
PImage Mask;
OpenCV opencv;


void setup() {
  //size(1260,960);
  fullScreen();
  //back = loadImage("tmap2.png");
  //back.resize(width,height);
  //front = loadImage("tmap1.png");
  //front.resize(width,height);
  Mask = createImage(width,height,HSB);
  colorMode(HSB, 1,1,1);
  cam = new Capture(this,width,height);
  cam.start();
  screenshotCam = new Capture(this,width,height);
  screenshotCam.start();
  screenshotImage = new int[width*height];
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
         pixels[i] = cam.pixels[i];
         Mask.set(i % width, i / width, color(0,0,1));
       } else {
         pixels[i] = cam.pixels[i];
         Mask.set(i % width, i / width, color(0,0,0));
       }
    }
    
    updatePixels();
    Mask.filter(BLUR);
    opencv = new OpenCV(this, Mask);
    //PImage p=cam.get(0,0,width,height);
    //Mask.mask(p);
    opencv.gray();
    opencv.threshold(100);
    opencv.dilate();
    opencv.erode();
    Mask = opencv.getSnapshot();
    //mask over video
    blend(Mask, 0, 0, width, height, 0, 0, width, height, ADD);
    
    //whole mask as image
    //image(Mask,width,height);
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