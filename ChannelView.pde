class ChannelView {

  // all views in channelView
  DisplayView displayView;
  KnobViewManager kvm;
  VolumeMeterView vmm;
  TimeLineView tlv;
  EffectButtonGroupView ebgv;

  // this beat
  Beat currentBeat;

  float x, y;
  int frameStrokeWeight = 5;

  ChannelView(float x, float y) {
    this.x = x;
    this.y = y;

    // view related

    displayView = new DisplayView(x, y, channelWidth, channelHeight);
    vmm = new VolumeMeterView(x+(channelWidth*0.08), y+(channelHeight*0.13), channelWidth, channelHeight);
    tlv = new TimeLineView(x, y, channelWidth, channelHeight);
    ebgv = new EffectButtonGroupView(x*0.98, y*1.08, channelHeight*0.6);

    // set first beat of Beat[] as currentBeat by default
    currentBeat = blm.beats[0];
  }

  void drawChannel() {
    drawChannelBackground();                      // background
    currentBeat.playView.drawPlayView();          // play view
    currentBeat.pauseView.drawPauseView();        // pause view
    currentBeat.stopView.drawStopView();          // stop view
    currentBeat.muteView.drawMuteView();          // mute view
    currentBeat.kvm.drawKnobViews();              // all knobs
    
    vmm.drawVolumeMeterView(currentBeat);         // volume meter
    displayView.drawDisplayView(currentBeat);     // display with title
    tlv.drawTimeLineView(currentBeat.beatFpl);    // timeline view
    currentBeat.ebgv.drawEffectButtonGroupView(); // effect buttons

    drawFrame();                                  // frame around channel view
  }

  void drawChannelBackground() {
    noStroke();
    fill(colors.channelBackgroundColor);
    rectMode(CENTER);
    rect(x, y, channelWidth, channelHeight);
  }

  void drawFrame() {
    noFill();
    strokeWeight(frameStrokeWeight);
    stroke(colors.strokeColor, 220);
    rectMode(CENTER);
    rect(x, y, channelWidth, channelHeight);
  }

  void setCurrentBeat(Beat beat) {
    //set previous beat inactive
    if (!currentBeat.equals(beat)) {
      currentBeat.beatPadView.isActive = false;
    }
    //set new beat as currentbeat and set it active
    currentBeat = beat;
    currentBeat.beatPadView.isActive=true;
  }
}
