class BeatPadView {

  float x, y, w, h;
  boolean isActive, isPlaying, isPaused, isMuted;

  BeatPadView(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    isActive = false;
  }

  void drawBeatPadView() {
    if (isPlaying) {
      fill(colors.playViewIsActiveColor);
    } else if (isPaused) {
      fill(colors.pauseViewIsActiveColor);
    } else {
      fill(colors.knobBackgroundColor);
    }
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);

    if (isMuted) {
      fill(colors.muteViewIsActiveColor, 200);
      noStroke();
      triangle(x+(w/2), y-(h/2), x+(w/2), y+(h/2), x-(w/2), y+(h/2));
    }
    if (isActive) {
      stroke(colors.white);
      strokeWeight(5);
      fill(colors.white, 100);
      rect(x, y, w, h);
    } else {
      strokeWeight(4);
      stroke(colors.strokeColor, 80);
    }
    // frame no fill
    noFill();
    rect(x, y, w, h);
  }
}
