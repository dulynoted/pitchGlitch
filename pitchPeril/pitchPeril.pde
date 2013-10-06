import pitaru.sonia_v2_9.*;


Note n;
ArrayList<Note> song;
int tempo;
int lastHeight = int(random(75, 350));
int nextHeight = 0;
int lastTolerance = int(random(100, 250));
int nextTolerance = 0;
int red;
int blue;
int green;
final int S=20;
final int COLOR_START=200;
final int C_S=50;
final int MIN_SPACE = 4*S;
final int FFT_SAMPLE_SIZE = 4096;
final int SAMPLE_RATE = 22200;
final int HEIGHT = 700;
final int WIDTH = 1000;
final int MAX_FFT_INDEX = 90;
final float MOVE_ADJ = (float(MAX_FFT_INDEX*SAMPLE_RATE))/HEIGHT/FFT_SAMPLE_SIZE;
final int MAX_JUMP = 3;
final int MIN_FFT_INDEX = 0; // 45;
final int BREAK_VOLUME = 1000;
final int SENSITIVITY = 500;
int lastMove;
boolean breakIt = false;
boolean blocking = false;

int findMaxFreq(float[] fft){
  float max = SENSITIVITY;
  int count = 0;
  for(int i =MIN_FFT_INDEX; i<MAX_FFT_INDEX; i++){
     if(fft[i]>BREAK_VOLUME && blocking){
        println("breakIt!");
        breakIt = true;
      }else{
    if(fft[i]>max){
     
        max = fft[i];
        count = i; 
      }
    }
  }
  return (count*SAMPLE_RATE)/FFT_SAMPLE_SIZE;
}
//final int MIN_WIDTH =3*MIN_SPACE/2;
Sprite sprite;
int pitch;
boolean uncollided;

void setup() {
  uncollided=true;
  tempo=2;
  red=COLOR_START+int(random(-3*C_S,3*C_S));
  green=COLOR_START+int(random(-3*C_S,3*C_S));
  blue=COLOR_START+int(random(-3*C_S,3*C_S));
  size(WIDTH, HEIGHT);
  sprite=new Sprite(S);
  lastMove = HEIGHT/2;
  Sonia.start(this); 
  LiveInput.start(FFT_SAMPLE_SIZE); // start the LiveInput engine, and return 256 FFT bins (frequencies)
  LiveInput.useEqualizer(true);
  song=new ArrayList<Note>();
  song.add(rest(1));
  background(0, 0, 0);
  generateNextHeightAndTolerance() ;
}
void draw() {
 LiveInput.getSpectrum();
 int freq = findMaxFreq(LiveInput.spectrum); 
 println(freq);  
 collisiondetection();
 if (uncollided) {
 int nextMove = 0;
 if(freq==0){
   nextMove = lastMove; 
 }else{
   nextMove = HEIGHT-int((freq/MOVE_ADJ)); 
 }
 play(song);
if(lastMove-nextMove<-MAX_JUMP){
  sprite.move(lastMove+MAX_JUMP); 
  lastMove = lastMove+MAX_JUMP;
}else if(lastMove-nextMove>MAX_JUMP){
   sprite.move(lastMove-MAX_JUMP);
   lastMove = lastMove-MAX_JUMP;
 }else{
  sprite.move(nextMove);
   lastMove = nextMove;
 }
   sprite.display();
 }
 else {
   noLoop();
 }
}

void generateNextHeightAndTolerance() {
    nextHeight = int(random(150, min((lastHeight+lastTolerance-MIN_SPACE),(height-MIN_SPACE-200))));
    if(nextHeight>lastHeight){
      nextTolerance=MIN_SPACE+int(random(height-(MIN_SPACE+lastHeight)));
    }
    else{
    nextTolerance=MIN_SPACE+(lastHeight-nextHeight)+int(random(height-(MIN_SPACE+(lastHeight-nextHeight))));
    }
//  } 
//  while (nextTolerance+nextHeight+MIN_SPACE<=lastHeight);
  lastHeight = nextHeight;
  lastTolerance = nextTolerance;
}

void play(ArrayList<Note> song) {

  //println("song is playing with "+song.size()+" notes.");
  background(0, 0, 0);
  for (int i=0;i<song.size();i++) {
    int conduct=song.get(i).display();
    if (conduct<0&&i==0) {

      //      println("note removed");
      song.get(i+1).display();
      song.remove(i);
    }
    if (conduct==2&&i==(song.size()-1)) {
      //      println("note added");
      //      int c=int( pow(-1,random(1,2));

      song.add(compose(tempo, int(random(75, 300)), nextHeight, vibrant(), nextTolerance));
           generateNextHeightAndTolerance();

      break;
    }
    if (conduct==1&&i==(song.size()-1)) {
      //      println("rest added");
      song.add(rest(1));
      break;
    }
  }
}
void collisiondetection() {
  for (int i=0;i<song.size();i++) {
    Note note=song.get(i);
    /* println("vertical bounds are ");
     println(note.verticalbounds());
     println("horizontal bounds are ");
     println(note.horizontalbounds());
     println("sprite vertical is : "+(sprite.position()+s)+" horizontal: "+sprite.location()+" s: "+s );
     */
    if (note.horizontalbounds()[0]<sprite.location()+S/2&&note.horizontalbounds()[1]>sprite.location()-S/2) {
      if (note.verticalbounds()[0]<(sprite.position()-S/2)&&note.verticalbounds()[1]>sprite.position()+S/2) {
        uncollided=true;
        breakIt = false;
        blocking = false;
      }
      else {
        if(breakIt && blocking){
          uncollided = true;
        }else{
        uncollided=false;
        break;
        }
      }
    }
  }
}

Note rest(int w) {
   color[] colors={color(0,0,0),color(0,0,0)};
  return new Note(tempo, w, 0,colors, height);
}

Note compose(int temp, int w, int h, color[] c, int tol) {
//  if(random(0,10)>8){
//    blocking = true;
//    println("BLOCKING");
//   return new Note(temp, w, HEIGHT/2, c, 0); 
//  }
  return new Note(tempo, w, h, c, tol);
}

color[] vibrant(){
      do{
      red=red+int(random(-C_S, C_S));
      blue=blue+int(random(-C_S, C_S));
      green=green+int(random(-C_S, C_S));}
      while(red-blue<2*C_S&&blue-green<2*C_S);
     color[] colors={color(red,blue,green),color(red-C_S/2,blue-C_S/2,green-C_S/2)};
      return colors;
}

