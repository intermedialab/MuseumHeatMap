/* 
STRUCTURING THE IMAGES RIGHT
    Use the OS folder selector dialogue that open when the program runs to specify the folder containing the images
    Image filenames in the datafolder should consist of three elements: Name, Index and Type
    - Name: A name in text that is similar for all images - e.g. IMG or PIC or something else
    - Index: After the name there must be a number that is sequential and unique for each image
    - Type: The file type in text with the "." in front e.g. .JPG or .PNG
CHOOSING A BACKGROUND IMAGE
    The background image must be an image without any people on it. 
*/

// SETUP VARIABLES FOR THE HEAT MAP: Change these to fit the data set used

String FOLDER_PATH;                        // Name of subfolder inside the programs sketch folder eg "Data2/"
String FILE_NAME =             "pic_test";      // Name part of the image filesnames
int START_IMAGE_INDEX =        0;          // The image index to start the heat map from
String FILE_TYPE =             ".jpg";     // Image type
int NR_OR_IMAGES =             500;        // The nr of images the program need to read in from the starting image
int BACKGROUND_IMAGE_INDEX =   0;         // Index of the background image
int THREASHOLD =               70;         // Threashold for how big a change from the background is regarded movement in a average box area
int AVERAGE_BOX_SIZE =         10;         // size of the average box areas




// Other program variables
float SCALE_FACTOR = 1.5;
ImagePlayer imagePlayer = new ImagePlayer(540, 20, int(320*SCALE_FACTOR), int(240*SCALE_FACTOR));
boolean runAnalysisFlag = false;
boolean displayNumbers = true;
boolean displayRectangles = true;
PImage background; // reference image
//PImage images [];// = new PImage [NR_OR_IMAGES]; // array with all images to examine
String imageStrings [];// = new String [NR_OR_IMAGES];
ImageSet iS; // Image set object
boolean settingsGuiDone = false;



// SETUP: runs once when the programs starts
void setup(){

  size(1060, 700);
  textSize(14);
  println("AvgBox in setup", AVERAGE_BOX_SIZE);
  setupSettingsGui();
  
  //selectFolder("Select a folder to process:", "folderSelected"); // run folder selector dialogue
  
  //imagePlayer.loadImages(images);
  //setupGui();

}

// DRAW runs over and over aprox 60 times pr. second, or as fast as the operating system allows/can handle
void draw(){
  background(0);
  if(!settingsGuiDone){
    fill(255);
    textSize(50);
    text("Settings for image analysis", 20, 70);
  }
  
  else {
    //println("test 1");
    if (iS != null && imagePlayer != null) {
      //background(0);
      guiUpdate(imagePlayer.startIndex, imagePlayer.stopIndex, iS.imageSet.length);
      displayAnalysis(displayNumbers, displayRectangles);
      imagePlayer.display();
    }
    
    if (runAnalysisFlag){
      runAnalysis();
      runAnalysisFlag = false;
      //background(255);
      
      //imagePlayer.loadImages(images);
      imagePlayer.loadImages(iS.imageSet);
      setupGui();
      
      displayAnalysis(displayNumbers, displayRectangles);
      createHistogram(iS.imageSetActivityLevel);
      
  
    }
    if (imagePlayer.isPlaying){
      imagePlayer.update();
    }
  }
  
}

void runAnalysis(){
  println("Running analysis");
  println(NR_OR_IMAGES);
  // load in the background image
  background = loadImage(FOLDER_PATH+FILE_NAME+BACKGROUND_IMAGE_INDEX+FILE_TYPE);
  
  // Load in all images in the image set
  imageStrings = new String [NR_OR_IMAGES];
  for (int i = 0; i < NR_OR_IMAGES; i++){ 
    imageStrings[i] = FOLDER_PATH+FILE_NAME+(i+START_IMAGE_INDEX)+FILE_TYPE;
    //images[i] = loadImage(FOLDER_PATH+FILE_NAME+(i+START_IMAGE_INDEX)+FILE_TYPE);
  }
  
  
  // Create the image set
  println("AvgBox in run", AVERAGE_BOX_SIZE);

  iS = new ImageSet(background, imageStrings, THREASHOLD, AVERAGE_BOX_SIZE);
    println("AvgBox in run", iS.averageBox);

  //iS = new ImageSet(background, images, THREASHOLD, AVERAGE_BOX_SIZE);
  // Create the heat map
  iS.traverseImageSet();
  //println("MaxMapValue: " + iS.maxMapBoxValue);
  

}

void displayAnalysis(boolean numbers, boolean rectangles){
  
  //println("Displaying analysis");
  textSize(9);
  // Draw the background image on screen
  image(background, 40, 20, background.width*SCALE_FACTOR, background.height*SCALE_FACTOR);
  // Draw the heat map info in screen
  if (numbers || rectangles){
    for (int x = 0; x < background.width; x++){
      for (int y = 0; y < background.height; y++){
        if (iS.heatMap[x][y] > 0){
          if (rectangles){
            fill(255, 0, 0, map(iS.heatMap[x][y], 0, iS.maxMapBoxValue, 0, 255)); //fill(255, 0, 0, constrain(iS.heatMap[x][y], 0, 255));
            rect(x*SCALE_FACTOR+40,y*SCALE_FACTOR+20,iS.averageBox*SCALE_FACTOR, iS.averageBox*SCALE_FACTOR);
            println(iS.averageBox);
          }
          if (numbers){
            fill(0,255,0);
            text(iS.heatMap[x][y], x*SCALE_FACTOR+40,y*SCALE_FACTOR+10+20);
          }
        }
      }
    }
  }
  
  
}






// function for called when a folder is selected in OS folder dialogue
void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
    FOLDER_PATH = selection.getAbsolutePath()+"/";
    runAnalysisFlag = true;
    
  }
}

void keyReleased(){
  /*
  if (key=='1'){
    displayNumbers=!displayNumbers;
    displayAnalysis(displayNumbers, displayRectangles);
    //drawHistogram();
  }
  else if (key=='2'){
    displayRectangles=!displayRectangles;
    displayAnalysis(displayNumbers, displayRectangles);
    //drawHistogram();
  }
  */
}
