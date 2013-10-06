class Note{
Obstacle top;
Obstacle bottom;
int tolerance;
int tempo;
int wide;
Note(int temp, int w,int h,int r, int g, int b, int tol){
  tempo=temp;
  wide=w;
  tolerance=tol;
  bottom=new Obstacle(w,h,r,g,b, width-w,(height-h-1));
  top=new Obstacle(w,height-(tolerance+h),r,g,b,width-w,1);
}
void move(){
top.move(tempo);
bottom.move(tempo);
}
void display(){
  if(wide+top.xloco()>0){
  move();
    background(0,0,0);

//  print("Top ");
  top.display();
//  print("bottom ");
  bottom.display();
}
}


}
