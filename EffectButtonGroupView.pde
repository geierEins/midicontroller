class EffectButtonGroupView {

  EffectButtonView[] ebvArray;
  float x, y, ebgvHeight;
  float r = 20;
  int numOfEffectButtons = 5;

  EffectButtonGroupView(float x, float y, float ebgvHeight) {
    this.x = x;
    this.y = y;
    this.ebgvHeight = ebgvHeight;
    ebvArray = new EffectButtonView[numOfEffectButtons];
    float d = (ebgvHeight / (2*numOfEffectButtons));
    // create EffectButtonViews and put them in array
    for (int i = 1; i<=numOfEffectButtons; i++) {
      ebvArray[i-1] = new EffectButtonView(x, y+(((i*2)-numOfEffectButtons)*d), r);
    }
  }

  void drawEffectButtonGroupView() {
    for (int i = 0; i <numOfEffectButtons; i++) {
      ebvArray[i].drawEffectButtonView();
    }
  }
}
