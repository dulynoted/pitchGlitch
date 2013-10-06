class Obstacle{
int wide;
int high;
int x;
int y;
int i;
color c;
Obstacle(int w,int h,int r,int g,int b,int initialx,int initialy){
i=int(random(-50,50));
c=color(r+i,g+i,b+i);

wide=w;
high=h;
x=initialx;
y=initialy;
}
void move(int t){
x=x-t;
}
void display(){
  fill(c);
  stroke(255,255,255);
  rect(x,y,wide,high);
 // println("x:"+x+" y:"+y);
}
int xloco(){
return x;
}
}
