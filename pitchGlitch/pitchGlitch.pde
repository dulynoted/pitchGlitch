Note n;
ArrayList<Note> song;
int tempo;
void setup() {
  tempo=3;
  size(700, 500);
  song=new ArrayList<Note>();
  song.add(new Note(tempo, 100, 200, 20, 200, 100, 20));
  background(0, 0, 0);
}
void draw() {
  play(song);
}

void play(ArrayList<Note> song) {
  
 for (int i=0;i<song.size();i++) {
   int conduct=song.get(i).display();}
 /*   int conduct=song.get(i).display();
    if (conduct<0&&i==0) {
      song.remove(i);}
      if(conduct>0&&i==(song.size()-1)){
      song.add(blank(int(random(200))));
      song.add(compose(tempo, int(random(400)), int(random(400)), int(random(255)), int(random(255)), int(random(255)), int(random(250))));
    }
  }*/
}

Note blank(int w) {
  return new Note(tempo, w, 0, 0, 0, 0, height);
}

Note compose(int temp, int w, int h, int r, int g, int b, int tol) {
  return new Note(tempo, w, h, r, g, b, tol);
}

