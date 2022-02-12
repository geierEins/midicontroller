class SampleView {

  float x, y, w, h;
  Sample sampleForThisView;
  color colorForThisSampleView;

  SampleView(float x, float y, float w, Sample sampleForThisView) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.sampleForThisView = sampleForThisView;
    this.h = height/4;
    colorForThisSampleView = color(255);
  }

  void drawSampleView() {
    drawFrame();
    drawSampleTitle();
  }

  void drawFrame() {
    stroke(colorForThisSampleView);
    strokeWeight(3);
    if (sampleForThisView.sample.left.level() > 0) {  // caution: only listens to left level
      fill(colors.samplePlayColor);
    } else {
      fill(colorForThisSampleView, 40);
    }
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void drawSampleTitle() {
    textAlign(CENTER, CENTER);
    textFont(font);
    fill(colors.black);
    textSize(30);

    //rotate text
    pushMatrix();
    translate(x,y);
    rotate(radians(-90));
    text(sampleForThisView.shortName, 0, -3);
    popMatrix();
  }
}
