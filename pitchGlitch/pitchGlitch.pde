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
final int MIN_SPACE = 3*S/2;
final int MIN_WIDTH =3*MIN_SPACE/2;
Sprite sprite;
int pitch;
boolean uncollided;

void setup() {
  uncollided=true;
  tempo=4;
  red=COLOR_START+int(random(-3*C_S,3*C_S));
  green=COLOR_START+int(random(-3*C_S,3*C_S));
  blue=COLOR_START+int(random(-3*C_S,3*C_S));
  size(700, 500);
  sprite=new Sprite(S);
  song=new ArrayList<Note>();
  song.add(rest(1));
  background(0, 0, 0);
  generateNextHeightAndTolerance() ;
}
void draw() {
  collisiondetection();
  if (uncollided) {
    play(song);
    sprite.move(pitch);
    sprite.display();
  }
  else {
    sprite.display();
    noLoop();
  }
}

void generateNextHeightAndTolerance() {
    nextHeight = int(random(0, min((lastHeight+lastTolerance-MIN_SPACE),(height-MIN_SPACE))));
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

      //      song.add(rest(int(random(MIN_SPACE,3*MIN_SPACE))));
      break;
    }
  }
}
void collisiondetection() {
  for (int i=0;i<song.size();i++) {
    Note note=song.get(i);
    if (i>3)
      break;
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
   color[] colors={color(0,0,0),color(0,0,0)};
  return new Note(tempo, w, 0,colors, height);
}

Note compose(int temp, int w, int h, color[] c, int tol) {
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

