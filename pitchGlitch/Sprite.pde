class Sprite{
int size;
int p;
int spacing;
Sprite(int S){
fill(255,255,255);
p=height/2;
spacing=20;
stroke(int(random(20,250)),int(random(20,250)),int(random(20,250)));
ellipse(spacing,p,S,S);
}
void move(int pitch){
p=pitch;
//p=mouseY;
}
void display(){
fill(255,255,255);
stroke(int(random(0,250)),int(random(0,250)),int(random(0,250)));
ellipse(spacing,p,S,S);
}
int position(){
return p;
}
int location(){
return spacing;
}
}
