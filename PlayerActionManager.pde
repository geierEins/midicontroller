class PlayerActionManager {

  float mappedTickRateValue;
  //----------------------------------------------
  void playBeat() {
    if (cv.currentBeat.beatFpl.isPlaying()) {
      cv.currentBeat.beatFpl.rewind();
    } else {
      cv.currentBeat.beatFpl.play();
    }
    cv.currentBeat.playView.isActive = true;
    cv.currentBeat.pauseView.isActive = false;
    cv.currentBeat.stopView.isActive = false;
    cv.currentBeat.beatPadView.isPlaying=true;
    cv.currentBeat.beatPadView.isPaused=false;
  }
  //----------------------------------------------
  void pauseBeat() {
    if (cv.currentBeat.beatFpl.isPlaying()) {
      cv.currentBeat.beatFpl.pause();
    }
    cv.currentBeat.playView.isActive = false;
    cv.currentBeat.pauseView.isActive = true;
    cv.currentBeat.stopView.isActive = false;
    cv.currentBeat.beatPadView.isPlaying=false;
    cv.currentBeat.beatPadView.isPaused=true;
  }
  //----------------------------------------------
  void stopBeat() {
    cv.currentBeat.beatFpl.rewind();
    cv.currentBeat.beatFpl.pause();
    cv.currentBeat.playView.isActive = false;
    cv.currentBeat.pauseView.isActive = false;
    cv.currentBeat.stopView.isActive = true;
    cv.currentBeat.beatPadView.isPlaying=false;
    cv.currentBeat.beatPadView.isPaused=false;
  }
  //----------------------------------------------
  void playSample(AudioSample sample) {
    sample.trigger();
  }
  //----------------------------------------------
  void muteOrUnmute() {
    if (cv.currentBeat.isMuted==false) {
      cv.currentBeat.muteBeat();  //mute
    } else {
      cv.currentBeat.unMuteBeat();  //unmute
    }
  }
  //----------------------------------------------
  void delayRepEffectSwitch(int ebvPosInArray) {

    // set each delay effect false but this one (ebvPosInArray)
    for (int j = 0; j < cv.currentBeat.ebgv.ebvArray.length; j++) {
      if (j!=ebvPosInArray) {
        cv.currentBeat.ebgv.ebvArray[j].isActive = false;
      }
    }

    if (cv.currentBeat.ebgv.ebvArray[ebvPosInArray].isActive==false) {
      cv.currentBeat.delayRepEffectOn(ebvPosInArray);  // delay step effect ON
    } else {
      cv.currentBeat.delayRepEffectOff(ebvPosInArray);  // delay step effect OFF
    }
  }
  //----------------------------------------------
  void setBeatVolume(KnobView knob, int knobvalue) {
    knob.movePointer(knobvalue);
    cv.currentBeat.applyGainViaKnobValue(knobvalue);
  }
  //----------------------------------------------
  void bitCrushBitRes(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyBitCrushBitRes(value);
  }
  //----------------------------------------------
  void bitCrushSampleRate(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyBitCrushSampleRate(value);
  }
    //----------------------------------------------
  void flangerDelay(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyFlangerDelay(value);
  }
  //----------------------------------------------
  void flangerDepth(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyFlangerDepth(value);
  }
  //----------------------------------------------
  void filterMid(KnobView knob, int value) {
    knob.movePointer(value);
  }
  //----------------------------------------------
  void lowPassFilter(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyLowPassFilter(value);
  }
  //----------------------------------------------
  void delayTime(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyDelayTime(value);
  }
  //----------------------------------------------
  void delayAmp(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyDelayAmp(value);
  }
  //----------------------------------------------
  //works quite alright
  void changePitch(KnobView knob, int value) {
    knob.movePointer(value);
    cv.currentBeat.applyPitchChange(value);
  }
}
