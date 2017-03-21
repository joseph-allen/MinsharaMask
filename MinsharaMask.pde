//Import Libraries
//If you have just installed Processing you will have to install these
import processing.video.*;
import gab.opencv.*;
import g4p_controls.*;

//create The Live Camera object
Capture liveCam;

//create PImages to store the capture, masks and the screenshot.
PImage camCapture, foregroundMask, backgroundMask, screenshot;

//PImage for Actual Image use
PImage foregroundImage, backgroundImage;

//PImage for Video use
PImage foregroundFrame, backgroundFrame;
Movie foregroundMovie, backgroundMovie;

//PImage for Code Use
PImage foregroundCode, backgroundCode;

//set Color masks for when colors selected
PImage foregroundColorMask, backgroundColorMask;
color foregroundColor, backgroundColor;
float comparVal = 0.25;

//save count incrementer
int saveCount = 0;

//flags for saving
boolean isSavingCamera, isSavingForeground, isSavingBackground, isSavingOutput;

//Enums for various choices
Algorithm algorithmChoice;
Foreground foregroundChoice;
Background backgroundChoice;
Filter filterChoice;

//decalre OpenCV objects for image processing
OpenCV opencvBackgroundSubtraction, opencv;

//setup loop, this runs once at the start of the programs execution
void setup() {

    //force fullScreen, remove this if you don't want fullScreen
    fullScreen();

    //set color mode to HSB, where Hue,Saturation and Brightness are from 0.0 to 1.0
    colorMode(HSB, 1, 1, 1);

    //initilize Camera
    liveCam = new Capture(this, width, height);

    //initilize images.
    camCapture = createImage(width, height, HSB);
    screenshot = createImage(width, height, HSB);
    foregroundMask = createImage(width, height, HSB);
    backgroundMask = createImage(width, height, HSB);

    //color masks
    foregroundColorMask = createImage(width, height, HSB);
    backgroundColorMask = createImage(width, height, HSB);

    //FG and BG colors for color masks, change these if you want to choose Color masks
    foregroundColor = color(0.3, 1, 1);
    backgroundColor = color(0.7, 1, 1);

    //initilise code masks to null
    foregroundCode = get();
    backgroundCode = get();

    //for each pixel set it to either the forgeground Color or background Color
    for (int x = 0; x < width * height; x++) {
        foregroundColorMask.set(x % width, x / width, foregroundColor);
        backgroundColorMask.set(x % width, x / width, backgroundColor);
    }

    //initilize background subtraction
    opencvBackgroundSubtraction = new OpenCV(this, width, height);

    //Start background subtraction
    opencvBackgroundSubtraction.startBackgroundSubtraction(5, 3, 0.5);

    //Set Alogirthm Choice default
    algorithmChoice = Algorithm.MINSHARA;

    //Set Foreground and Background choice defaults
    foregroundChoice = Foreground.COLOR;
    backgroundChoice = Background.CAMERA;

    //Set Filter choice to default
    filterChoice = Filter.NONE;

    //Load Images from folder, change these to change the Image masks
    foregroundImage = loadImage("data/Image/Front.png");
    backgroundImage = loadImage("data/Image/Back.png");

    //resize Images
    foregroundImage.resize(width, height);
    backgroundImage.resize(width, height);

    //Load Movies from folder, change these to change the Movie BG mask.
    foregroundMovie = new Movie(this, "Video/Front.mov");

    //FG Video settings
    //set FG to loop
    foregroundMovie.loop();
    foregroundMovie.stop();
    //default the Movie volume
    foregroundMovie.volume(0);

    //Load Movies from folder, change these to change the Movie FG mask.
    backgroundMovie = new Movie(this, "Video/Back.mov");

    //BG Video settings
    //set BG to loop
    backgroundMovie.loop();
    backgroundMovie.stop();
    //default the Movie volume
    backgroundMovie.volume(0);

    //Set up function for the Code masks
    codeForegroundSetup();
    codeBackgroundSetup();

    //live Camera start
    liveCam.start();

    //defaults for whether or not the masks save
    isSavingCamera = false;
    isSavingForeground = false;
    isSavingBackground = false;
    isSavingOutput = false;

    //Call createGUI
    createGUI();
}

//draw loop, runs for every frame
void draw() {

    //if we have a camera availible
    if (liveCam.available()) {
        //then read the camera
        liveCam.read();
    }

    //handle choices
    handleAlgorithmChoice();
    handleForegroundChoice();
    handleBackgroundChoice();

    //save all chosen Layers
    saveLayers();
    generateOutput();

    //handle filter choice
    handleFilterChoice();
}

