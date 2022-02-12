class MuteView extends PpsView {

  MuteView(float x, float y) {
    super(x, y);
  }

  void drawMuteSymbol() {
    textAlign(CENTER, CENTER);
    textFont(font);
    textSize(25);
    fill(colors.strokeColor);
    text("MUTE", x, y);
  }

  void drawMuteView() {
    drawShape(colors.muteViewIsActiveColor);
    drawMuteSymbol();
  }
}
