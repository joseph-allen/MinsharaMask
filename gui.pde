// Create all the GUI controls. 
GSlider sdr;
GButton btnFGColor, btnFGImage, btnFGVideo, btnFGCode, btnFGCamera; 
GButton btnBGColor, btnBGImage, btnBGVideo, btnBGCode, btnBGCamera; 
GButton btnMinshara, btnOpenCV, btnOpenCVDiff;
GCheckbox chkFGVideoAudio, chkBGVideoAudio; 
GCheckbox chkSaveAll, chkSaveCamera, chkSaveFG, chkSaveBG, chkSaveOutput; 
GLabel lblFrameRate, lblToggleGUIInfo;
GButton btnHideGUI;
GButton btnFilterNone, btnFilterGray, btnFilterInvert, btnFilterPosterize, btnFilterBlur; 

GLabel lblForeground,lblBackground,lblAlgoChoice,lblSave,lblFilter;

public void createGUI() {
  //set up GUI
  lblFrameRate = new GLabel(this, 10, 10, 200, 20);
    
  lblToggleGUIInfo = new GLabel(this, 10, 40, 300, 20);
  lblToggleGUIInfo.setText("Hide GUI with 'H' and show GUI with 'G'");
  
  btnHideGUI = new GButton(this, 250, 40, 120, 20);
  btnHideGUI.setText("Hide GUI");
  btnHideGUI.addEventHandler(this, "btnHideGUIClick");
  
  lblAlgoChoice = new GLabel(this, 10, 70, 300, 20);
  lblAlgoChoice.setText("Algorithm Choice:");
  
  btnMinshara = new GButton(this, 120, 70, 65, 20);
  btnMinshara.setText("Minshara");
  btnMinshara.addEventHandler(this, "btnMinsharaClick");
  btnMinshara.setLocalColorScheme(G4P.GREEN_SCHEME);
    
  btnOpenCV = new GButton(this, 190, 70, 65, 20);
  btnOpenCV.setText("OpenCV");
  btnOpenCV.addEventHandler(this, "btnOpenCVClick");
    
  btnOpenCVDiff = new GButton(this, 260, 70, 85, 20);
  btnOpenCVDiff.setText("OpenCVDiff");
  btnOpenCVDiff.addEventHandler(this, "btnOpenCVDiffClick");
  
  sdr = new GSlider(this, 350, 70, 100, 20, 25);
  
  lblForeground = new GLabel(this, 10, 100, 300, 20);
  lblForeground.setText("Foreground Mask:");
  
  btnFGColor = new GButton(this, 120, 100, 65, 20);
  btnFGColor.setText("Color");
  btnFGColor.addEventHandler(this, "btnFGColorClick");
  btnFGColor.setLocalColorScheme(G4P.GREEN_SCHEME);
  
  btnFGImage = new GButton(this, 190, 100, 65, 20);
  btnFGImage.setText("Image");
  btnFGImage.addEventHandler(this, "btnFGImageClick");
    
  btnFGVideo = new GButton(this, 260, 100, 65, 20);
  btnFGVideo.setText("Video");
  btnFGVideo.addEventHandler(this, "btnFGVideoClick");
    
  btnFGCode = new GButton(this, 330, 100, 65, 20);
  btnFGCode.setText("Code");
  btnFGCode.addEventHandler(this, "btnFGCodeClick");
    
  btnFGCamera = new GButton(this, 400, 100, 65, 20);
  btnFGCamera.setText("Camera");
  btnFGCamera.addEventHandler(this, "btnFGCameraClick");
    
  chkFGVideoAudio = new GCheckbox(this, 470, 100, 100, 20);
  chkFGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkFGVideoAudio.setText("FG Audio");
  chkFGVideoAudio.setSelected(true);
  chkFGVideoAudio.addEventHandler(this, "chkFGVideoAudioClick");
  
  lblBackground = new GLabel(this, 10, 130, 120, 20);
  lblBackground.setText("Background Mask:");
  
  btnBGColor = new GButton(this, 120, 130, 65, 20);
  btnBGColor.setText("Color");
  btnBGColor.addEventHandler(this, "btnBGColorClick");
  
  btnBGImage = new GButton(this, 190, 130, 65, 20);
  btnBGImage.setText("Image");
  btnBGImage.addEventHandler(this, "btnBGImageClick");
    
  btnBGVideo = new GButton(this, 260, 130, 65, 20);
  btnBGVideo.setText("Video");
  btnBGVideo.addEventHandler(this, "btnBGVideoClick");
    
  btnBGCode = new GButton(this, 330, 130, 65, 20);
  btnBGCode.setText("Code");
  btnBGCode.addEventHandler(this, "btnBGCodeClick");
    
  btnBGCamera = new GButton(this, 400, 130, 65, 20);
  btnBGCamera.setText("Camera");
  btnBGCamera.addEventHandler(this, "btnBGCameraClick");
  btnBGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);
  
  chkBGVideoAudio = new GCheckbox(this, 470, 130, 100, 20);
  chkBGVideoAudio.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkBGVideoAudio.setText("BG Audio");
  chkBGVideoAudio.setSelected(true);
  chkBGVideoAudio.addEventHandler(this, "chkBGVideoAudioClick");
  
  lblSave = new GLabel(this, 10, 160, 300, 20);
  lblSave.setText("Save Choice:");
  
  chkSaveAll = new GCheckbox(this, 120, 160, 100, 20);
  chkSaveAll.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveAll.setText("Save All");
  chkSaveAll.addEventHandler(this, "chkSaveAllClick");
  
  chkSaveCamera = new GCheckbox(this, 120, 190, 100, 40);
  chkSaveCamera.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveCamera.setText("Save Camera");
  chkSaveCamera.addEventHandler(this, "chkSaveCameraClick");

  chkSaveFG = new GCheckbox(this, 220, 190, 100, 40);
  chkSaveFG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveFG.setText("Save FG");
  chkSaveFG.addEventHandler(this, "chkSaveFGClick");

  chkSaveBG = new GCheckbox(this, 290, 190, 100, 40);
  chkSaveBG.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveBG.setText("Save BG");
  chkSaveBG.addEventHandler(this, "chkSaveBGClick");

  chkSaveOutput = new GCheckbox(this, 360, 190, 100, 40);
  chkSaveOutput.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkSaveOutput.setText("Save Output");
  chkSaveOutput.addEventHandler(this, "chkSaveOutputClick");
  
  lblFilter = new GLabel(this, 10, 220, 300, 20);
  lblFilter.setText("Filter Choice:");
  
  btnFilterNone = new GButton(this, 120, 220, 65, 20);
  btnFilterNone.setText("None");
  btnFilterNone.addEventHandler(this, "btnFilterNoneClick");
  btnFilterNone.setLocalColorScheme(G4P.GREEN_SCHEME);
  
  btnFilterGray = new GButton(this, 190, 220, 65, 20);
  btnFilterGray.setText("Gray");
  btnFilterGray.addEventHandler(this, "btnFilterGrayClick");
  
  btnFilterInvert = new GButton(this, 260, 220, 65, 20);
  btnFilterInvert.setText("Invert");
  btnFilterInvert.addEventHandler(this, "btnFilterInvertClick");
  
  btnFilterPosterize = new GButton(this, 330, 220, 65, 20);
  btnFilterPosterize.setText("Posterize");
  btnFilterPosterize.addEventHandler(this, "btnFilterPosterizeClick");
  
  btnFilterBlur = new GButton(this, 400, 220, 65, 20);
  btnFilterBlur.setText("Blur");
  btnFilterBlur.addEventHandler(this, "btnFilterBlurClick");
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == sdr)  // The slider being configured?
    comparVal = sdr.getValueF();    
}

