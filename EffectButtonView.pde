class EffectButtonView {

  float x, y, r;
  int strokeweight = 3;
  boolean isActive;

  EffectButtonView(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.isActive = false;
  }

  void drawEffectButtonView() {

    stroke(colors.strokeColor, 240);
    strokeWeight(strokeweight);
    if (isActive) {
      fill(colors.stopViewIsActiveColor);
    } else {
      fill(colors.ppsViewIsNotActiveColor);
    }
    circle(x, y, 2*r);
  }
}
