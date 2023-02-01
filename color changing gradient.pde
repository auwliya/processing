import gifAnimation.*;
GifMaker gifExport;

int Y_AXIS = 1;
int X_AXIS = 2;
color c1, c2;
float changingcolorX, changingcolorY;

void setup() {
  size(500, 500);
  smooth();
  frameRate(24);
  gifExport = new GifMaker(this, "randomized lines.gif");
  gifExport.setRepeat(0); // makes the animation go on until it is stopped by the code
  gifExport.setDelay(1000/12);  //12fps
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
  noFill();
  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y + h; i++) {
      float inter = map(i, y, y+h, 0, 1); //calculates the increment
      color c = lerpColor(c1, c2, inter); // finds the color between the two chosen colors for a specific increment
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
}

void draw() {
  c1 = color(240, changingcolorX, changingcolorY); //changes the color that is used in the gradient
  c2 = color(changingcolorX, changingcolorY, 240);  
  changingcolorX = map(mouseX, 0, width, 0, 255); //scales the mouseX input from 0, 500 to 0, 255
  changingcolorY = map(mouseY, 0, height, 0, 255); //scales the mouseY input from 0, 500 to 0, 255
  
  setGradient(0, 0, width, height, c1, c2, Y_AXIS); //creates the gradient
  
  gifExport.addFrame();
  if (frameCount == 120) gifExport.finish();  // stops the gif at 120 frames 
  // the gif can also be stopped by closing the sketch
}
