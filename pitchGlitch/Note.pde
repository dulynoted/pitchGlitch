class Note {
  Obstacle top;
  Obstacle bottom;
  int tolerance;
  int tempo;
  int wide;
  int high;
  Note(int temp, int w, int h, int r, int g, int b, int tol) {
    tempo=temp;
    wide=w;
    high=h;
    tolerance=tol;
    bottom=new Obstacle(w, h, r, g, b, width, (height-h-1));
    top=new Obstacle(w, height-(tolerance+h), r, g, b, width, 1);
  }
  void move() {
    top.move(tempo);
    bottom.move(tempo);
  }
  int display() {
    //    println("wide: "+wide+" x: "+top.xloco()+"total: "+ (wide+top.xloco()));
    if (wide+top.xloco()>0) {
      //  print("Top ");
      top.display();
      //  print("bottom ");
      bottom.display();
            move();

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
int[] verticalbounds(){
  int[] bounds={(height-high-tolerance),(height-high)};
return bounds;
}  

int[] horizontalbounds(){
  int[] bounds={top.xloco(),(top.xloco()+wide)};
return bounds;
}
}

