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
GLabel lblForeground,lblBackground,lblAlgoChoice,lblSave,lblFilter;

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
  if (slider == sdr)  // The slider being configured?
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