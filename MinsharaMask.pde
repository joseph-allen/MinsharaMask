// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;

void setup() {
  sullscreen();
  cam = new Capture(this, 320, 240, 30);
  cam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, random(width), random(height));
}