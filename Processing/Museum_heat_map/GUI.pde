import controlP5.*;

ControlP5 cp5;
Range histogramRangeSlider;
Chart histogramChart;
int speedMax = 30;

PFont f;
int histogramX = 40;
int histogramY = 470;
int histogramW = 480;
int histogramH = 100;
int imagePlayerSliderH = 15;
int imagePlayerButtonX = histogramX;
int imagePlayerButtonY = histogramY - 60;
int heatMapButtonX = histogramX+histogramW-70;
int heatMapButtonY = imagePlayerButtonY;
int numbersButtonX = histogramX+histogramW-160;
int numbersButtonY = imagePlayerButtonY;
int speedSliderX = histogramX;
int speedSliderY = histogramY + histogramH +80;
int speedSliderW = histogramW;
int speedSliderH = 20;

void setupSettingsGui(){
  
  println("First gui");
  background(0);
  cp5 = new ControlP5(this);
  f = createFont("",14);
  cp5.setFont(f);
  
  cp5.addTextfield("backgroundImage")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(f)
     .setAutoClear(false)
     .setCaptionLabel("Input nr of the reference image")
     .setText(""+BACKGROUND_IMAGE_INDEX);
     ;
  
  cp5.addTextfield("startImageIndex")
     .setPosition(20,200)
     .setSize(200,40)
     .setFont(f)
     .setAutoClear(false)
     .setCaptionLabel("Input nr of image to start from")
     .setText(""+START_IMAGE_INDEX);
     ;
  
  cp5.addTextfield("nrOfImagesToRun")
     .setPosition(20,300)
     .setSize(200,40)
     .setFont(f)
     .setAutoClear(false)
     .setCaptionLabel("Input nr of images to analyze")
     .setText(""+NR_OR_IMAGES);
     ;
  
  cp5.addSlider("avgBoxSize")
     .setBroadcast(false)
     .setPosition(20,400)
     .setSize(200,40)
     .setRange(5,50)
     .setValue(AVERAGE_BOX_SIZE) 
     .setFont(f)
     .setCaptionLabel("Input average box size")
     .setDecimalPrecision(1)
     .setBroadcast(true)
     ;
  
  cp5.addSlider("threashold")
     .setBroadcast(false)
     .setPosition(20,500)
     .setSize(200,40)
     .setRange(10,200)
     //.setValue(THREASHOLD)
     .setFont(f)
     .setCaptionLabel("Input threashold for imsge analysis")
     .setDecimalPrecision(1)
     .setValue(THREASHOLD)
     .setBroadcast(true)
     ;
     
  cp5.addButton("submit")
     .setBroadcast(false)
     .setPosition(20,600)
     .setSize(60,40)
     .setValue(0)
     .setBroadcast(true)
    ;

  
}

public void removeSettingsGui(){
    cp5.remove("backgroundImage");
    cp5.remove("startImageIndex");
    cp5.remove("nrOfImagesToRun");
    cp5.remove("avgBoxSize");
    cp5.remove("threashold");
    cp5.remove("submit");

}

public void threashold(int theValue) {
  println("threashold set to: " + theValue);
  THREASHOLD = theValue;

}

public void avgBoxSize(int theValue) {
  println("avgB set to: " + theValue);
  AVERAGE_BOX_SIZE = theValue;
}


public void nrOfImagesToRun(int theValue) {
  println("nr of images to run set to: " + theValue);
  NR_OR_IMAGES = theValue;
}

public void backgroundImage(int theValue) {
  println("reference image set to nr: " + theValue);
  BACKGROUND_IMAGE_INDEX = theValue;
}

public void startImageIndex(int theValue) {
  println("Start image index set to: " + theValue);
  START_IMAGE_INDEX = theValue;
}

public void submit(int theValue) {
  println("Submit button pressed: " + theValue);
  //println(int((cp5.get(Textfield.class,"backgroundImage").getText())));
  
  BACKGROUND_IMAGE_INDEX = int((cp5.get(Textfield.class,"backgroundImage").getText()));
  START_IMAGE_INDEX = int((cp5.get(Textfield.class,"startImageIndex").getText()));
  NR_OR_IMAGES = int((cp5.get(Textfield.class,"nrOfImagesToRun").getText()));
  println(BACKGROUND_IMAGE_INDEX, START_IMAGE_INDEX, NR_OR_IMAGES);
  selectFolder("Select a folder to process:", "folderSelected"); // run folder selector dialogue
  settingsGuiDone = true;
}



