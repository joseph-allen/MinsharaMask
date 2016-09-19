// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;

void setup() {
  //size(1280,960);
  fullScreen();
  cam = new Capture(this,width,height);
  cam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam,0,0);
}

void mouseClicked() {
  ellipse(0,0,50,50);
}