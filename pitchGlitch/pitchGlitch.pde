Note n;
ArrayList<Note> song;
void setup(){
  size(700,500);
  n=new Note(3,100,200,20,200,100,100);
  background(0,0,0);
}
void draw(){
play(song);
}

void play(ArrayList<Note> song){
for(int i=0;i<song.size();i++){
song.get(i).display();
}
}

Note blank(int w, int y){
return new Note(300,100,200,20,200,100,100);
}


