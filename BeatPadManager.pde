class BeatPadManager {

  float beatPadWidth, beatPadHeight;
  int numOfRows, numOfCuls;
  BeatPadView[][] bpvArray;

  BeatPadManager() {
    numOfCuls = 8;
    numOfRows = 5;
    beatPadWidth = (width/numOfCuls)*0.9;
    beatPadHeight = 30;
    bpvArray = new BeatPadView[numOfCuls][numOfRows];

    for (int i=0; i<numOfCuls; i++) {
      for (int j = 0; j<numOfRows; j++) {
        bpvArray[i][j] = new BeatPadView( (((2*i)+1)*0.5)*(width/numOfCuls), (((2*j)+1)*0.5)*beatPadHeight*1.4, beatPadWidth, beatPadHeight );
      }
    }
  }

  void drawBeatPadViews() {

    for (int i=0; i<numOfCuls; i++) {
      for (int j = 0; j<numOfRows; j++) {
        bpvArray[i][j].drawBeatPadView();
      }
    }
  }
}
