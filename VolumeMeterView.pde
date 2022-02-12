class VolumeMeterView {

  float x, y, w, h, leftLevel, rightLevel, currVolL, currVolR;
  int numOfElements;

  VolumeMeterView(float x, float y, float parentChannelWidth, float parentChannelHeight) {
    this.x = x;
    this.y = y;
    this.w = parentChannelWidth*0.02;
    this.h = parentChannelHeight*0.57;
  }

  void drawVolumeMeterView(Beat currentBeat) {
    drawMeter(currentBeat);
    drawFrame();
  }

  void drawFrame() {
    noFill();
    stroke(colors.strokeColor);
    strokeWeight(3);
    rectMode(CORNERS);
    rect(x-(w*1.5), y+(h/2), x-(w*0.5), y-(h/2));
    rect(x+(w*0.5), y+(h/2), x+(w*1.5), y-(h/2));
  }

  void drawMeter(Beat currentBeat) {  // i dont want audioplayer here! 
    noStroke();
    fill(colors.green);

    currVolL = currentBeat.envFol.getLastValues()[0];
    currVolR = currentBeat.envFol.getLastValues()[1];  
    if(currVolL>1.0){currVolL=1.0;}
    if(currVolR>1.0){currVolR=1.0;}   
    leftLevel = map(currVolL, 0.0, 1.0, y+(h/2), y-(h/2));
    rightLevel = map(currVolR, 0.0, 1.0, y+(h/2), y-(h/2));

    rectMode(CORNERS);
    rect(x-(w*1.5), y+(h/2), x-(w*0.5), leftLevel);
    rect(x+(w*0.5), y+(h/2), x+(w*1.5), rightLevel);
  }
}
