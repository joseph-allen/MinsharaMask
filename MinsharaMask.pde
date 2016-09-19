// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;
Capture screenshotCam;

void setup() {
  //size(1260,960);
  fullScreen();
  cam = new Capture(this,width,height);
  cam.start();
  screenshotCam = new Capture(this,width,height);
  screenshotCam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  if(screenshotCam.available()) {
    screenshotCam.read();
  }
  
  fill(get(500,500));
  
  image(cam,0,0);
  image(screenshotCam,5*width/6,5*height/6,width/6,height/6);
  
  rect(0,0,width/6,height/6);
}

Boolean screenshotStopped = false;

void mouseClicked() {
  if(screenshotStopped){
    screenshotCam.start();
  } else {
    screenshotCam.stop();
  }
  
  screenshotStopped = !screenshotStopped;
  print(screenshotStopped);
}