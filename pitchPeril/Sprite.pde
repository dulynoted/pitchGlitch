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
  try {
    Thread.sleep(9);//important
    int[] temp = getColorTime();
    fill(temp[0], temp[1], temp[2]);
  } catch (InterruptedException e) {
    e.printStackTrace();
  }
//rotate(PI/3.0);
stroke(int(random(0,250)),int(random(0,250)),int(random(0,250)));
ellipse(spacing,p,S,S);
}
int position(){
return p;
}
int location(){
return spacing;
}
            

int[] getColorTime() {
        float time = ((float) (millis() % 10000)) / 10000;
        int switchTime = (int) (time*1000);
        int[] colors = new int[3];
        if (switchTime < 167) {
            time /=167;
            time *=1000;
            colors[0]=255;
            colors[1]=0;
            colors[2]= int(255 - 255 * time);
            return colors;
        }
        if (switchTime < 333) {
            time -=0.167;
            time /=167;
            time *=1000;
            colors[0]=255;
            colors[1]=int(255 * time);
            colors[2]=0;
            return colors;
        }
        if(switchTime <500){
            time -=0.333;
            time /=167;
            time *=1000;
            colors[0]= int(255 - 255 * time);
            colors[1]= 255;
            colors[2]=0;
            return colors;
        }
        if (switchTime < 667) {
            time -=0.500;
            time /=167;
            time *=1000;
            colors[0]=0;
            colors[1]=255;
            colors[2]=int(255 * time);
            return colors;
        }
        if (switchTime < 833) {
            time -=0.667;
            time /=167;
            time *=1000;
            colors[0] = 0;
            colors[1] = int(255 - 255*time);
            colors[2] = 255;
            return colors;
        }
        if(switchTime <1001){
            if(time==1)
                time-=0.01;
            time -=0.833;
            time /=167;
            time *=1000;
            
            colors[0]=int(255 * time);
            colors[1]=0;
            colors[2]=255;
            return colors;
        }
        System.err.println("Should Not Reach This");
        return colors;
        
    }

}