//generate to output
void generateOutput() {

    //add the foreground and background masks together
    foregroundMask.blend(backgroundMask, 0, 0, width, height, 0, 0, width, height, ADD);

    //output the masks together
    image(foregroundMask, 0, 0);

    //if we are saving the output then save the frame
    if (isSavingOutput)
        saveFrame("Output/output-#####.jpg");

    //output the frameRate to help with movie making
    lblFrameRate.setText("frame Rate: " + String.valueOf(frameRate));
}

//save all Layers
void saveLayers() {
    //if we are saving any of the layers
    if (isSavingBackground || isSavingForeground || isSavingCamera) {

        //if we want to save Camera
        if (isSavingCamera)
            camCapture.save("Camera/camera-" + saveCount + ".jpg");

        //if we want to save the FG
        if (isSavingForeground)
            foregroundMask.save("Foreground/foreground-" + saveCount + ".jpg");

        //if we want to save the BG
        if (isSavingBackground)
            backgroundMask.save("Background/background-" + saveCount + ".jpg");

        //increment save counter
        saveCount++;
    }
}

//handle Algorithm Choice
void handleAlgorithmChoice() {

    //switch case dealing with algorithm choices
    switch (algorithmChoice) {
        case OPENCV:
            changeDetection2();
            break;

        case OPENCVBACKGROUND:
            changeDetection3();
            break;

        default:
            //case MINSHARA
            changeDetection1();
    }
}

//handle filter choice
void handleFilterChoice() {

    //switch to handle choice
    switch (filterChoice) {
        case GRAY:
            filter(GRAY);
            break;
        case INVERT:
            filter(INVERT);
            break;
        case POSTERIZE:
            filter(POSTERIZE, 4);
            break;
        case BLUR:
            filter(BLUR, 4);
            break;
        default:
            //apply no Filter
    }
}

