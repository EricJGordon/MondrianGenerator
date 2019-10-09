import java.util.*;

Queue<Rectangle> rects = new LinkedList();

void setup(){
  size(550, 600); 
  
  background(255);
  strokeWeight(4);
  rects.add(new Rectangle(0, 0, 550, 600));
  
  while(!rects.isEmpty()){
    rects.remove().develop();
  }
}

class Rectangle{
  float x1, x2, y1, y2;
  
   Rectangle(float x1, float y1, float x2, float y2){
     this.x1 = x1;
     this.y1 = y1;
     this.x2 = x2;
     this.y2 = y2;     
     
    rect(x1, y1, x2, y2);     
   }
   
   void develop(){
     int action = int(random(5));
     
     //TODO: make it so first few layers have near 100% chance of splitting
     //which then gets gradually but exponentially smaller as it goes on
     //(Factor size of rectangle into probability?)
     
     //TODO: ensure minimum buffer space between nearest other line
     
     //TODO: make outermost borders offscreen so appears borderless 
     //to stay true to the Mondrian look
     
     if(action<3){  //&& (xDiff>min || yDiff>min)  
     //only one dimension needs to be bigger than min, 
     //as long as we ensure thaat's the one that gets split
     
       //split into two smaller rectangles
       int direction = int(random(2));
       if(direction==0){  //&& xDiff>min 
         float newX = x1 + random(x2-x1);  //split with vertical line
         rects.add(new Rectangle(x1, y1, newX, y2));
         rects.add(new Rectangle(newX, y1, x2, y2));
       }else{
         float newY = y1 + random(y2-y1);  //split with horizontal line
         rects.add(new Rectangle(x1, y1, x2, newY));
         rects.add(new Rectangle(x1, newY, x2, y2));

       }
     }else if(action==2){
       //fill in a solid primary colour
     } //or nothing, a dead end
   }
   
}
