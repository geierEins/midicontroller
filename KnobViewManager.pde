class KnobViewManager {

  KnobView[] knobViews;
  float x, y, channelWidth, channelHeight;
  int numOfKnobs = 8;

  KnobViewManager(float x, float y, float channelWidth, float channelHeight) {
    this.x = x;
    this.y = y;
    this.channelWidth = channelWidth;
    this.channelHeight = channelHeight;

    // contains each single knobView
    knobViews = new KnobView[numOfKnobs];
    // create knobViews and put them into array
    for (int n = 0; n < numOfKnobs; n++) {
      knobViews[n] = new KnobView();
    }
    
    // set knobView position via setKnobXandY
    // upper row
    for (int m = 0; m < numOfKnobs/2; m++) {
      knobViews[m].setKnobXandY(x+(channelWidth*(0.18+(m*0.09))), y+(channelHeight*0.0));
    }
    // below row
    for (int o = 0; o < numOfKnobs/2; o++) {
      knobViews[o+4].setKnobXandY(x+(channelWidth*(0.18+(o*0.09))), y+(channelHeight*0.3));
    }

    // give knobs their names individually
    knobViews[0].setKnobName("FILTER");
    knobViews[1].setKnobName("---");
    knobViews[2].setKnobName("---");
    knobViews[3].setKnobName("VOL");
    knobViews[4].setKnobName("DELAY");
    knobViews[5].setKnobName("FL DEL");
    knobViews[6].setKnobName("FL DEP");
    knobViews[7].setKnobName("PITCH");

    // set knobPointer position for particular knobs
    knobViews[0].movePointer(0); // FILTER (LOWPASS)
    knobViews[0].defineZeroLabelPosition(-135);
    
    knobViews[4].movePointer(0); // DELAY
    knobViews[4].defineZeroLabelPosition(-135);
  }

  void drawKnobViews() {
    for (int i = 0; i < numOfKnobs; i++) {
      knobViews[i].drawKnobView();
    }
    drawGroupFrames();
  }

  void drawGroupFrames() {
    strokeWeight(1);
    stroke(colors.strokeColor);
    noFill();
    rectMode(CENTER);
    // rect around filter knobs
    //rect(knobView7.x, knobView7.y-(channelHeight*0.025), channelWidth*0.26, channelHeight*0.27);
    // rect around effect knobs
    //rect(knobView3.x, knobView3.y-(channelHeight*0.025), channelWidth*0.26, channelHeight*0.27);
    // rect around vol/pan knobs
    //rect(knobView5.x, ((knobView1.y+knobView5.y)/2)-channelHeight*0.025, channelWidth*0.08, channelHeight*0.57);
  }
}