//handle foreground choice
void handleForegroundChoice() {

    //switch to handle choice
    switch (foregroundChoice) {
        case COLOR:
            foregroundMask.blend(foregroundColorMask, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case IMAGE:
            foregroundMask.blend(foregroundImage, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case VIDEO:
            foregroundMovie.play();
            foregroundMask.blend(foregroundFrame, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case CODE:
            foregroundCode = codeForegroundDraw(foregroundCode);
            foregroundMask.blend(foregroundCode, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        default:
            //case CAMERA
            foregroundMask.blend(camCapture, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
    }
}

//handle background Choice
void handleBackgroundChoice() {

    //switch to handle background choice
    switch (backgroundChoice) {
        case COLOR:
            backgroundMask.blend(backgroundColorMask, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case IMAGE:
            backgroundMask.blend(backgroundImage, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case VIDEO:
            backgroundMovie.play();
            backgroundMask.blend(backgroundFrame, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        case CODE:
            backgroundCode = codeBackgroundDraw(backgroundCode);
            backgroundMask.blend(backgroundCode, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
            break;

        default:
            //case CAMERA
            backgroundMask.blend(camCapture, 0, 0, width, height, 0, 0, width, height, MULTIPLY);
    }
}

//Minshara Change Detection mask generation
void changeDetection1() {

    //set camCapture PImage to be current Frame
    camCapture.set(0, 0, liveCam);
    camCapture.loadPixels();

    //for each pixel
    for (int x = 0; x < width * height; x++) {

        //get pixel color in current scene
        color currentColor = camCapture.pixels[x];

        //get pixel color in screenshot
        color screenshotColor = screenshot.pixels[x];

        //get current Hue and Saturation
        float currHue = hue(currentColor);
        float currSaturation = saturation(currentColor);

        //get screenshot Hue and Saturation
        float screenshotHue = hue(screenshotColor);
        float screenshotSaturation = saturation(screenshotColor);

        //calculate absolute distance of Hue
        float hueDiff = abs(currHue - screenshotHue);

        //Cosine Rule to find total distance.
        double diffHueSat = Math.pow(currSaturation, 2) + Math.pow(screenshotSaturation, 2) - 2 * currSaturation * screenshotSaturation * cos(hueDiff);

        diffHueSat = sqrt((float) diffHueSat);

        //if the difference is greated than our threshold value
        if (diffHueSat > comparVal) {
            foregroundMask.set(x % width, x / width, color(0, 0, 1));
            backgroundMask.set(x % width, x / width, color(0, 0, 0));
        } else {
            foregroundMask.set(x % width, x / width, color(0, 0, 0));
            backgroundMask.set(x % width, x / width, color(0.5, 1, 1));
        }
    }

    //perform Opening on Image to remove noise
    opencv = new OpenCV(this, foregroundMask);
    opencv.blur(10);
    opencv.threshold(20);
    opencv.erode();
    opencv.dilate();
    opencv.erode();
    opencv.dilate();
    opencv.erode();
    opencv.dilate();

    //get snapshots
    foregroundMask = opencv.getSnapshot();
    opencv.invert();
    backgroundMask = opencv.getSnapshot();
}

//change using built in diff from openCV
void changeDetection2() {

    //set camCapture PImage to be current Frame
    camCapture.set(0, 0, liveCam);
    camCapture.loadPixels();

    opencv = new OpenCV(this, foregroundMask);

    opencv.loadImage(camCapture);

    opencv.diff(screenshot);

    //perform Opening on Image to remove noise
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


//change using built in diff from openCV with background subtraction
void changeDetection3() {

    //set camCapture PImage to be current Frame
    camCapture.set(0, 0, liveCam);
    camCapture.loadPixels();

    opencvBackgroundSubtraction.loadImage(camCapture);

    //background subtraction
    opencvBackgroundSubtraction.diff(screenshot);
    opencvBackgroundSubtraction.updateBackground();

    //perform Opening on Image to remove noise
    opencvBackgroundSubtraction.blur(10);
    opencvBackgroundSubtraction.threshold(20);
    opencvBackgroundSubtraction.erode();
    opencvBackgroundSubtraction.dilate();
    opencvBackgroundSubtraction.erode();
    opencvBackgroundSubtraction.dilate();
    opencvBackgroundSubtraction.erode();
    opencvBackgroundSubtraction.dilate();

    foregroundMask = opencvBackgroundSubtraction.getSnapshot();

    opencvBackgroundSubtraction.invert();
    backgroundMask = opencvBackgroundSubtraction.getSnapshot();
}

//this setup loop is specifically for the Foreground
void codeForegroundSetup() {
    //WRITE YOUR SETUP LOOP HERE 
}

//draw loop for Foreground mask
PImage codeForegroundDraw(PImage previousImage) {
    PImage newImage;
    image(previousImage, 0, 0);
    //WRITE YOUR CODE FOR THE FOREGROUND BELOW HERE 
    fill(0.8, 1, 1);
    ellipse(random(width), random(height), 50, 50);

    //WRITE YOUR CODE FOR THE FOREGROUND ABOVE HERE
    newImage = get();
    return newImage;
}

//this setup loop is specifically for the Background
void codeBackgroundSetup() {
    //WRITE YOUR SETUP LOOP HERE 
}

//draw loop for Background mask
PImage codeBackgroundDraw(PImage previousImage) {
    PImage newImage;
    image(previousImage, 0, 0);
    //WRITE YOUR CODE FOR THE FOREGROUND BELOW HERE 
    fill(0.3, 1, 1);
    rect(random(width), random(height), 50, 50);

    //WRITE YOUR CODE FOR THE FOREGROUND ABOVE HERE
    newImage = get();
    return newImage;
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
    m.read();

    //we deal with foreground and background movie frames here
    if (m == foregroundMovie) {
        foregroundFrame = m;
    } else if (m == backgroundMovie) {
        backgroundFrame = m;
    }
}

//Enum to select Algorithm
public enum Algorithm {
    MINSHARA,
    OPENCV,
    OPENCVBACKGROUND
}

//Enum to select Foreground
public enum Foreground {
    COLOR,
    IMAGE,
    VIDEO,
    CODE,
    CAMERA
}

//Enum to select Background
public enum Background {
    COLOR,
    IMAGE,
    VIDEO,
    CODE,
    CAMERA
}

//Enum to select Filter
public enum Filter {
    NONE,
    GRAY,
    INVERT,
    POSTERIZE,
    BLUR
}

//deal with key presses
void keyPressed() {

    //G for GUI, H for Hide
    if (key == 'g') {
        setGUI(true);
    } else if (key == 'h') {
        setGUI(false);
    };

    //C to Capture Scene
    if (key == 'c') {
        screenshot.set(0, 0, liveCam);

        //Camera flash to indicate capture
        rect(0, 0, width, height);
    }
}