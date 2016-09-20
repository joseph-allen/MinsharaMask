// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;
Capture screenshotCam;

private int[] screenshotImage;

void setup() {
  //size(1260,960);
  fullScreen();
  cam = new Capture(this,width,height);
  cam.start();
  screenshotCam = new Capture(this,width,height);
  screenshotCam.start();
  screenshotImage = new int[width*height];
}

void draw() {
  if(cam.available()) {
    cam.read();
      //fill array of pixel values pixels[]
  cam.loadPixels();
    for (int i = 0; i < width*height; i++) { // For each pixel in the video frame...
       cam.pixels[i] = abs(cam.pixels[i] - screenshotImage[i]);
    }
  }
  
  fill(cam.pixels[1]);
  
  image(cam,0,0);
  
  updatePixels();
  image(screenshotCam,5*width/6,5*height/6,width/6,height/6);
}

void mouseClicked() {
    for(int x = 0; x < width*height; x++){
      screenshotImage[x] = cam.pixels[x];
    }
}