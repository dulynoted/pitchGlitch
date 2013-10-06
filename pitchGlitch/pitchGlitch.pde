import pitaru.sonia_v2_9.*;

Note n;
ArrayList<Note> song;
int tempo;
int lastHeight = int(random(75, 350));
int nextHeight = 0;
int lastTolerance = int(random(100, 250));
int nextTolerance = 0;
<<<<<<< HEAD
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
=======
final int MIN_SPACE = 30;
final int MIN_WIDTH =3*MIN_SPACE/2;
Sprite sprite;
int s;
int pitch;
boolean uncollided;
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b

void setup() {
  uncollided=true;
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
<<<<<<< HEAD
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
=======
  collisiondetection();
  if (uncollided) {
    play(song);
    sprite.move(pitch);
    sprite.display();
  }
  else {
    noLoop();
  }
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b
}

void generateNextHeightAndTolerance() {

  do {
    nextHeight = int(random(75, 350));
  } 
  while (nextHeight+MIN_SPACE>=lastHeight+lastTolerance);
  do {
    nextTolerance = int(random(100, 250));
  } 
  while (nextTolerance+nextHeight+MIN_SPACE<=lastHeight);
  lastHeight = nextHeight;
  lastTolerance = nextTolerance;
}

void play(ArrayList<Note> song) {
<<<<<<< HEAD
//  println("song is playing with "+song.size()+" notes.");
=======
  //println("song is playing with "+song.size()+" notes.");
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b
  background(0, 0, 0);
  for (int i=0;i<song.size();i++) {
    int conduct=song.get(i).display();
    if (conduct<0&&i==0) {
//      println("note removed");
<<<<<<< HEAD
=======
    song.get(i+1).display();
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b
      song.remove(i);
    }
    if (conduct==2&&i==(song.size()-1)) {
//      println("note added");
      generateNextHeightAndTolerance();
      song.add(compose(tempo, int(random(75, 500)), nextHeight, int(random(255)), int(random(255)), int(random(255)), nextTolerance));
      break;
    }
    if (conduct==1&&i==(song.size()-1)) {
//      println("rest added");
<<<<<<< HEAD
      song.add(rest(int(random(100))));
=======
      song.add(rest(int(random(MIN_SPACE,3*MIN_SPACE))));
      break;
    }
  }
}
void collisiondetection() {
  for (int i=0;i<song.size();i++) {
    Note note=song.get(i);
    if (i>3)
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b
      break;
   /* println("vertical bounds are ");
    println(note.verticalbounds());
    println("horizontal bounds are ");
    println(note.horizontalbounds());
    println("sprite vertical is : "+(sprite.position()+s)+" horizontal: "+sprite.location()+" s: "+s );
    */
    if (note.horizontalbounds()[0]<sprite.location()+s/2&&note.horizontalbounds()[1]>sprite.location()-s/2) {
      if (note.verticalbounds()[0]<(sprite.position()-s/2)&&note.verticalbounds()[1]>sprite.position()+s/2) {
        uncollided=true;
      }
      else {
        uncollided=false;
        break;
      }
    }
  }
}

Note rest(int w) {
  return new Note(tempo, w, 0, 0, 0, 0, height);
}

Note compose(int temp, int w, int h, int r, int g, int b, int tol) {
  return new Note(tempo, w, h, r, g, b, tol);
}

