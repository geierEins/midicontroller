import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import themidibus.*;
import java.io.File;
import java.util.Optional;

//sound and midi related
Minim minim;
MidiBus midibus;
AudioOutput out;
AudioInput in;

//managers
BeatLoadManager blm;
BeatPadManager bpm;
SampleLoadManager slm;
SampleViewManager svm;
PlayerActionManager pam;

ArrayList<Integer> values;

//view related
Colors colors;
float channelX, channelY, channelWidth, channelHeight;
PFont font;
ChannelView cv;

// for tests
AudioPlayer testbeat, testbeat2;
AudioPlayer testsample;

String HLINE = "------------------------------";

void setup() {
  // view related
  size(1200, 1000);
  font = createFont("fonts\\andalemo.ttf", 50);
  colors = new Colors();
  
  // Beat class needs these 4 following variables !!
  channelX = width/2;
  channelY = 440;
  channelWidth = width*0.99;
  channelHeight = 450;
  

  // sound and midi related
  MidiBus.list();
  midibus = new MidiBus(this, "APC Key 25", "APC Key 25");
  minim = new Minim(this);
  out = minim.getLineOut();

  // bpm has to be there before blm, because beatsPads will get allocated to Beat Objects when creating Beat objects through beatLoadManager
  bpm = new BeatPadManager();

  // load beats from folder into blm
  blm = new BeatLoadManager();
  blm.loadFilesAndCreateBeatArray();

  values = new ArrayList<Integer>();
  for (int n = 4; n >= 0; n--) {
    for (int i = 0; i < 8; i++) {
      values.add(n*8 + i);
    }
  }

  // load samples from folder into slm
  slm = new SampleLoadManager();
  svm = new SampleViewManager(slm.loadFilesAndCreateSampleArray());
  pam = new PlayerActionManager();

  cv = new ChannelView(channelX, channelY);

  cv.setCurrentBeat(blm.beats[0]);
}

void draw() {
  background(#AAA7A7);
  cv.drawChannel();
  svm.drawSampleViews();
  bpm.drawBeatPadViews();
}

//-------------------------------------------------CALLBACKS
void noteOn(int channel, int pitch, int velocity) {
  println("-------- Note On ---------");
  println("channel: " + channel);
  println("pitch: " + pitch);
  println("velocity: " + velocity);

  //mapping between each beat in beats[]-array and midi pads
  if (pitch >= 0 && pitch <= 39) {
    for (int i = 0; i < 40; i++) {
      if (pitch == values.get(i)) {
        cv.setCurrentBeat(blm.beats[i]);
        break;
      }
    }
  }

  switch(pitch) {
    //  //first row----------------------
    //case 32 :
    //  cv.setCurrentBeat(blm.beats[0]);
    //  break;
    //case 33 :
    //  cv.setCurrentBeat(blm.beats[1]);
    //  break;
    //case 34 :
    //  cv.setCurrentBeat(blm.beats[2]);
    //  break;
    //case 35:
    //  cv.setCurrentBeat(blm.beats[3]);
    //  break;
    //case 36:
    //  cv.setCurrentBeat(blm.beats[4]);
    //  break;
    //case 37:
    //  cv.setCurrentBeat(blm.beats[5]);
    //  break;
    //case 38:
    //  cv.setCurrentBeat(blm.beats[6]);
    //  break;
    //case 39:
    //  cv.setCurrentBeat(blm.beats[7]);
    //  break;
    //  // second row -------------------
    //case 24:
    //  cv.setCurrentBeat(blm.beats[8]);
    //  break;
    //case 25:
    //  cv.setCurrentBeat(blm.beats[9]);
    //  break;
    //case 26:
    //  cv.setCurrentBeat(blm.beats[10]);
    //  break;
    //case 27:
    //  cv.setCurrentBeat(blm.beats[11]);
    //  break;
    //case 28:
    //  cv.setCurrentBeat(blm.beats[12]);
    //  break;
    //case 29:
    //  cv.setCurrentBeat(blm.beats[13]);
    //  break;
    //case 30:
    //  cv.setCurrentBeat(blm.beats[14]);
    //  break;
    //case 31:
    //  cv.setCurrentBeat(blm.beats[15]);
    //  break;

    // PLAY - PAUSE - STOP - MUTE
  case 64 :
    pam.playBeat();
    break;
  case 65:
    pam.pauseBeat();
    break;
  case 66:
    pam.stopBeat();
    break; 
  case 67:
    pam.muteOrUnmute();
    break; 

    // EFFECT BUTTONS (first int reps the position in cv.ebgv.ebvArray)
  case 82:
    pam.delayRepEffectSwitch(0);
    break;
  case 83:
    pam.delayRepEffectSwitch(1);
    break;
  case 84:
    pam.delayRepEffectSwitch(2);
    break; 
  case 85:
    pam.delayRepEffectSwitch(3);
    break;
  case 86:
    pam.delayRepEffectSwitch(4);
    break;


    // SAMPLES
  case 48 :
    pam.playSample(svm.sampleViews[0].sampleForThisView.sample);
    break;
  case 49:
    pam.playSample(svm.sampleViews[1].sampleForThisView.sample);
    break;
  case 50:
    pam.playSample(svm.sampleViews[2].sampleForThisView.sample);
    break;
  case 51 :
    pam.playSample(svm.sampleViews[3].sampleForThisView.sample);
    break;
  case 52:
    pam.playSample(svm.sampleViews[4].sampleForThisView.sample);
    break;
  case 53:
    pam.playSample(svm.sampleViews[5].sampleForThisView.sample);
    break;
  case 54 :
    pam.playSample(svm.sampleViews[6].sampleForThisView.sample);
    break;
  case 55:
    pam.playSample(svm.sampleViews[7].sampleForThisView.sample);
    break;
  case 56:
    pam.playSample(svm.sampleViews[8].sampleForThisView.sample);
    break;
  case 57 :
    pam.playSample(svm.sampleViews[9].sampleForThisView.sample);
    break;
  case 58:
    pam.playSample(svm.sampleViews[10].sampleForThisView.sample);
    break;
  case 59:
    pam.playSample(svm.sampleViews[11].sampleForThisView.sample);
    break;
  }
}

void controllerChange(int channel, int number, int value) {
  //println("channel: " + channel);
  //println("number: " + number);  
  //println("value: " + value);

  // KNOBS mapping between knobViews[] and midi knobs
  switch(number) {
  case 48:  // FILTER
    pam.lowPassFilter(cv.currentBeat.kvm.knobViews[0], value);
    break;
  case 49:  // FILTER MID
    pam.filterMid(cv.currentBeat.kvm.knobViews[1], value);
    break;
  case 50:  // -----
    cv.currentBeat.kvm.knobViews[2].movePointer(value);
    break;
  case 51 :  // VOLUME
    pam.setBeatVolume(cv.currentBeat.kvm.knobViews[3], value);
    break;
  case 52:  // DELAY AMP
    pam.delayAmp(cv.currentBeat.kvm.knobViews[4], value);
    break;
  case 53:
    //pam.delayTime(cv.currentBeat.kvm.knobViews[5], value);
    break;
  case 54 :
    //pam.flangerDepth(cv.currentBeat.kvm.knobViews[6], value);
    break;
  case 55:  // PITCH
    pam.changePitch(cv.currentBeat.kvm.knobViews[7], value);
    break;
  }
}