public void btnFGColorClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.COLOR;
  btnFGColor.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFGImageClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.IMAGE;
  btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGImage.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFGVideoClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.VIDEO;
  btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGVideo.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFGCodeClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.CODE;
  btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCode.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFGCameraClick(GButton source, GEvent event) {
  foregroundChoice = Foreground.CAMERA;
  btnFGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);
}

public void btnBGColorClick(GButton source, GEvent event) {
  backgroundChoice = Background.COLOR;
  btnBGColor.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnBGImageClick(GButton source, GEvent event) {
  backgroundChoice = Background.IMAGE;
  btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGImage.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnBGVideoClick(GButton source, GEvent event) {
  backgroundChoice = Background.VIDEO;
  btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGVideo.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnBGCodeClick(GButton source, GEvent event) {
  backgroundChoice = Background.CODE;
  btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCode.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnBGCamera.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnBGCameraClick(GButton source, GEvent event) {
  backgroundChoice = Background.CAMERA;
  btnBGColor.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGImage.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGVideo.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCode.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnBGCamera.setLocalColorScheme(G4P.GREEN_SCHEME);
}

public void btnMinsharaClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.MINSHARA;
  btnMinshara.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnOpenCV.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnOpenCVDiff.setLocalColorScheme(G4P.BLUE_SCHEME);
  sdr.setVisible(true);
}

public void btnOpenCVClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.OPENCV;
  btnMinshara.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnOpenCV.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnOpenCVDiff.setLocalColorScheme(G4P.BLUE_SCHEME);
  sdr.setVisible(false);
}

public void btnOpenCVDiffClick(GButton source, GEvent event) {
  algorithmChoice = Algorithm.OPENCVBACKGROUND;
  btnMinshara.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnOpenCV.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnOpenCVDiff.setLocalColorScheme(G4P.GREEN_SCHEME);
  sdr.setVisible(false);
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

public void btnHideGUIClick(GButton source, GEvent event) {
  setGUI(false);
}

public void btnFilterNoneClick(GButton source, GEvent event) {
  filterChoice = Filter.NONE;
  btnFilterNone.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFilterGrayClick(GButton source, GEvent event) {
  filterChoice = Filter.GRAY;
  btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterGray.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFilterInvertClick(GButton source, GEvent event) {
  filterChoice = Filter.INVERT;
  btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterInvert.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFilterPosterizeClick(GButton source, GEvent event) {
  filterChoice = Filter.POSTERIZE;
  btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterPosterize.setLocalColorScheme(G4P.GREEN_SCHEME);
  btnFilterBlur.setLocalColorScheme(G4P.BLUE_SCHEME);
}

public void btnFilterBlurClick(GButton source, GEvent event) {
  filterChoice = Filter.BLUR;
  btnFilterNone.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterGray.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterInvert.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterPosterize.setLocalColorScheme(G4P.BLUE_SCHEME);
  btnFilterBlur.setLocalColorScheme(G4P.GREEN_SCHEME);
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