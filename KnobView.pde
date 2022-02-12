class KnobView {

  float x, y, r, xPointer, yPointer, xZeroLabel, yZeroLabel, zeroDegree, currentDegree;
  float rStretch = 1.1;
  int strokeThickness = 3;
  int currentValue;
  String knobName;

  KnobView() {
    this.x = 0;
    this.y = 0;
    this.knobName = "";
    this.r = 30;    // SIZE
    currentDegree = 0;
    xPointer = x;
    yPointer = y-(r*rStretch);
    xZeroLabel = x;
    yZeroLabel = y-r;
    zeroDegree = 0;
  }

  KnobView(float x, float y) {
    this.x = x;
    this.y = y;
    this.knobName = "";
    this.r = 30;    // SIZE
    currentDegree = 0;
    xPointer = x;
    yPointer = y-(r*rStretch);
    xZeroLabel = x;
    yZeroLabel = y-r;
    zeroDegree = 0;
  }

  void setKnobName(String name) {
    this.knobName = name;
  }

  void setKnobXandY(float x, float y) {
    this.x = x;
    this.y = y;
    xPointer = x;
    yPointer = y-(r*rStretch);
    xZeroLabel = x;
    yZeroLabel = y-r;
  }

  void drawKnobView() {
    drawKnobCircle();
    fillArcBetweenZeroAndCurrent();
    drawZeroLine();
    drawKnobPointer();
    drawKnobText();
  }

  void drawKnobCircle() {
    fill(colors.knobBackgroundColor);
    stroke(colors.strokeColor);
    strokeWeight(strokeThickness);
    circle(x, y, r*2);
  }

  void drawKnobPointer() {
    stroke(colors.strokeColor);
    strokeWeight(strokeThickness+1);
    line(x, y, xPointer, yPointer);
  }

  void drawKnobText() {
    fill(colors.black);
    textFont(font);
    textSize(r*0.7);
    textAlign(CENTER, CENTER);
    text(knobName, x, y-(r*1.9));
  }

  void drawZeroLine() {
    stroke(colors.strokeColor);
    strokeWeight(1);
    line(x, y, xZeroLabel, yZeroLabel);
  }

  // works perfectly fine!
  void movePointer(int value) {
    currentValue = value;
    currentDegree = map(value, 0, 127, -135, 135);
    xPointer = x + sin(radians(currentDegree))*(r*rStretch);
    yPointer = y - cos(radians(currentDegree))*(r*rStretch);
  }

  void defineZeroLabelPosition(float degree) {
    zeroDegree = degree;
    xZeroLabel = x + sin(radians(degree))*r;
    yZeroLabel = y - cos(radians(degree))*r;
  }

  void fillArcBetweenZeroAndCurrent() {
    if (radians(zeroDegree-90)<radians(currentDegree-90)) {
      fill(colors.knobUnderZeroColor, 200);
      arc(x, y, 2*r, 2*r, radians(zeroDegree-90), radians(currentDegree-90)); // -90 cuz "my" 0° is at 12 o'clock and precessings 0° is at 3 o'clock
    } else {
      fill(colors.knobAboveZeroColor, 230);
      arc(x, y, 2*r, 2*r,radians(currentDegree-90), radians(zeroDegree-90));
    }
  }

  int getCurrentValue() {
    return currentValue;
  }
}
