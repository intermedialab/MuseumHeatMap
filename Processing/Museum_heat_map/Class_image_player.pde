class ImagePlayer{
  
  boolean isPlaying;
  int speed;  // frames between image change
  int currIndex;
  int startIndex;
  int stopIndex;
  PImage [] images;
  int x, y, w, h;
  
  
  ImagePlayer(int xPos, int yPos, int width_, int height_){
    speed = 8;
    currIndex = 0;
    isPlaying = false;
    x = xPos; 
    y = yPos;
    w = width_;
    h = height_;
    
  }
  
  void loadImages(PImage [] img){
    images = img;
    setPlayIndexes(0, images.length-1);
  }
  
  boolean display(){
    if (images != null ){
      if (images[currIndex] != null) {
        image(images[currIndex], x, y, w, h);
      }
      else {
        image(iS.reference, x, y, w, h);
      }
      return true;
    }
    return false;
    
  }
  
  void update(){
    if (isPlaying){
      if (frameCount % speed == 0) {
        currIndex++;
        if (currIndex > stopIndex) {
          currIndex = startIndex;
          isPlaying = false;
          cp5.get("play").setValue(0);
        }
      }
    }
  }
  
  void setPlayIndexes(int start, int stop){
    startIndex = start;
    stopIndex = stop;
  }
  
  void resetPlayPosition(){
    currIndex = startIndex;
  }
  
  
}
