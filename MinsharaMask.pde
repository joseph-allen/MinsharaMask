// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;

//create Capture
Capture cam;
Capture screenshotCam;
int count = 1;

private int[][] currentImage,screenshotImage;

void setup() {
  currentImage = new int[width][height];
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
  
  //fill array of pixel values
  for(int x = 0; x < width; x++){
   for(int y = 0; y < height; y++){
     currentImage[x][y] = get(x,y);
     set(x,y,currentImage[x][y] / count);
   }
  }
  
         
  image(screenshotCam,5*width/6,5*height/6,width/6,height/6);
  
  rect(0,0,width/6,height/6);
}

Boolean screenshotStopped = false;

void mouseClicked() {
  count += 1000;
  if(screenshotStopped){
    screenshotCam.start();
  } else {
    screenshotCam.stop();
    screenshotImage = new int[width][height];
    //fill array of pixel values
    for(int x = 0; x < width; x++){
     for(int y = 0; y < height; y++){
       screenshotImage[x][y] = get(x,y);
     }
    }
  }
  screenshotStopped = !screenshotStopped;
}