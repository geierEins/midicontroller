class TimeLineView {

  float x, y, w, h, currXpos;

  TimeLineView(float x, float y, float channelWidth, float channelHeight) {
    this.x = x;
    this.y = y-(channelHeight*0.22);
    this.w = channelWidth*0.95;
    this.h = channelHeight*0.02;
  }

  void drawTimeLineView(FilePlayer beat) {
    drawBackgroundRect();
    drawFillRectAndMarker(beat);
  }

  void drawBackgroundRect() {
    noStroke();
    fill(colors.white, 160);
    rectMode(CORNERS);
    rect(x-(w/2), y+(h/2), x+(w/2), y-(h/2));
  }

  void drawFillRectAndMarker(FilePlayer beat) {
    noStroke();
    fill(colors.samplePlayColor, 230);
    currXpos = map(beat.position(), 0, beat.length(), x-(w/2), x+(w/2)); 
    rectMode(CORNERS);
    rect(x-(w/2), y+(h/2), currXpos, y-(h/2));
    
    circle(currXpos, y, h*2);
  }
}
