class ImageSet{
  PImage reference;
  PImage [] imageSet;
  String [] imageSetStrings;
  float [] imageSetActivityLevel;
  int [][] heatMap;
  int threashold = 40;
  int averageBox = 10;
  int maxMapBoxValue;
  
  //public ImageSet(PImage ref, PImage[] set, int threasholdVal, int averageBoxVal){
  public ImageSet(PImage ref, String[] setStrings, int threasholdVal, int averageBoxVal){
    reference = ref;
    //imageSet = set;
    imageSet = new PImage [setStrings.length];

    imageSetStrings = setStrings;
    imageSetActivityLevel = new float [imageSet.length];
    //imageSetActivityLevel = new float [imageSet.length];
    heatMap = new int [ref.width][ref.height];
    threashold = threasholdVal;
    averageBox = averageBoxVal;
    
  }  
  
  void traverseImageSet(){ // traverse image in squared fields
  
    int currImgInSet;
    int refImg;
    
    // eventually imageSet[0] should be changed so it traverses the whole image set
    boolean imageHasActivity;
    PImage temp;
    for (int i = 0; i < imageSet.length; i++){
      println("Analyzing image: " + i + " / " + NR_OR_IMAGES);
      imageHasActivity = false;
      temp = loadImage(imageStrings[i]);
      imageSet[i] = null;
      //for (int x = 0; x <= imageSet[i].width - averageBox; x += averageBox){
        //for (int y = 0; y <= imageSet[i].height - averageBox; y += averageBox){
      for (int x = 0; x <= temp.width - averageBox; x += averageBox){
        for (int y = 0; y <= temp.height - averageBox; y += averageBox){
          currImgInSet = getAverageColor(temp.get(x, y, averageBox, averageBox)); // calculate and save average value for current field position
          refImg = getAverageColor(reference.get(x, y, averageBox, averageBox)); // calculate and save average value for current field position
    
          if (abs(currImgInSet - refImg) > threashold){ // detect changes
            heatMap[x][y]++; // this need to set all pixels in the averageBox area
            imageSetActivityLevel[i]++;
            if (heatMap[x][y] > maxMapBoxValue) maxMapBoxValue = heatMap[x][y]; // new max map value is found and stores
            imageHasActivity = true;
          }
        
        }
      }
      if (imageHasActivity){
        imageSet[i] = temp;
        //println("Image stored on index: " + i);
      }
    }
  }
  
  
  // calculates average value in a PImage photo
  int getAverageColor(PImage photo){
    int sum = 0;
    int count = 0;
    for (int x = 0; x < photo.width; x++){
      for (int y = 0; y < photo.height; y++){
        sum += red(color(photo.get(x,y)));
        count++;
      }
    }
    return (int) sum/count;
  }
    
}
