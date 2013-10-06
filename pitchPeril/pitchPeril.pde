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
boolean screwdraw=false;
final int S=20;
final int COLOR_START=200;
final int C_S=50;
final int MIN_SPACE = 3*S/2;
final int FFT_SAMPLE_SIZE = 4096;
final int SAMPLE_RATE = 22200;
final int HEIGHT = 700;
final int WIDTH = 500;
final int MAX_FFT_INDEX = 250;
final float MOVE_ADJ = (float(MAX_FFT_INDEX*SAMPLE_RATE))/HEIGHT/FFT_SAMPLE_SIZE;
final int MAX_JUMP = 1;
int lastMove;

int findMaxFreq(float[] fft) {
  float max = 0;
  int count = 0;
  for (int i =0; i<MAX_FFT_INDEX; i++) {
    if (fft[i]>max && fft[i]>800) {
      max = fft[i];
      count = i;
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
  red=COLOR_START+int(random(-3*C_S, 3*C_S));
  green=COLOR_START+int(random(-3*C_S, 3*C_S));
  blue=COLOR_START+int(random(-3*C_S, 3*C_S));
  size(WIDTH, HEIGHT);
  sprite=new Sprite(S);
  lastMove = HEIGHT/2;
  Sonia.start(this); 
  LiveInput.start(FFT_SAMPLE_SIZE); // start the LiveInput engine, and return 256 FFT bins (frequencies)
  LiveInput.useEqualizer(true);
  song=new ArrayList<Note>();
  song.add(rest(1));
  background(40, 40, 40);
  generateNextHeightAndTolerance() ;
}
void draw() {
  //  if (!screwdraw) {
  LiveInput.getSpectrum();
  int freq = findMaxFreq(LiveInput.spectrum); 
  //    println(HEIGHT-(freq/MOVE_ADJ));  
  collisiondetection();
  //    if (uncollided) {
  //      if (keyPressed) {
  //        if (key==ENTER)
  //          screwdraw=true;
  //        key='a';
  //      }

  int nextMove = 0;
  if (freq==0) {
    nextMove = lastMove;
  }
  else {
    nextMove = HEIGHT-int((freq/MOVE_ADJ));
  }
  play(song);

  if (lastMove-nextMove<-MAX_JUMP) {
    sprite.move(lastMove+MAX_JUMP); 
    lastMove = lastMove+MAX_JUMP;
  }
  else if (lastMove-nextMove>MAX_JUMP) {
    sprite.move(lastMove-MAX_JUMP);
    lastMove = lastMove-MAX_JUMP;
  }
  else {
    sprite.move(nextMove);
    lastMove = nextMove;
  }
  sprite.display();
}
//else {
  //      screwdraw=true;
//  menu(uncollided);
//}
//  }
//  else {
//    menu(uncollided);
//  }
//}
void keyPressed() {
  if (key==ENTER) {
    screwdraw=false;
    song=new ArrayList<Note>();
    song.add(rest(1));
    background(40, 40, 40);
    uncollided=true;
    generateNextHeightAndTolerance();
  }
  if (key==' '){
  
  }
}
void menu(boolean paused) {
  //  fill(127,127,127);
  //  stroke(255,255,255);
  //  rectMode(CENTER);
  //  rect(width/2,height/2,height/4,width/2);
  //  textAlign(CENTER);


  //  println("WE'LL NOW YOU'RE HERE, BIGSHOT"+key+'#');
  if (key==' ') {
    if (paused)
      screwdraw=false;
  }
  if (key=='r') {
    println("dear god why");
    screwdraw=false;
    song=new ArrayList<Note>();
    song.add(rest(1));
    background(40, 40, 40);
    uncollided=true;
    generateNextHeightAndTolerance();
    //    redraw();
  }
}

void generateNextHeightAndTolerance() {
  nextHeight = int(random(0, min((lastHeight+lastTolerance-MIN_SPACE), (height-MIN_SPACE))));
  if (nextHeight>lastHeight) {
    nextTolerance=MIN_SPACE+int(random(height-(MIN_SPACE+lastHeight)));
  }
  else {
    nextTolerance=MIN_SPACE+(lastHeight-nextHeight)+int(random(height-(MIN_SPACE+(lastHeight-nextHeight))));
  }
  //  } 
  //  while (nextTolerance+nextHeight+MIN_SPACE<=lastHeight);
  lastHeight = nextHeight;
  lastTolerance = nextTolerance;
}

void play(ArrayList<Note> song) {

  //println("song is playing with "+song.size()+" notes.");
  background(20, 20, 20);
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
      }
      else {
        uncollided=false;
        break;
      }
    }
  }
}

Note rest(int w) {
  color[] colors= {
    color(0, 0, 0), color(0, 0, 0)
  };
  return new Note(tempo, w, 0, colors, height);
}

Note compose(int temp, int w, int h, color[] c, int tol) {
  return new Note(tempo, w, h, c, tol);
}

color[] vibrant() {
  do {
    red=red+int(random(-C_S, C_S));
    blue=blue+int(random(-C_S, C_S));
    green=green+int(random(-C_S, C_S));
  }
  while (red-blue<2*C_S&&blue-green<2*C_S);
  color[] colors= {
    color(red, blue, green), color(red-C_S/2, blue-C_S/2, green-C_S/2)
  };
  return colors;
}

