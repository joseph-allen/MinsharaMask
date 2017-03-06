// Create all the GUI controls. 
GSlider sdr;
GButton btnFGColor, btnFGImage, btnFGVideo, btnFGCode, btnFGCamera; 
GButton btnBGColor, btnBGImage, btnBGVideo, btnBGCode, btnBGCamera; 
GButton btnMinshara, btnOpenCV, btnOpenCVDiff;
GCheckbox chkFGVideoAudio, chkBGVideoAudio; 
GCheckbox chkSaveAll, chkSaveCamera, chkSaveFG, chkSaveBG, chkSaveOutput; 
GLabel lblFrameRate;

public void createGUI() {
  //set up GUI
  sdr = new GSlider(this, 55, 20, 100, 50, 25);
  
  btnFGColor = new GButton(this, 55, 70, 110, 20);
  btnFGColor.setText("Color");
  btnFGColor.addEventHandler(this, "btnFGColorClick");
  
  btnFGImage = new GButton(this, 55, 100, 110, 20);
  btnFGImage.setText("Image");
  btnFGImage.addEventHandler(this, "btnFGImageClick");
    
  btnFGVideo = new GButton(this, 55, 130, 110, 20);
  btnFGVideo.setText("Video");
  btnFGVideo.addEventHandler(this, "btnFGVideoClick");
    
  btnFGCode = new GButton(this, 55, 160, 110, 20);
  btnFGCode.setText("Code");
  btnFGCode.addEventHandler(this, "btnFGCodeClick");
    
  btnFGCamera = new GButton(this, 55, 190, 110, 20);
  btnFGCamera.setText("Camera");
  btnFGCamera.addEventHandler(this, "btnFGCameraClick");
  
  btnBGColor = new GButton(this, 180, 70, 110, 20);
  btnBGColor.setText("Color");
  btnBGColor.addEventHandler(this, "btnBGColorClick");
  
  btnBGImage = new GButton(this, 180, 100, 110, 20);
  btnBGImage.setText("Image");
  btnBGImage.addEventHandler(this, "btnBGImageClick");
    
  btnBGVideo = new GButton(this, 180, 130, 110, 20);
  btnBGVideo.setText("Video");
  btnBGVideo.addEventHandler(this, "btnBGVideoClick");
    
  btnBGCode = new GButton(this, 180, 160, 110, 20);
  btnBGCode.setText("Code");
  btnBGCode.addEventHandler(this, "btnBGCodeClick");
    
  btnBGCamera = new GButton(this, 180, 190, 110, 20);
  btnBGCamera.setText("Camera");
  btnBGCamera.addEventHandler(this, "btnBGCameraClick");

  btnMinshara = new GButton(this, 320, 130, 110, 20);
  btnMinshara.setText("Minshara");
  btnMinshara.addEventHandler(this, "btnMinsharaClick");
    
  btnOpenCV = new GButton(this, 320, 160, 110, 20);
  btnOpenCV.setText("OpenCV");
  btnOpenCV.addEventHandler(this, "btnOpenCVClick");
    
  btnOpenCVDiff = new GButton(this, 320, 190, 110, 20);
  btnOpenCVDiff.setText("OpenCVDiff");
  btnOpenCVDiff.addEventHandler(this, "btnOpenCVDiffClick");
  
  chkFGVideoAudio = new GCheckbox(this, 55, 220, 120, 20);
  chkFGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkFGVideoAudio.setText("FG Audio");
  chkFGVideoAudio.setSelected(true);
  chkFGVideoAudio.addEventHandler(this, "chkFGVideoAudioClick");
  
  chkBGVideoAudio = new GCheckbox(this, 180, 220, 120, 20);
  chkBGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkBGVideoAudio.setText("BG Audio");
  chkBGVideoAudio.setSelected(true);
  chkBGVideoAudio.addEventHandler(this, "chkBGVideoAudioClick");
  
  chkSaveAll = new GCheckbox(this, 55, 250, 120, 20);
  chkSaveAll.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveAll.setText("Save All");
  chkSaveAll.addEventHandler(this, "chkSaveAllClick");
  
  chkSaveCamera = new GCheckbox(this, 55, 280, 120, 20);
  chkSaveCamera.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveCamera.setText("Save Camera");
  chkSaveCamera.addEventHandler(this, "chkSaveCameraClick");

  chkSaveFG = new GCheckbox(this, 180, 280, 120, 20);
  chkSaveFG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveFG.setText("Save FG");
  chkSaveFG.addEventHandler(this, "chkSaveFGClick");

  chkSaveBG = new GCheckbox(this, 305, 280, 120, 20);
  chkSaveBG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveBG.setText("Save BG");
  chkSaveBG.addEventHandler(this, "chkSaveBGClick");

  chkSaveOutput = new GCheckbox(this, 430, 280, 120, 20);
  chkSaveOutput.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveOutput.setText("Save Output");
  chkSaveOutput.addEventHandler(this, "chkSaveOutputClick");
  
  lblFrameRate = new GLabel(this, 55, 10, 200, 20);
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == sdr)  // The slider being configured?
    comparVal = sdr.getValueF();    
}

public void btnFGColorClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.COLOR;
}

public void btnFGImageClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.IMAGE;
}

public void btnFGVideoClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.VIDEO;
}

public void btnFGCodeClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.CODE;
}

public void btnFGCameraClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.CAMERA;
}

public void btnBGColorClick(GButton source, GEvent event) {
  backgroundChoice = Background.COLOR;
}

public void btnBGImageClick(GButton source, GEvent event) {
  backgroundChoice = Background.IMAGE;
}

public void btnBGVideoClick(GButton source, GEvent event) {
  backgroundChoice = Background.VIDEO;
}

public void btnBGCodeClick(GButton source, GEvent event) {
  backgroundChoice = Background.CODE;
}

public void btnBGCameraClick(GButton source, GEvent event) {
  backgroundChoice = Background.CAMERA;
}

public void btnMinsharaClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.MINSHARA;
}

public void btnOpenCVClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.OPENCV;
}

public void btnOpenCVDiffClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.OPENCVBACKGROUND;
}

public void chkFGVideoAudioClick(GCheckbox source, GEvent event) {
  if (chkFGVideoAudio.isSelected() == false) {
   foregroundMovie.volume(0);
  } else {
   foregroundMovie.volume(1); 
  }
}

public void chkBGVideoAudioClick(GCheckbox source, GEvent event) {
  if (chkBGVideoAudio.isSelected() == false) {
   backgroundMovie.volume(0);
  } else {
   backgroundMovie.volume(1); 
  }
}

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

public void chkSaveCameraClick(GCheckbox source, GEvent event) {
  if (chkSaveCamera.isSelected() == true) {
    isSavingCamera = true;
  } else {
    isSavingCamera = false;
  }
}

public void chkSaveFGClick(GCheckbox source, GEvent event) {
  if (chkSaveFG.isSelected() == true) {
    isSavingForeground = true;
  } else {
    isSavingForeground = false;
  }
}

public void chkSaveBGClick(GCheckbox source, GEvent event) {
  if (chkSaveBG.isSelected() == true) {
    isSavingBackground = true;
  } else {
    isSavingBackground = false;
  }
}

public void chkSaveOutputClick(GCheckbox source, GEvent event) {
  if (chkSaveCamera.isSelected() == true) {
    isSavingCamera = true;
  } else {
    isSavingCamera = false;
  }
}

public void setGUI(boolean setVisibleTo){
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
}