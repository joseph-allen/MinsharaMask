// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;
Capture screenshotCam;
float comparVal = 15;
private int[] screenshotImage;

void setup() {
  //size(1260,960);
  fullScreen();
  colorMode(HSB, 360,100,100);
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
  
       float diffHueSat = abs(currHue * currSaturation - screenshotHue * screenshotSaturation)/36000;
       
       //float diffIntensity = abs(currIntensity - screenshotIntensity);
       //pixels[i] = color(diffR,diffG,diffB);
         
       if (diffHueSat > comparVal) {
         pixels[i] = color(360,100,100);
       } else {
         pixels[i] = color(0,0,0);
       }
    }
    
      updatePixels();
  }
}

void mouseClicked() {
    for(int x = 0; x < width*height; x++){
      screenshotImage[x] = cam.pixels[x];
    }
}

void keyPressed() {
  print(comparVal);
  if (key == 'u') {
    comparVal += 1;
  } else {
    comparVal -= 1;
  }
}