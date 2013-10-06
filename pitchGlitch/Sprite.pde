class Sprite{
int size;
int position;
int spacing;
Sprite(int s){
fill(255,255,255);
position=height/2;
spacing=20;
stroke(int(random(0,250)),int(random(0,250)),int(random(0,250)));
quad(spacing,position-s/2,spacing,position+s/2,s+spacing,position-s/2,s+spacing,position+s/2);
}
void move(int pitch){

}
void display(){
fill(255,255,255);
//rotate(PI/3.0);
stroke(int(random(0,250)),int(random(0,250)),int(random(0,250)));
quad(spacing,position-s/2,spacing,position+s/2,s+spacing,position+s/2,s+spacing,position-s/2);
}

}
