import java.util.*;

Stack<Rectangle> rects = new Stack();

void setup(){
  size(550, 600); 
  
  background(255);
  rects.push(new Rectangle(0, 0, 550, 600));
  
  while(!rects.isEmpty()){
    rects.pop().develop();
  }
}

class Rectangle{
  float x1, x2, y1, y2;
  
   Rectangle(float x1, float y1, float x2, float y2){
     this.x1 = x1;
     this.y1 = y1;
     this.x2 = x2;
     this.y2 = y2;     
   }
   
   void develop(){
     //random chance of being split into two smaller rectangles by a line
     //or of filling in a solid primary colour
     //or nothing, a dead end
   }
   
}
