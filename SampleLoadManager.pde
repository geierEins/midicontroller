class SampleLoadManager {
  
  int numOfSamples;

  Sample [] loadFilesAndCreateSampleArray() {
    // load names (directory path + file name) for each beat
    String pathToSamples = sketchPath()+"\\data\\samples";
    File directory = new File(pathToSamples);
    File [] filenames = directory.listFiles();
    numOfSamples = filenames.length;

    // create new Beat objects and load files
    Sample [] samples = new Sample[numOfSamples];
    for (int i = 0; i < numOfSamples; i++) {
      samples[i] = new Sample(minim.loadSample("\\samples\\"+filenames[i].getName(), 512), 
                              filenames[i].getName());
    }

    // print num of beats and beat names
    println(HLINE);
    println("number of samples: " + numOfSamples);
    println(HLINE);
    for (File path : filenames) {
      println("- " + path.getName());
    }
    return samples;
  }
}
