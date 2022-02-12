class BeatLoadManager {
  Beat [] beats;
  File [] filenames;
  float defaultBpm = 120;

  void loadFilesAndCreateBeatArray() {
    // load names (directory path + file name) for each beat
    String pathToBeats = sketchPath()+"\\data\\beats";
    File directory = new File(pathToBeats);
    filenames = directory.listFiles();

    // create new Beat objects and load files
    beats = new Beat[filenames.length];
    int cul=0;
    int row=0;

    for (int i = 0; i < filenames.length; i++) {
      cul=i%8;
      //CREATE BEATS
      beats[i] = new Beat(new FilePlayer(minim.loadFileStream("\\beats\\"+filenames[i].getName())), 
        filenames[i].getName(), 
        bpm.bpvArray[cul][row], 
        tryToReadBpm(filenames[i].getName())); 

      if (cul==7)row++;
    }

    // print num of beats and beat names
    println(HLINE);
    println("number of beats: " + filenames.length);
    println(HLINE);
    for (int i = 0; i < filenames.length; i++) {
      println("- " + filenames[i].getName() + ", bpm: " + beats[i].bpm);
    }
  }

  float tryToReadBpm(String filename) {
    int indexOfDot = filename.lastIndexOf('.');
    String lastThreeChars = filename.substring((indexOfDot-3), indexOfDot);
    char[] chars = lastThreeChars.toCharArray();
    ArrayList<Integer> indexOfDigits = new ArrayList<Integer>();

    for (int i = 0; i < chars.length; i++) {
      if (Character.isDigit(chars[i])) {
        indexOfDigits.add(i);
      }
    }

    if (indexOfDigits.size()==3) {
      return Integer.parseInt(lastThreeChars);
    } else if (indexOfDigits.size()==2 && (Character.isDigit(chars[1])) && (Character.isDigit(chars[2]))) {
      return Integer.parseInt(filename.substring((indexOfDot-2), indexOfDot));
    } else if (indexOfDigits.size()==2 && (Character.isDigit(chars[1])) && (Character.isDigit(chars[2]))) {
      return Integer.parseInt(filename.substring((indexOfDot-3), (indexOfDot-1)));
    } else return 120;
  }
}
