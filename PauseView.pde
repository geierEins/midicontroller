class PauseView extends PpsView {

  PauseView(float x, float y) {
    super(x, y);
  }

  void drawSymbol() {
    fill(colors.strokeColor);
    noStroke();
    rect(x-(w/6), y, (w/5), (h/2));
    rect(x+(w/6), y, (w/5), (h/2));
  }

  // two rects
  void drawPauseView() {
    drawShape(colors.pauseViewIsActiveColor);
    drawSymbol();
  }
}
