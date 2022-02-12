class SampleViewManager {

  SampleView[] sampleViews;
  float sampleViewWidth;
  int numOfSampleViews = 25;

  SampleViewManager(Sample[] samples) {
    sampleViewWidth = (width/numOfSampleViews)*0.90;
    sampleViews = new SampleView[numOfSampleViews];

    for (int i = 0; i<slm.numOfSamples; i++) {
      sampleViews[i] = new SampleView(width/numOfSampleViews*((2*i)+1.2)*0.5, height*0.8, sampleViewWidth, samples[i]); // Höhe der SampleViews

      if (isBlackKey(i)){
        sampleViews[i].colorForThisSampleView=color(0);
      }
    }
  }

  void drawSampleViews() {
    for (int i = 0; i<slm.numOfSamples; i++) {
      sampleViews[i].drawSampleView();
    }
  }

  boolean isBlackKey(int i) {
    if (i==1 || i==3 || i==6 || i==8 || i==10 ||
      i==13 || i==15 || i==18 || i==20 || i==22) {
      return true;
    } else {
      return false;
    }
  }
}
