package processing.test.pitchglitch;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pitchGlitch extends PApplet {

Note n;
ArrayList<Note> song;
int tempo;
Sprite sprite;
int s;
int pitch;
public void setup() {
  tempo=4;
  s=20;
 
  sprite=new Sprite(s);
  song=new ArrayList<Note>();
      song.add(compose(tempo, PApplet.parseInt(random(75, 200)), PApplet.parseInt(random(75, 350)), PApplet.parseInt(random(255)), PApplet.parseInt(random(255)), PApplet.parseInt(random(255)), PApplet.parseInt(random(100, 250))));
  background(0, 0, 0);
}
public void draw() {
  play(song);
 // sprite.move(pitch);
  sprite.display();
}

public void play(ArrayList<Note> song) {
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
      song.add(compose(tempo, PApplet.parseInt(random(75, 200)), PApplet.parseInt(random(75, 350)), PApplet.parseInt(random(255)), PApplet.parseInt(random(255)), PApplet.parseInt(random(255)), PApplet.parseInt(random(100, 250))));
      break;
    }
    if (conduct==1&&i==(song.size()-1)) {
      println("rest added");
      song.add(rest(PApplet.parseInt(random(100))));
      break;
    }
  }
}

public Note rest(int w) {
  return new Note(tempo, w, 0, 0, 0, 0, height);
}

public Note compose(int temp, int w, int h, int r, int g, int b, int tol) {
  return new Note(tempo, w, h, r, g, b, tol);
}

class Note {
  Obstacle top;
  Obstacle bottom;
  int tolerance;
  int tempo;
  int wide;
  Note(int temp, int w, int h, int r, int g, int b, int tol) {
    tempo=temp;
    wide=w;
    tolerance=tol;
    bottom=new Obstacle(w, h, r, g, b, width, (height-h-1));
    top=new Obstacle(w, height-(tolerance+h), r, g, b, width, 1);
  }
  public void move() {
    top.move(tempo);
    bottom.move(tempo);
  }
  public int display() {
    //    println("wide: "+wide+" x: "+top.xloco()+"total: "+ (wide+top.xloco()));
    if (wide+top.xloco()>0) {
      move();
      //  print("Top ");
      top.display();
      //  print("bottom ");
      bottom.display();
      if (wide+top.xloco()>width) {
        return 0;
      }
      else {
       // println("is rest: "+bottom.isRest());
        if (bottom.isRest()) {
          return 2;
        }
        else {
          return 1;
        }
      }
    }
    return -1;
  }
}

class Obstacle{
int wide;
int high;
int x;
int y;
int i;
int c;
Obstacle(int w,int h,int r,int g,int b,int initialx,int initialy){
i=PApplet.parseInt(random(-50,50));
c=color(r+i,g+i,b+i);

wide=w;
high=h;
x=initialx;
y=initialy;
}
public void move(int t){
x=x-t;
}
public void display(){
  fill(c);
  stroke(255,255,255);
  rect(x,y,wide,high);
 // println("x:"+x+" y:"+y);
}
public int xloco(){
return x;
}
public boolean isRest(){
if(high==0)
return true;
else
return false;}
}
class Sprite{
int size;
int position;
int spacing;
Sprite(int s){
fill(255,255,255);
position=height/2;
spacing=20;
stroke(PApplet.parseInt(random(0,250)),PApplet.parseInt(random(0,250)),PApplet.parseInt(random(0,250)));
quad(spacing,position-s/2,spacing,position+s/2,s+spacing,position-s/2,s+spacing,position+s/2);
}
public void move(int pitch){

}
public void display(){
fill(255,255,255);
//rotate(PI/3.0);
stroke(PApplet.parseInt(random(0,250)),PApplet.parseInt(random(0,250)),PApplet.parseInt(random(0,250)));
quad(spacing,position-s/2,spacing,position+s/2,s+spacing,position+s/2,s+spacing,position-s/2);
}

}
/*void setup(){
size(displayHeight,displayWidth);}

void draw(){
  if (mousePressed) {
  float j=random(20);
int i=int(j);
rectMode(CENTER);
fill(200+i,i,10*i);
stroke(15*i,100+i,i);
rect(mouseX,mouseY,50,50);
}
}
*/

  public int sketchWidth() { return 700; }
  public int sketchHeight() { return 500; }
}
