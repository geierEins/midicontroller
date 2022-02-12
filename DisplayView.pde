class DisplayView {

  int songlaenge = 220;  float x, y, w, h, textY, mappedTimeLineWidth;

  DisplayView(float parentX, float parentY, float parentChannelWidth, float parentChannelHeight) {
    this.w = parentChannelWidth * 0.98;
    this.h = parentChannelHeight * 0.3;
    this.x = parentX;
    this.y = parentY-(parentChannelHeight*0.33);
    this.textY = parentY-(parentChannelHeight*0.38);
  }

  void drawDisplayView(Beat currBeat) {
    drawFrame();
    drawTitle(currBeat);
    drawBpm(currBeat);
  }

  void drawFrame() {
    rectMode(CENTER);
    noStroke();
    fill(colors.black, 100);
    rect(x, y, w, h);
  }

  void drawTitle(Beat currBeat) {
    textAlign(LEFT, CENTER);
    fill(colors.white, 220);
    textSize(h/3);
    textFont(font);
    text(currBeat.displayname, x*0.05, textY);
  }

  void drawBpm(Beat currBeat) {
    textAlign(RIGHT, CENTER);
    fill(colors.white, 220);
    textSize(h/3);
    textFont(font);
    text("| " + currBeat.bpm + " BPM", x*1.9, textY);
  }
}
