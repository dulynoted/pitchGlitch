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
  void move() {
    top.move(tempo);
    bottom.move(tempo);
  }
  int display() {
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

