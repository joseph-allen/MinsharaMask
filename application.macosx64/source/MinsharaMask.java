import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import gab.opencv.*; 
import g4p_controls.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MinsharaMask extends PApplet {

//Import Libraries
//If you have just installed Processing you will have to install these




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
int foregroundColor, backgroundColor;
float comparVal = 0.25f;

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
public void setup() {

    //force fullScreen, remove this if you don't want fullScreen
    

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
    foregroundColor = color(0.3f, 1, 1);
    backgroundColor = color(0.7f, 1, 1);

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
    opencvBackgroundSubtraction.startBackgroundSubtraction(5, 3, 0.5f);

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
public void draw() {

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
public void generateOutput() {

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
public void saveLayers() {
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
public void handleAlgorithmChoice() {

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
public void handleFilterChoice() {

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
public void handleForegroundChoice() {

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
public void handleBackgroundChoice() {

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
public void changeDetection1() {

    //set camCapture PImage to be current Frame
    camCapture.set(0, 0, liveCam);
    camCapture.loadPixels();

    //for each pixel
    for (int x = 0; x < width * height; x++) {

        //get pixel color in current scene
        int currentColor = camCapture.pixels[x];

        //get pixel color in screenshot
        int screenshotColor = screenshot.pixels[x];

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
            backgroundMask.set(x % width, x / width, color(0.5f, 1, 1));
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
public void changeDetection2() {

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
public void changeDetection3() {

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
public void codeForegroundSetup() {
    //WRITE YOUR SETUP LOOP HERE 
}

//draw loop for Foreground mask
public PImage codeForegroundDraw(PImage previousImage) {
    PImage newImage;
    image(previousImage, 0, 0);
    //WRITE YOUR CODE FOR THE FOREGROUND BELOW HERE 
    fill(0.8f, 1, 1);
    ellipse(random(width), random(height), 50, 50);

    //WRITE YOUR CODE FOR THE FOREGROUND ABOVE HERE
    newImage = get();
    return newImage;
}

//this setup loop is specifically for the Background
public void codeBackgroundSetup() {
    //WRITE YOUR SETUP LOOP HERE 
}

//draw loop for Background mask
public PImage codeBackgroundDraw(PImage previousImage) {
    PImage newImage;
    image(previousImage, 0, 0);
    //WRITE YOUR CODE FOR THE FOREGROUND BELOW HERE 
    fill(0.3f, 1, 1);
    rect(random(width), random(height), 50, 50);

    //WRITE YOUR CODE FOR THE FOREGROUND ABOVE HERE
    newImage = get();
    return newImage;
}

// Called every time a new frame is available to read
public void movieEvent(Movie m) {
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
public void keyPressed() {

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
//Declare all components
GLabel lblFrameRate, lblToggleGUIInfo;
GButton btnHideGUI;
GButton btnMinshara, btnOpenCV, btnOpenCVDiff;
GSlider sdr;
GButton btnFGColor, btnFGImage, btnFGVideo, btnFGCode, btnFGCamera;
GButton btnBGColor, btnBGImage, btnBGVideo, btnBGCode, btnBGCamera;
GCheckbox chkFGVideoAudio, chkBGVideoAudio;
GCheckbox chkSaveAll, chkSaveCamera, chkSaveFG, chkSaveBG, chkSaveOutput;
GButton btnFilterNone, btnFilterGray, btnFilterInvert, btnFilterPosterize, btnFilterBlur;
GLabel lblForeground, lblBackground, lblAlgoChoice, lblSave, lblFilter;

//create Gui Components
public void createGUI() {

    //Framerate label
    lblFrameRate = new GLabel(this, 10, 10, 200, 20);

    //Toggle GUI label  
    lblToggleGUIInfo = new GLabel(this, 10, 40, 300, 20);
    lblToggleGUIInfo.setText("Hide GUI with 'H' and show GUI with 'G'");

    //Hide GUI button
    btnHideGUI = new GButton(this, 250, 40, 120, 20);
    btnHideGUI.setText("Hide GUI");
    btnHideGUI.addEventHandler(this, "btnHideGUIClick");

    //Algorithm Choice label
    lblAlgoChoice = new GLabel(this, 10, 70, 300, 20);
    lblAlgoChoice.setText("Algorithm Choice:");

    //Minshara button
    btnMinshara = new GButton(this, 120, 70, 65, 20);
    btnMinshara.setText("Minshara");
    btnMinshara.addEventHandler(this, "btnMinsharaClick");
    btnMinshara.setLocalColorScheme(G4P.GREEN_SCHEME);

    //OpenCV button
    btnOpenCV = new GButton(this, 190, 70, 65, 20);
    btnOpenCV.setText("OpenCV");
    btnOpenCV.addEventHandler(this, "btnOpenCVClick");

    //OpenCVDiff button
    btnOpenCVDiff = new GButton(this, 260, 70, 85, 20);
    btnOpenCVDiff.setText("OpenCVDiff");
    btnOpenCVDiff.addEventHandler(this, "btnOpenCVDiffClick");

    //Tolerance slider
    sdr = new GSlider(this, 350, 70, 100, 20, 25);

    //Foreground label
    lblForeground = new GLabel(this, 10, 100, 300, 20);
    lblForeground.setText("Foreground Mask:");

    //Foreground Color button
    btnFGColor = new GButton(this, 120, 100, 65, 20);
    btnFGColor.setText("Color");
    btnFGColor.addEventHandler(this, "btnFGColorClick");
    btnFGColor.setLocalColorScheme(G4P.GREEN_SCHEME);

    //Foreground Image button
    btnFGImage = new GButton(this, 190, 100, 65, 20);
    btnFGImage.setText("Image");
    btnFGImage.addEventHandler(this, "btnFGImageClick");

    //Foreground Video button
    btnFGVideo = new GButton(this, 260, 100, 65, 20);
    btnFGVideo.setText("Video");
    btnFGVideo.addEventHandler(this, "btnFGVideoClick");

    //Foreground Code button
    btnFGCode = new GButton(this, 330, 100, 65, 20);
    btnFGCode.setText("Code");
    btnFGCode.addEventHandler(this, "btnFGCodeClick");

    //Foreground Camera button
    btnFGCamera = new GButton(this, 400, 100, 65, 20);
    btnFGCamera.setText("Camera");
    btnFGCamera.addEventHandler(this, "btnFGCameraClick");

    //Checkbox for Foreground Audio
    chkFGVideoAudio = new GCheckbox(this, 470, 100, 100, 20);
    chkFGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkFGVideoAudio.setText("FG Audio");
    chkFGVideoAudio.setSelected(true);
    chkFGVideoAudio.addEventHandler(this, "chkFGVideoAudioClick");

    //Background label
    lblBackground = new GLabel(this, 10, 130, 120, 20);
    lblBackground.setText("Background Mask:");

    //Background Color button
    btnBGColor = new GButton(this, 120, 130, 65, 20);
    btnBGColor.setText("Color");
    btnBGColor.addEventHandler(this, "btnBGColorClick");

    //Background Image button
    btnBGImage = new GButton(this, 190, 130, 65, 20);
    btnBGImage.setText("Image");
    btnBGImage.addEventHandler(this, "btnBGImageClick");

    //Background Video button
    btnBGVideo = new GButton(this, 260, 130, 65, 20);
    btnBGVideo.setText("Video");
    btnBGVideo.addEventHandler(this, "btnBGVideoClick");

    //Background Code button
    btnBGCode = new GButton(this, 330, 130, 65, 20);
    btnBGCode.setText("Code");
    btnBGCode.addEventHandler(this, "btnBGCodeClick");

    //Background Camera button
    btnBGCamera = new GButton(this, 400, 130, 65, 20);
    btnBGCamera.setText("Camera");
    btnBGCamera.addEventHandler(this, "btnBGCameraClick");
    btnBGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);

    //Checkbox Background Video Audio
    chkBGVideoAudio = new GCheckbox(this, 470, 130, 100, 20);
    chkBGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkBGVideoAudio.setText("BG Audio");
    chkBGVideoAudio.setSelected(true);
    chkBGVideoAudio.addEventHandler(this, "chkBGVideoAudioClick");

    //Save Label
    lblSave = new GLabel(this, 10, 160, 300, 20);
    lblSave.setText("Save Choice:");

    //Checkbox Save All
    chkSaveAll = new GCheckbox(this, 120, 160, 100, 20);
    chkSaveAll.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkSaveAll.setText("Save All");
    chkSaveAll.addEventHandler(this, "chkSaveAllClick");

    //Checkbox Save Camera
    chkSaveCamera = new GCheckbox(this, 120, 190, 100, 40);
    chkSaveCamera.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkSaveCamera.setText("Save Camera");
    chkSaveCamera.addEventHandler(this, "chkSaveCameraClick");

    //Checkbox Save FG
    chkSaveFG = new GCheckbox(this, 220, 190, 100, 40);
    chkSaveFG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkSaveFG.setText("Save FG");
    chkSaveFG.addEventHandler(this, "chkSaveFGClick");

    //Checkbox Save BG
    chkSaveBG = new GCheckbox(this, 290, 190, 100, 40);
    chkSaveBG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkSaveBG.setText("Save BG");
    chkSaveBG.addEventHandler(this, "chkSaveBGClick");

    //Checkbox Save Output
    chkSaveOutput = new GCheckbox(this, 360, 190, 100, 40);
    chkSaveOutput.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    chkSaveOutput.setText("Save Output");
    chkSaveOutput.addEventHandler(this, "chkSaveOutputClick");

    //Label Filter
    lblFilter = new GLabel(this, 10, 220, 300, 20);
    lblFilter.setText("Filter Choice:");

    //Filter None button
    btnFilterNone = new GButton(this, 120, 220, 65, 20);
    btnFilterNone.setText("None");
    btnFilterNone.addEventHandler(this, "btnFilterNoneClick");
    btnFilterNone.setLocalColorScheme(G4P.GREEN_SCHEME);

    //Filter Gray button
    btnFilterGray = new GButton(this, 190, 220, 65, 20);
    btnFilterGray.setText("Gray");
    btnFilterGray.addEventHandler(this, "btnFilterGrayClick");

    //Filter Invert button
    btnFilterInvert = new GButton(this, 260, 220, 65, 20);
    btnFilterInvert.setText("Invert");
    btnFilterInvert.addEventHandler(this, "btnFilterInvertClick");

    //Filter Posterize button
    btnFilterPosterize = new GButton(this, 330, 220, 65, 20);
    btnFilterPosterize.setText("Posterize");
    btnFilterPosterize.addEventHandler(this, "btnFilterPosterizeClick");

    //Filter Blur button
    btnFilterBlur = new GButton(this, 400, 220, 65, 20);
    btnFilterBlur.setText("Blur");
    btnFilterBlur.addEventHandler(this, "btnFilterBlurClick");
}

//handle Slider events
public void handleSliderEvents(GValueControl slider, GEvent event) {
    if (slider == sdr) // The slider being configured?
        comparVal = sdr.getValueF();
}

//handle button FG Color Clicks
public void btnFGColorClick(GButton source, GEvent event) {
    foregroundChoice = Foreground.COLOR;
    btnFGColor.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button FG Image Clicks
public void btnFGImageClick(GButton source, GEvent event) {
    foregroundChoice = Foreground.IMAGE;
    btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGImage.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button FG Video Clicks
public void btnFGVideoClick(GButton source, GEvent event) {
    foregroundChoice = Foreground.VIDEO;
    btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGVideo.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button FG Code click
public void btnFGCodeClick(GButton source, GEvent event) {
    foregroundChoice = Foreground.CODE;
    btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCode.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button FG Camera click
public void btnFGCameraClick(GButton source, GEvent event) {
    foregroundChoice = Foreground.CAMERA;
    btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);
}

//handle button BG Color click
public void btnBGColorClick(GButton source, GEvent event) {
    backgroundChoice = Background.COLOR;
    btnBGColor.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button BG Image click
public void btnBGImageClick(GButton source, GEvent event) {
    backgroundChoice = Background.IMAGE;
    btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGImage.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button BG Video click
public void btnBGVideoClick(GButton source, GEvent event) {
    backgroundChoice = Background.VIDEO;
    btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGVideo.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button BG Code click
public void btnBGCodeClick(GButton source, GEvent event) {
    backgroundChoice = Background.CODE;
    btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCode.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle button BG Camera click
public void btnBGCameraClick(GButton source, GEvent event) {
    backgroundChoice = Background.CAMERA;
    btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnBGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);
}

//handle button Minshara click
public void btnMinsharaClick(GButton source, GEvent event) {
    algorithmChoice = Algorithm.MINSHARA;
    btnMinshara.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnOpenCV.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnOpenCVDiff.setLocalColorScheme(G4P.BLUE_SCHEME);
    sdr.setVisible(true);
}

//handle button OpenCV click
public void btnOpenCVClick(GButton source, GEvent event) {
    algorithmChoice = Algorithm.OPENCV;
    btnMinshara.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnOpenCV.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnOpenCVDiff.setLocalColorScheme(G4P.BLUE_SCHEME);
    sdr.setVisible(false);
}

//handle button CVDiff click
public void btnOpenCVDiffClick(GButton source, GEvent event) {
    algorithmChoice = Algorithm.OPENCVBACKGROUND;
    btnMinshara.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnOpenCV.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnOpenCVDiff.setLocalColorScheme(G4P.GREEN_SCHEME);
    sdr.setVisible(false);
}

//handle FG Video Audio Checkbox click
public void chkFGVideoAudioClick(GCheckbox source, GEvent event) {
    if (chkFGVideoAudio.isSelected() == false) {
        foregroundMovie.volume(0);
    } else {
        foregroundMovie.volume(1);
    }
}

//handle BG Video Audio Checkbox click
public void chkBGVideoAudioClick(GCheckbox source, GEvent event) {
    if (chkBGVideoAudio.isSelected() == false) {
        backgroundMovie.volume(0);
    } else {
        backgroundMovie.volume(1);
    }
}

//handle Save All Checkbox click
public void chkSaveAllClick(GCheckbox source, GEvent event) {
    if (chkSaveAll.isSelected() == true) {
        chkSaveCamera.setSelected(true);
        isSavingCamera = true;

        chkSaveFG.setSelected(true);
        isSavingForeground = true;

        chkSaveBG.setSelected(true);
        isSavingBackground = true;

        chkSaveOutput.setSelected(true);
        isSavingOutput = true;
    } else {
        chkSaveCamera.setSelected(false);
        isSavingCamera = false;

        chkSaveFG.setSelected(false);
        isSavingForeground = false;

        chkSaveBG.setSelected(false);
        isSavingBackground = false;

        chkSaveOutput.setSelected(false);
        isSavingOutput = false;
    }
}

//handle Save Camera Checkbox click
public void chkSaveCameraClick(GCheckbox source, GEvent event) {
    if (chkSaveCamera.isSelected() == true) {
        isSavingCamera = true;
    } else {
        isSavingCamera = false;
    }
}

//handle Save FG Checkbox click
public void chkSaveFGClick(GCheckbox source, GEvent event) {
    if (chkSaveFG.isSelected() == true) {
        isSavingForeground = true;
    } else {
        isSavingForeground = false;
    }
}

//handle Save BG Checkbox click
public void chkSaveBGClick(GCheckbox source, GEvent event) {
    if (chkSaveBG.isSelected() == true) {
        isSavingBackground = true;
    } else {
        isSavingBackground = false;
    }
}

//handle Save Output Checkbox click
public void chkSaveOutputClick(GCheckbox source, GEvent event) {
    if (chkSaveCamera.isSelected() == true) {
        isSavingCamera = true;
    } else {
        isSavingCamera = false;
    }
}

//handle Hide GUI click
public void btnHideGUIClick(GButton source, GEvent event) {
    setGUI(false);
}

//handle Filter None click
public void btnFilterNoneClick(GButton source, GEvent event) {
    filterChoice = Filter.NONE;
    btnFilterNone.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle Filter Gray click
public void btnFilterGrayClick(GButton source, GEvent event) {
    filterChoice = Filter.GRAY;
    btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterGray.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle Filter Invert click
public void btnFilterInvertClick(GButton source, GEvent event) {
    filterChoice = Filter.INVERT;
    btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterInvert.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle Filter Posterize click
public void btnFilterPosterizeClick(GButton source, GEvent event) {
    filterChoice = Filter.POSTERIZE;
    btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterPosterize.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

//handle Filter Blur click
public void btnFilterBlurClick(GButton source, GEvent event) {
    filterChoice = Filter.BLUR;
    btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
    btnFilterBlur.setLocalColorScheme(G4P.GREEN_SCHEME);
}

//Show and Hide GUI function
public void setGUI(boolean setVisibleTo) {
    sdr.setVisible(setVisibleTo);
    btnFGColor.setVisible(setVisibleTo);
    btnFGImage.setVisible(setVisibleTo);
    btnFGVideo.setVisible(setVisibleTo);
    btnFGCode.setVisible(setVisibleTo);
    btnFGCamera.setVisible(setVisibleTo);
    btnBGColor.setVisible(setVisibleTo);
    btnBGImage.setVisible(setVisibleTo);
    btnBGVideo.setVisible(setVisibleTo);
    btnBGCode.setVisible(setVisibleTo);
    btnBGCamera.setVisible(setVisibleTo);
    btnMinshara.setVisible(setVisibleTo);
    btnOpenCV.setVisible(setVisibleTo);
    btnOpenCVDiff.setVisible(setVisibleTo);
    chkFGVideoAudio.setVisible(setVisibleTo);
    chkBGVideoAudio.setVisible(setVisibleTo);
    chkSaveAll.setVisible(setVisibleTo);
    chkSaveCamera.setVisible(setVisibleTo);
    chkSaveFG.setVisible(setVisibleTo);
    chkSaveBG.setVisible(setVisibleTo);
    chkSaveOutput.setVisible(setVisibleTo);
    lblFrameRate.setVisible(setVisibleTo);
    btnHideGUI.setVisible(setVisibleTo);
    lblToggleGUIInfo.setVisible(setVisibleTo);
    btnFilterNone.setVisible(setVisibleTo);
    btnFilterGray.setVisible(setVisibleTo);
    btnFilterInvert.setVisible(setVisibleTo);
    btnFilterPosterize.setVisible(setVisibleTo);
    btnFilterBlur.setVisible(setVisibleTo);
    lblForeground.setVisible(setVisibleTo);
    lblBackground.setVisible(setVisibleTo);
    lblAlgoChoice.setVisible(setVisibleTo);
    lblSave.setVisible(setVisibleTo);
    lblFilter.setVisible(setVisibleTo);
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MinsharaMask" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
