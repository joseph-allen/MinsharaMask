//Import Libraries
import processing.video.*;

//create Capture
Capture liveCam;
//create PImages
PImage camCapture, foregroundMask, backgroundMask, screenshot;

void setup() {
  //scene setup  
  fullScreen();
  colorMode(HSB,1,1,1);
  liveCam = new Capture(this,width,height);
  
  camCapture = createImage(width,height,HSB);
  screenshot = createImage(width,height,HSB);
  
  //live Camera start
  liveCam.start();
}

void draw() {
  if (liveCam.available()) {
    liveCam.read();
  }
  
  //set camCapture PImage to be current Frame
  camCapture.set(0,0,liveCam);
  
  image(camCapture,0,0); 
  image(screenshot,0,0);
}

void mouseClicked() {
  screenshot = camCapture; 
}