class Beat {

  // fields
  String name, displayname;
  float bpm;
  float originalTickRate = 1.15;
  float mappedTickRate = 1.0;    // WHY SO EVER??? at 1 beats are pitched and slowed down (1.09 for my beats)
  float mappedFilterFreq = 12000;
  float currentDelayTime;  // intital delay time 
  float currentDelayAmp = 0;  //initial delay feedback
  float currentVolume = 0;
  float steptime, waitTime, reloadStartTime;
  float currentBitRes, currentSampleRate;
  float currentFlangerDelay, currentFlangerDepth;
  boolean isMuted;

  // minim related
  FilePlayer beatFpl;
  Delay delay;
  Gain gain;
  TickRate tickrateObj;
  MoogFilter moogFilter;
  EnvelopeFollower envFol;
  Sink sink;
  BitCrush bitCrush;
  Flanger flanger;

  // view related
  BeatPadView beatPadView;
  KnobViewManager kvm;
  MuteView muteView;
  PlayView playView;
  PauseView pauseView;
  StopView stopView;
  EffectButtonGroupView ebgv;

  // FilePlayer based
  Beat(FilePlayer beatFpl, String name, BeatPadView bpv, float bpm) {
    //BPM
    this.bpm = bpm;

    // NAME
    this.name = name.substring(0, name.lastIndexOf('.'));  // get rid of file type ending
    // check if displayname has to get trimmed
    if (this.name.length()>22) {
      this.displayname = this.name.substring(0, 22) + "...";
    } else {
      this.displayname = this.name;
    }
    println("name: " + name);

    // FILEPLAYER
    this.beatFpl = beatFpl;

    // VIEWS
    this.beatPadView = bpv;
    this.kvm = new KnobViewManager(channelX, channelY, channelWidth, channelHeight);
    this.muteView = new MuteView(channelX-(channelWidth*0.21), channelY+(channelHeight*0.33));
    this.playView = new PlayView(channelX-(channelWidth*0.45), channelY+(channelHeight*0.33));
    this.pauseView = new PauseView(channelX-(channelWidth*0.37), channelY+(channelHeight*0.33));
    this.stopView = new StopView(channelX-(channelWidth*0.29), channelY+(channelHeight*0.33));
    this.ebgv = new EffectButtonGroupView(channelX*0.98, channelY*1.08, channelHeight*0.6);

    // states
    this.currentDelayTime = (bpm/60*8);
    isMuted = false;

    //effect related
    //gain
    this.gain = new Gain(currentVolume);

    //delay
    this.delay = new Delay(1.5, 0.5, true, true);
    delay.setDelAmp(currentDelayAmp);
    currentDelayTime = (0.63829);
    delay.setDelTime(currentDelayTime);


    //pitch
    this.tickrateObj = new TickRate(originalTickRate);
    tickrateObj.setInterpolation(true); // for smoother pitching

    //filter
    this.moogFilter = new MoogFilter(12000, 0.5 );

    //envelope follower
    envFol = new EnvelopeFollower( 0, 0.1, 1024);
    sink = new Sink();
    beatFpl.patch(envFol).patch(sink).patch(out);

    //-------patch everything-------
    beatFpl.patch(gain).patch(tickrateObj).patch(delay).patch(moogFilter)/*.patch(flanger)*/.patch(out);
  }

  //---------------------------------------------------------------------------------
  // WORKS FINE
  void applyGainViaKnobValue(float value) {
    currentVolume = map(value, 0, 127, -6, 6); //between -6 and +6 dB
    gain.setValue(currentVolume);
  }
  //---------------------------------------------------------------------------------
  // WORKS FINE
  void applyGainViaDbValue(float value) {
    currentVolume=value;
    gain.setValue(currentVolume);
  }
  //---------------------------------------------------------------------------------
  // WORKS FINE
  void muteBeat() {
    isMuted = true;
    muteView.isActive=true;
    beatPadView.isMuted=true;
    gain.setValue(-100);
  }
  //---------------------------------------------------------------------------------
  // WORKS FINE
  void unMuteBeat() {
    isMuted = false;
    muteView.isActive = false;
    beatPadView.isMuted=false;
    gain.setValue(currentVolume);
  }
  //---------------------------------------------------------------------------------
  void applyPitchChange(int value) {
    mappedTickRate = map(value, 0, 127, originalTickRate-0.6, originalTickRate+0.6);
    if (value>60 && value<68) {             // certain area in which user jumps to default value
      mappedTickRate = originalTickRate;    // original pitch
    }
    tickrateObj.value.setLastValue(mappedTickRate);
  }
  //---------------------------------------------------------------------------------
  // needs mapping adjustment --> play with parameters
  void applyLowPassFilter(int value) {
    mappedFilterFreq = map(value, 0, 127, 12000, 20);
    moogFilter.frequency.setLastValue(mappedFilterFreq);
  }
  //---------------------------------------------------------------------------------
  void applyDelayAmp(int value) {
    currentDelayTime = 60/ bpm;
    currentDelayAmp = map(value, 0, 127, 0.0f, 1.0f); 
    delay.setDelAmp(currentDelayAmp);
  }
  //---------------------------------------------------------------------------------
  void applyDelayTime(int value) {
    currentDelayTime = map(value, 0, 127, 0.0f, 1.0);   
    delay.setDelTime(currentDelayTime);
    println("currentDelayTime: " + currentDelayTime);
  }
  //---------------------------------------------------------------------------------
  void applyBitCrushBitRes(int value) {
    currentBitRes = map(value, 0, 127, 1, 16);
    bitCrush.setBitRes(round(currentBitRes));
    //println(round(currentBitRes));
  }
  //---------------------------------------------------------------------------------
  void applyBitCrushSampleRate(int value) {
    currentSampleRate = map(value, 0, 127, 1, 44100);
    bitCrush.setSampleRate(round(currentSampleRate));
    //println(round(currentSampleRate));
  }
  //---------------------------------------------------------------------------------
  void applyFlangerDelay(int value) {
    currentFlangerDelay = map(value, 0, 127, 0.0, 5);
    flanger.delay.setLastValue(currentFlangerDelay);    
    //println("currentFlangerDelay: " + currentFlangerDelay);
  }
  //---------------------------------------------------------------------------------
  void applyFlangerDepth(int value) {
    currentFlangerDepth = map(value, 0, 127, 0.0, 5);
    flanger.depth.setLastValue(currentFlangerDepth);
    //println("currentFlangerDepth: " + currentFlangerDepth);
  }
  //---------------------------------------------------------------------------------
  void delayRepEffectOn(int buttonNumber) {
    delay.setDelAmp(1);
    
    //map buttonNumber to steptime
    steptime = 1/(pow(2, buttonNumber));
    currentDelayTime = (60/bpm)*steptime;
    waitTime = currentDelayTime;
    if (millis()>reloadStartTime + waitTime) {
      delay.setDelTime(currentDelayTime);
    }
    ebgv.ebvArray[buttonNumber].isActive = true;
    muteBeat();
  }
  //---------------------------------------------------------------------------------
  void delayRepEffectOff(int buttonNumber) {
    delay.setDelAmp(currentDelayAmp);
    delay.setDelTime(currentDelayTime);
    ebgv.ebvArray[buttonNumber].isActive = false;
    unMuteBeat();
  }
}
