class PlayView extends PpsView {
  
  PlayView(float x, float y) {
    super(x, y);
  }

  void drawSymbol() {
    fill(colors.strokeColor);
    noStroke();
    triangle(x-(w/4), y-(h/4), x+(w/4), y, x-(w/4), y+(h/4));
  }
  
  // triangle
  void drawPlayView(){
    drawShape(colors.playViewIsActiveColor);
    drawSymbol();
  }
}
