Note n;
ArrayList<Note> song;
int tempo;
int lastHeight = int(random(75, 350));
int nextHeight = 0;
int lastTolerance = int(random(100, 250));
int nextTolerance = 0;
final int MIN_SPACE = 20;
Sprite sprite;
int s;
int pitch;

void setup() {
  tempo=4;
  s=20;
  size(700, 500);
  sprite=new Sprite(s);
  song=new ArrayList<Note>();
      song.add(compose(tempo, int(random(75, 200)), int(random(75, 350)), int(random(255)), int(random(255)), int(random(255)), int(random(100, 250))));
  background(0, 0, 0);
}
void draw() {
  play(song);
 // sprite.move(pitch);
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
  println("song is playing with "+song.size()+" notes.");
  background(0, 0, 0);
  for (int i=0;i<song.size();i++) {
    int conduct=song.get(i).display();
    if (conduct<0&&i==0) {
      println("note removed");
      song.remove(i);
    }
    if (conduct==2&&i==(song.size()-1)) {
      println("note added");
      generateNextHeightAndTolerance();
      song.add(compose(tempo, int(random(75, 200)), nextHeight, int(random(255)), int(random(255)), int(random(255)), nextTolerance));
      break;
    }
    if (conduct==1&&i==(song.size()-1)) {
      println("rest added");
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

