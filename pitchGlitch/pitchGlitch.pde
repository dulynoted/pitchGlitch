import pitaru.sonia_v2_9.*;

Note n;
ArrayList<Note> song;
int tempo;
int lastHeight = int(random(75, 350));
int nextHeight = 0;
int lastTolerance = int(random(100, 250));
int nextTolerance = 0;
final int MIN_SPACE = 20;
final int FFT_SAMPLE_SIZE = 4096;
final int SAMPLE_RATE = 22200;
final int HEIGHT = 700;
final int WIDTH = 500;
final int MAX_FFT_INDEX = 250;
final float MOVE_ADJ = (float(MAX_FFT_INDEX*SAMPLE_RATE))/HEIGHT/FFT_SAMPLE_SIZE;
final int MAX_JUMP = 50;
Sprite sprite;
int s;
int pitch;
int lastMove;

int findMaxFreq(float[] fft){
  float max = 0;
  int count = 0;
  for(int i =0; i<MAX_FFT_INDEX; i++){
    if(fft[i]>max){
     max = fft[i];
    count = i; 
    }
  }
  return (count*SAMPLE_RATE)/FFT_SAMPLE_SIZE;
}

void setup() {
  tempo=4;
  s=20;
  lastMove = HEIGHT/2;
  size(700, 500);
  sprite=new Sprite(s);
  Sonia.start(this); 
  LiveInput.start(FFT_SAMPLE_SIZE); // start the LiveInput engine, and return 256 FFT bins (frequencies)
  LiveInput.useEqualizer(true);
  song=new ArrayList<Note>();
      song.add(compose(tempo, int(random(75, 200)), int(random(75, 350)), int(random(255)), int(random(255)), int(random(255)), int(random(100, 250))));
  background(0, 0, 0);
}
void draw() {
  LiveInput.getSpectrum();
  int freq = findMaxFreq(LiveInput.spectrum); 
  println(HEIGHT-(freq/MOVE_ADJ));
  play(song);
  int nextMove = HEIGHT-int((freq/MOVE_ADJ)); 
  if(lastMove-nextMove<-MAX_JUMP){
   sprite.move(lastMove+MAX_JUMP); 
  }else if(lastMove-nextMove>MAX_JUMP){
    sprite.move(lastMove-MAX_JUMP);
  }else
  sprite.move(nextMove);
  sprite.display();
}

void generateNextHeightAndTolerance(){
  do {
    nextHeight = int(random(75, 350));
  } while(nextHeight+MIN_SPACE>=lastHeight+lastTolerance);
  do {
    nextTolerance = int(random(100,250));
  } while(nextTolerance+nextHeight+MIN_SPACE<=lastHeight);
  lastHeight = nextHeight;
  lastTolerance = nextTolerance;
}

void play(ArrayList<Note> song) {
//  println("song is playing with "+song.size()+" notes.");
  background(0, 0, 0);
  for (int i=0;i<song.size();i++) {
    int conduct=song.get(i).display();
    if (conduct<0&&i==0) {
//      println("note removed");
      song.remove(i);
    }
    if (conduct==2&&i==(song.size()-1)) {
//      println("note added");
      generateNextHeightAndTolerance();
      song.add(compose(tempo, int(random(75, 200)), nextHeight, int(random(255)), int(random(255)), int(random(255)), nextTolerance));
      break;
    }
    if (conduct==1&&i==(song.size()-1)) {
//      println("rest added");
      song.add(rest(int(random(100))));
      break;
    }
  }
}

Note rest(int w) {
  return new Note(tempo, w, 0, 0, 0, 0, height);
}

Note compose(int temp, int w, int h, int r, int g, int b, int tol) {
  return new Note(tempo, w, h, r, g, b, tol);
}

