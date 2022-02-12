class PpsView {

  boolean isActive;

  //geometry
  float x, y, w, h;
  int symbolOffset = 20;

  //appearance
  int strokeThickness = 3;

  PpsView(float x, float y) {
    this.x = x;
    this.y = y;
    this.w = 70;
    this.h = 70;
    isActive = false;
  }

  void drawShape(color colIsActive) {
    if (isActive) {
      fill(colIsActive);
    }else{
      fill(colors.ppsViewIsNotActiveColor);
    }
    stroke(colors.strokeColor);
    strokeWeight(strokeThickness);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
