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
Movie myMovie;

PImage movieFrame;


int dilateCount = 1;
int erodeCount = 1;

void setup() {
  //size(1260,960);
  fullScreen();
  colorMode(HSB, 1,1,1);
  cam = new Capture(this,width,height);
  cam.start();
  screenshotCam = new Capture(this,width,height);
  screenshotCam.start();
  screenshotImage = new int[width*height];
  
  myMovie = new Movie(this, "fish.mov");
  myMovie.loop();
  src = createImage(width,width,HSB);
  movieFrame = createImage(width,height,HSB);
  loadPixels();
}

void draw() {
  if(cam.available()) {
    cam.read();
      //fill array of pixel values pixels[]
  cam.loadPixels();
  //movieFrame.resize(width,height);
  myMovie.loadPixels();

    
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
         pixels[i] = movieFrame.pixels[i];
       } else {
         pixels[i] = color(0,0,0);
       }
       
       //put pixels into PImage for openCV
       
       src.set(i % width, i / width, pixels[i]);
       
       //movieFrame.set(i % width,i / width, myMovie.pixels[i]);
    } 
      updatePixels();
      
      opencv = new OpenCV(this, src);

       // save a snapshot to use in both operations
      opencv.erode();
      opencv.dilate();
      src = opencv.getSnapshot();

      //src.resize(width,height);
      image(src, 0, 0); 
      
      for (int i = 0; i < width*height; i++) {
           pixels[i] = movieFrame.pixels[i];
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
  println(comparVal);
  if (key == 'u') {
    comparVal += 0.01;
  } else if(key == 'd') {
    dilateCount += 1;
  } else if(key == 'e'){
    erodeCount +=1;
  } else {
    comparVal -= 0.01;
  }
}

void movieEvent( Movie m )
{
  myMovie.read();
  movieFrame = m;
}