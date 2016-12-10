// Run this program only in the Java mode inside the IDE,
//import libraries
import processing.video.*;
import gab.opencv.*;
import blobDetection.*;

//create Capture
Capture cam;
BlobDetection theBlobDetection;
Capture screenshotCam;
float comparVal = 0.23;
private int[] screenshotImage;
PImage Mask;
PImage BigBlobMask;
OpenCV opencv;
OpenCV opticalFlow;


void setup() {
    fullScreen();
    Mask = createImage(width, height, HSB);

    colorMode(HSB, 1, 1, 1);
    cam = new Capture(this, width, height);
    cam.start();
    screenshotCam = new Capture(this, width, height);
    screenshotCam.start();
    screenshotImage = new int[width * height];
    loadPixels();

    theBlobDetection = new BlobDetection(width, height);
    theBlobDetection.setPosDiscrimination(true);
    theBlobDetection.setThreshold(0.2f);
    
    opticalFlow = new OpenCV(this, 1280, 800);

}

void draw() {
    if (cam.available()) {
        cam.read();
        cam.loadPixels();

        for (int i = 0; i < width * height; i++) {
            color currentColor = cam.pixels[i];
            color screenshotColor = screenshotImage[i];

            float currHue = hue(currentColor);
            float currSaturation = saturation(currentColor);

            float screenshotHue = hue(screenshotColor);
            float screenshotSaturation = saturation(screenshotColor);

            float saturationDiff = abs(currHue - screenshotHue);

            //COSINE RULE
            double diffHueSat = Math.pow(currSaturation, 2) + Math.pow(screenshotSaturation, 2) - 2 * currSaturation * screenshotSaturation * cos(saturationDiff);

            diffHueSat = sqrt((float) diffHueSat);

            if (diffHueSat > comparVal) {
                pixels[i] = cam.pixels[i];
                Mask.set(i % width, i / width, color(0, 0, 1));
            } else {
                pixels[i] = cam.pixels[i];
                Mask.set(i % width, i / width, color(0, 0, 0));
            }//if
            
        }//for

        updatePixels();
        
          cam.read();
        cam.loadPixels();
        opticalFlow.calculateOpticalFlow();
        opticalFlow.drawOpticalFlow();
        print(opticalFlow.getAverageFlowInRegion(0,0,width/2,height/2));
        
        
        //opencv = new OpenCV(this, Mask);
        //opencv.gray();
        //opencv.blur(6);
        //opencv.threshold(100);
        //opencv.dilate();
        //opencv.erode();
        //Mask = opencv.getSnapshot();
        //theBlobDetection.computeBlobs(Mask.pixels);
        //drawBlob(true);
        //drawBlobMask(true);
        //blend(BigBlobMask, 0, 0, width, height, 0, 0, width, height, ADD);
    }
}

void mouseClicked() {
    for (int x = 0; x < width * height; x++) {
        screenshotImage[x] = cam.pixels[x];
    }//for
}

void keyPressed() {
    println(comparVal);
    if (key == 'u') {
        comparVal += 0.01;
    } else {
        comparVal -= 0.01;
    }//if
}

void drawBlob(boolean drawBlobs){
    noFill();
    Blob b;
    
    for (int n = 0; n < theBlobDetection.getBlobNb(); n++) {
        b = theBlobDetection.getBlob(n);
        if (b != null) {
            // Edges

            // Blobs
            if (drawBlobs) {
                strokeWeight(5);
                stroke(0.3, 1, 0.6);

                if (b.h + b.w > 0.05) {
                    rect(
                        b.xMin * width, b.yMin * height,
                        b.w * width, b.h * height
                    );
                }//if
            }//if
        }//if
    }//for
}

void drawBlobMask(boolean drawBlobs) {
    noFill();
    Blob b;
    
    //clear the mask? is this the best way?
    BigBlobMask = createImage(width, height, HSB);

    for (int n = 0; n < theBlobDetection.getBlobNb(); n++) {
        b = theBlobDetection.getBlob(n);
        if (b != null) {

            // Blobs
            if (drawBlobs) {
                strokeWeight(5);
                stroke(0.3, 1, 0.6);

                if (b.h + b.w > 0.05) {
                    fill(1);
                    //Mask of Blobs
                    for (int x = Math.round(b.xMin * width); x < Math.round(b.xMax * width); x++) {
                        for (int y = Math.round(b.yMin * height); y < Math.round(b.yMax * height); y++) {
                            if(Mask.get(x,y) == color(1,0,1)){
                               BigBlobMask.set(x, y, color(1,0,1));  
                            }//if
                        }//for y
                    }//for x
                }//if
            }//if
        }//if
    }//for

    image(BigBlobMask, 0, 0);
    BigBlobMask.save("outputImage.jpg");
}