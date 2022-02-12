class Sample{
  String shortName;
  String fullName;
  AudioSample sample;
  
  Sample(AudioSample sample, String name){
    this.sample = sample;
    this.fullName = name;//.substring(0, name.get().lastIndexOf('.'));
    if(fullName.length()>13){    // num of chars until cut
      shortName = fullName.substring(0,12);  
    }else{
      shortName = fullName;
    }
  }
}
