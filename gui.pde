// Create all the GUI controls. 
GSlider sdr;
GButton btnFGColor, btnFGImage, btnFGVideo, btnFGCode, btnFGCamera; 
GButton btnBGColor, btnBGImage, btnBGVideo, btnBGCode, btnBGCamera; 
GButton btnMinshara, btnOpenCV, btnOpenCVDiff;

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
}