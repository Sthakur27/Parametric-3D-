import java.lang.Math;
public class pObj{
    double num=0;
    String oper="";
    String paren="";
    String sciop="";
    int mode=0;  //0:numbers  1: operators(+,-)  2: parenthesis   3: scientific operator(sin cos)  4: x values
    public pObj(int i,String str){
      mode=i;
      if(mode==0){
         if(str.equals("e")){num=Math.E;}
         else if(str.equals("p")){num=Math.PI;}
         else{
         num=Double.parseDouble(str);}
      }
      if(mode==1){
          oper=str;
      }
      if(mode==2){
          paren=str;
      }
      if(mode==3){
          if(str.equals("c")){sciop="cos";}
          if(str.equals("s")){sciop="sin";}
          if(str.equals("t")){sciop="tan";}
          if(str.equals("l")){sciop="log";}
      }
    }
    public String toString(){
      if(mode==0){
       return(Double.toString(num));}
      if(mode==1){return(oper);}
      if(mode==2){return(paren);}
      if(mode==3){return(sciop);}
      else{return("x");}
    }
}