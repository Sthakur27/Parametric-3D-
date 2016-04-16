FloatList xvals=new FloatList();
FloatList yvals=new FloatList();
FloatList zvals=new FloatList();
boolean line=true;
boolean axis=true;
int rchoose=1;
boolean scaleon=true;
int timer=1;
int timer2=1;
float xscale=1;
float yscale=1;
float zscale=1;
float autoscale=1;
int typing=0;
int mode=2;   //0:disk 1: shell 2:line
float maxval=0;
float ry=0;
float rx=0;
float rz=0;
int funcnum=0;
int totalP=11;
boolean twoexps=true;
double volume=0;
boolean paused=false;
//String exp=("4.64-(x^2^(1/3))");
//x  y z expressions
String exp="t";
String exp2="sin(t)";
String exp3="t";
String tempexp="";
void setup(){
      size(500, 450,P3D);
      //parse.test();
      calculate();
      //surface.setResizable(true);
}

void draw(){
    background(255,255,255);
    fill(0);
    text("x=("+exp+")",10,20,0);
    text("y=("+exp2+")",10,40,0);
    text("z=("+exp3+")",10,60,0);
    translate(width/2,height/2,0);
    rotateY(timer2*PI/180);
    rotateY(ry);
    if(!paused){
       timer2++;}
    if(timer2>360){timer2=0;}
    rotate();
    stroke(0,0,0);   
    //draw axis
    if(axis){
        textSize(15); fill(0);
        
        //x axis
        line(-150,0,0,150,0,0);
        //line(-width/2,0,0,width/2,0,0);
        text("X",105,0,0);
        
        //y
        line(0,-150,0,0,150,0);
        //line(0,-height/2,0,0,height/2,0);        
        text("Z",0,-105,0);
        
        //z
        line(0,0,-150,0,0,150);
        //line(0,0,-height/2,0,0,height/2); 
        
        text("Y",0,0,105);
    }
    
    stroke(#aa03eb);
    //stroke(#eb03b8);
    
    //draw function
    for (int i=0;i<xvals.size()-1;i++){
        drawFlat(i);
    }
    if(timer<360){timer+=3;}
}

void calculate(){
  xvals.clear(); yvals.clear(); zvals.clear();
  parse.parainterp(exp,exp2,exp3,-10,10,0.3);
  for (int i=0;i<parse.xreturnlist.size();i++){
       //print(parse.thetaorx.get(i).floatValue()); print("    "); println(parse.rory.get(i).floatValue());
       xvals.append(10*parse.xreturnlist.get(i).floatValue());
       yvals.append(-10*parse.yreturnlist.get(i).floatValue());
       zvals.append(10*parse.zreturnlist.get(i).floatValue());
   }
  rescale(xvals); rescale(yvals); rescale(zvals);
  //volume=abs((float)integrate(-10,10));
}

void rescale(FloatList list){
  maxval=0;
  autoscale=1;
  for (int i=0;i<list.size();i++){
         if (abs(list.get(i))>maxval){
            maxval=abs(list.get(i));
         }
  }
  if(maxval==0){autoscale=1;}
  else{
    autoscale=100/maxval;}
  if (autoscale==0){autoscale=200; }
  for (int i=0;i<list.size();i++){
     list.mult(i,autoscale);
  }
}

/*float fn(float i,int a){
   String tempeval;
   if(a==0){
   tempeval=exp.replaceAll("t",Float.toString(i));}
   else if(a==1){tempeval=exp2.replaceAll("t",Float.toString(i));}
   return(-scale*(float)parse.interp(tempeval));
}*/


void drawFlat(int i){
  line(xvals.get(i),zvals.get(i),yvals.get(i),xvals.get(i+1),zvals.get(i+1),yvals.get(i+1));
  
}



void rotate(){
  rotateX(rx);
  rotateZ(rz);
}


void keyPressed(){
   if(key=='f'||key=='F'){
     if(rchoose==3){ if(mode==1){rchoose=2;} else{rchoose=1;}}
     else{
     rchoose=3;}
   }
   
   if((key=='a'||key=='A')&& typing==0){   if(axis){axis=false;} else{axis=true;}   }
   if(key=='d' && typing==0){
     if(mode!=0){mode=0; 
      rx=0; rz=0;  
      timer=0;  rchoose=1; //volume=integrate(-10,10);
    }
   }
   if(key=='l' && typing==0){
     mode=2;     
     //volume=integrate(-10,10);
   }
   if(key=='g'){if(scaleon){scaleon=false;}else{scaleon=true;}}
   if(key=='s' && typing==0){
     if(mode!=1){mode=1;   
     rx=0; rz=0;  
      timer=0; rchoose=2; 
     //volume=integrate(-10,10);
     }
   }
   if(key=='r'||key=='R'){
      rx=0; rz=0;  timer2=0; 
   }
   if(key=='p'||key=='P'){
     if(!paused){paused=true;}else{   paused=false;}
   }
   if(keyCode==LEFT){
      ry-=5*PI/180;
   }
   if(keyCode==RIGHT){
      ry+=5*PI/180;
   }
   if(keyCode==ENTER){
       if(typing==0){typing++; exp=""; 
       } 
       else if(typing==1){
       exp2=""; typing++;}
       else if(typing==2){
       exp3=""; typing++;}
       else if(typing==3){ 
          typing=0; rx=0; rz=0; timer2=0; mode=2;  calculate();}
   }
   if(typing!=0){
      if(keyCode!=SHIFT && keyCode!=ENTER && keyCode!=BACKSPACE && keyCode!=DELETE){
         if(typing==1){
                       exp=exp+Character.toString(key);}
         if(typing==2){exp2=exp2+Character.toString(key);}
         if(typing==3){exp3=exp3+Character.toString(key);}
      //print(key);
      }
   }
   if((keyCode==DELETE||keyCode==BACKSPACE)){
      if(typing==1){
      exp=exp.substring(0,exp.length()-1);}
      if (typing ==2){
        exp2=exp2.substring(0,exp2.length()-1);
      }
   }
}
void mouseClicked(){
  if(!paused){paused=true;}else{   paused=false;}
}
void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  if(rchoose==2){
    rx-=5*e*PI/180;
    
  }
  if(rchoose==1){
    rz-=5*e*PI/180;    
  }
  if(rchoose==3){
        
  }
}