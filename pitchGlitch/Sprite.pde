class Sprite{
int size;
int p;
int spacing;
Sprite(int s){
fill(255,255,255);
p=height/2;
spacing=20;
stroke(int(random(20,250)),int(random(20,250)),int(random(20,250)));
ellipse(spacing,p,s,s);
}
void move(int pitch){
<<<<<<< HEAD
position=pitch;
=======
p=mouseY;
>>>>>>> 0bb086e1817952486a60f6f9c3af138a0d0c873b
}
void display(){
fill(255,255,255);
//rotate(PI/3.0);
stroke(int(random(0,250)),int(random(0,250)),int(random(0,250)));
ellipse(spacing,p,s,s);
}
int position(){
return p;
}
int location(){
return spacing;
}
}