void setupGui(){
  
    removeSettingsGui();

  
    println("Second gui");
    
    histogramChart = cp5.addChart("dataflow")
               .setPosition(histogramX, histogramY)
               .setSize(histogramW, histogramH)
               .setRange(0, 5000)
               .setView(Chart.AREA) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.0)
               //.setColorCaptionLabel(color(40))
               ;
    
    histogramChart.addDataSet("incoming");
    
    cp5.addSlider("speedSlider")
     .setPosition(speedSliderX, speedSliderY)
     .setWidth(speedSliderW)
     .setHeight(speedSliderH)
     .setRange(1,speedMax-1)
     .setNumberOfTickMarks(speedMax)
     .setSliderMode(Slider.FLEXIBLE)
     .getCaptionLabel().hide()
     ;
      

    histogramRangeSlider = cp5.addRange("rangeController")
      .setBroadcast(false)
      .setPosition(histogramX, histogramY+histogramH+20)
      .setSize(histogramW, 20)
      .setHandleSize(10)
      .setRange(0, imagePlayer.images.length-1)
      .setRangeValues(50,300)
      // after the initialization we turn broadcast back on again
      .setBroadcast(true)
      .setColorForeground(color(150))
      .setColorBackground(color(100))
      .setDecimalPrecision(0)
    ;
    histogramRangeSlider.getCaptionLabel().hide();
    
    PImage[] imgs = {loadImage("play.png"),loadImage("pause.png")};
    cp5.addToggle("play")
     .setValue(0)
     .setPosition(imagePlayerButtonX ,imagePlayerButtonY)
     .setImages(imgs)
     .updateSize()
     ;
     
    cp5.addToggle("heatMap")
     .setValue(0)
     .setPosition(heatMapButtonX ,heatMapButtonY)
     .setSize(imgs[0].width, imgs[0].height)
     .setCaptionLabel("Heat Map")
     ;
     
    cp5.addToggle("numbers")
     .setValue(0)
     .setPosition(numbersButtonX ,numbersButtonY)
     .setSize(imgs[0].width, imgs[0].height)
     ;
   //cp5.get("heatMap").
   
}

void createHistogram(float [] data){
  println("create histogram");
  histogramChart.setData("incoming", data);
  histogramChart.setRange(0.0, histogramH);
}


void histogramSlider(int index) {
  println("histogram slider");
}


void controlEvent(ControlEvent theControlEvent) {
  println("Control event");
  if(theControlEvent.isFrom("rangeController")) {
    imagePlayer.setPlayIndexes(int(theControlEvent.getController().getArrayValue(0)), int(theControlEvent.getController().getArrayValue(1)));
    imagePlayer.resetPlayPosition();
   }
}

public void play(boolean theValue) {
  println("play");
  imagePlayer.isPlaying = theValue;

}

public void heatMap(boolean theValue) {
  println("heat map");
  displayRectangles=theValue;
  displayAnalysis(displayNumbers, displayRectangles);
    //drawHistogram();
}

public void numbers(boolean theValue) {
  println("Numbers");
  displayNumbers=theValue;
  displayAnalysis(displayNumbers, displayRectangles);;
    //drawHistogram();
}

void speedSlider(int theValue){
  println("Speed slider");
  imagePlayer.speed = speedMax-theValue;// theValue;
}

void guiUpdate(int start, int stop, int max){
  //println("Gui update");
  int startX =  (int)map(start, 0, max, histogramX, histogramW+histogramX);
  int stopX = (int)map(stop, 0, max, histogramX, histogramW+histogramX);
  stroke(255,0,0);
  fill(255, 0,0);
  triangle(startX, histogramY+histogramH, startX-5, histogramY+histogramH+10, startX+5, histogramY+histogramH+10);
  triangle(stopX, histogramY+histogramH, stopX-5, histogramY+histogramH+10, stopX+5, histogramY+histogramH+10);
  fill(255);
  text("SPEED", speedSliderX, speedSliderY-10);
  //line(stopX, histogramY+histogramH, stopX, histogramY+histogramH+10);
  stroke(0);
}
