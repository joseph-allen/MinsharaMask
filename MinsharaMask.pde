//Import Libraries
import processing.video.*;
import gab.opencv.*;

//create Capture
Capture liveCam;
//create PImages
PImage camCapture, foregroundMask, backgroundMask, screenshot;

//PImage for Actual Image use
PImage foregroundImage, backgroundImage;

//PImage for Video use
PImage foregroundFrame, backgroundFrame;
Movie foregroundMovie, backgroundMovie;

//set Color masks for when colors selected
PImage foregroundColorMask, backgroundColorMask;
color foregroundColor, backgroundColor;
float comparVal = 0.25;

Algorithm algorithmChoice;

OpenCV opencv;

void setup() {
  //scene setup  
  fullScreen();
  colorMode(HSB,1,1,1);
  
  liveCam = new Capture(this,width,height);
  
  camCapture = createImage(width,height,HSB);
  screenshot = createImage(width,height,HSB);
  foregroundMask = createImage(width,height,HSB);
  backgroundMask = createImage(width,height,HSB);
  
  //color masks
  foregroundColorMask = createImage(width,height,HSB);
  backgroundColorMask = createImage(width,height,HSB);
  
  foregroundColor = color(0.3,1,1);
  backgroundColor = color(0.7,1,1);
  
  for(int x = 0; x < width*height; x++){
    foregroundColorMask.set(x % width, x / width, foregroundColor); 
    backgroundColorMask.set(x % width, x / width, backgroundColor); 
  }
  
  opencv = new OpenCV(this, width, height);

  //we need this line for changedetection3
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  //Set Alogirthm Choice default
  algorithmChoice = Algorithm.MINSHARA;
  
  //load images
  foregroundImage = loadImage("data/Image/Front.png");
  backgroundImage = loadImage("data/Image/Back.png");
  
  //resize Images
  foregroundImage.resize(width, height);
  backgroundImage.resize(width, height);
  
  //load Movies, this implicitly looks in a data folder
  foregroundMovie = new Movie(this, "Video/testvideo.mov");
  foregroundMovie.loop();
  //mute movie?
  //foregroundMovie.volume(0);
  
  backgroundMovie = new Movie(this, "Video/fish.mov");
  backgroundMovie.loop();
  //mute movie?
  backgroundMovie.volume(0);
  
  //live Camera start
  liveCam.start();
}

void draw() {
  if (liveCam.available()) {
    liveCam.read();
  }
  
  switch(algorithmChoice) {
   case OPENCV:
     changeDetection2();
     break;
   
   case OPENCVBACKGROUND:
     changeDetection3();
     break;
   
   default:
     changeDetection1();
  }

  image(foregroundColorMask,0,0);
  
  //image(camCapture,0,0); 
  //image(backgroundMask,0,0);
  //image(foregroundMask,0,0);
  //image(screenshot, 0, 0);
  
  //for colors
  //foregroundMask.blend(foregroundColorMask, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  //backgroundMask.blend(backgroundColorMask, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  
  //for images
  //foregroundMask.blend(foregroundImage, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  //backgroundMask.blend(backgroundImage, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  
  //for videos
  foregroundMask.blend(foregroundFrame, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  backgroundMask.blend(backgroundFrame, 0, 0, width, height, 0, 0, width, height, MULTIPLY); 
  
  //camCapture.blend(foregroundMask, 0, 0, width, height, 0, 0, width, height, ADD);
  
  //overlay the background and foreground masks
  foregroundMask.blend(backgroundMask, 0, 0, width, height, 0, 0, width, height, ADD); 
  //image(camCapture,0,0);
  image(foregroundMask,0,0);
}

void changeDetection1() {
  //set camCapture PImage to be current Frame
  camCapture.set(0,0,liveCam);
  camCapture.loadPixels();
  
  for(int x = 0; x < width * height; x++){
    color currentColor = camCapture.pixels[x];
    color screenshotColor = screenshot.pixels[x];
    
    float currHue = hue(currentColor);
    float currSaturation = saturation(currentColor);
    
    float screenshotHue = hue(screenshotColor);
    float screenshotSaturation = saturation(screenshotColor);
    
    //is this a bug?
    float saturationDiff = abs(currHue - screenshotHue);
    
    //Cosine Rule
    double diffHueSat = Math.pow(currSaturation,2) + Math.pow(screenshotSaturation,2) - 2 * currSaturation * screenshotSaturation * cos(saturationDiff);

    //this is redundant?
    diffHueSat = sqrt((float) diffHueSat);
    
    if (diffHueSat > comparVal) {
      foregroundMask.set(x % width, x / width, color(0,0,1));  
      backgroundMask.set(x % width, x / width, color(0,0,0));
    } else {
      foregroundMask.set(x % width, x / width, color(0,0,0));
      backgroundMask.set(x % width, x / width, color(0.5,1,1));
    }
  }

  opencv = new OpenCV(this, foregroundMask);
  opencv.blur(10);
  opencv.threshold(20);
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  
  foregroundMask = opencv.getSnapshot();
  opencv.invert();
  backgroundMask = opencv.getSnapshot();
}

//change using built in diff from openCV
void changeDetection2() {
  
  camCapture.set(0,0,liveCam);
  camCapture.loadPixels();

  opencv = new OpenCV(this, foregroundMask);
  
  opencv.loadImage(camCapture);
  
  opencv.diff(screenshot);
  
  opencv.blur(10);
  opencv.threshold(20);
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  
  foregroundMask = opencv.getSnapshot(); 
  
  opencv.invert();
  backgroundMask = opencv.getSnapshot(); 
}


//change using built in diff from openCV
void changeDetection3() {
    
  camCapture.set(0,0,liveCam);
  camCapture.loadPixels();
  
  opencv.loadImage(camCapture);
  
  opencv.diff(screenshot);
  opencv.updateBackground();
  opencv.blur(10);
  opencv.threshold(20);
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  opencv.erode();
  opencv.dilate();
  
  foregroundMask = opencv.getSnapshot(); 
  
  opencv.invert();
  backgroundMask = opencv.getSnapshot(); 

}

void mouseClicked() {
  screenshot.set(0,0,liveCam);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  if (m == foregroundMovie) {
    foregroundFrame = m;
  } else if (m == backgroundMovie) {
    backgroundFrame = m;
  }
}

public enum Algorithm {
  MINSHARA, OPENCV, OPENCVBACKGROUND
}