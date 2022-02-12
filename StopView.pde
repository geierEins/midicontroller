class StopView extends PpsView {

  StopView(float x, float y) {
    super(x, y);
    isActive = true;
  }

  void drawSymbol() {
    fill(colors.strokeColor);
    noStroke();
    rectMode(CENTER);
    rect(x, y, w/2, h/2);
  }

  // square
  void drawStopView() {
    drawShape(colors.stopViewIsActiveColor);
    drawSymbol();
  }
}
