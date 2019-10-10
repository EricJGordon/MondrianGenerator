import java.util.*;

PriorityQueue<Rectangle> rects = new PriorityQueue();

void setup(){
  size(550, 600); 
  
  background(255);
  strokeWeight(4);
  rects.add(new Rectangle(0, 0, 550, 600));
  
  for(int i=0; i<15 && !rects.isEmpty(); i++){
    rects.poll().develop();

  }
}

class Rectangle implements Comparable<Rectangle>{
  float x1, x2, y1, y2;
  float height, width, area;
  
   Rectangle(float x1, float y1, float x2, float y2){
     this.x1 = x1;
     this.y1 = y1;
     this.x2 = x2;
     this.y2 = y2;     
     
    rect(x1, y1, x2, y2);   
    height = y2-y1;
    width = x2-x1;
    area = height * width;
   }
   
   @Override
   int compareTo(Rectangle other){
     int result;
     if(this.area < other.area ){  //Comparison is inverse of deault Float.compareTo()
       result = 1;                 //since we want the biggest areas to be highest priority.
     }else if(this.area > other.area){
       result = -1;
     }else{
       result = 0;
     }
     return result;
   }
   
   void develop(){
     int action = int(random(9));
     float min = 20;    //no longer needed?
     float buffer = 8;  //ditto
     
     //TODO: make outermost borders offscreen so appears borderless 
     //to stay true to the Mondrian look
     
     if(action<9  && (width>min || height>min)){  
     //only one dimension needs to be bigger than min, 
     //as long as we ensure that's the one that gets split
     
       //split into two smaller rectangles
       int direction = int(random(2));
       if(direction==0 && width>min){   
         float newX = x1 + random(buffer, width-buffer);  //split with vertical line
         rects.add(new Rectangle(x1, y1, newX, y2));
         rects.add(new Rectangle(newX, y1, x2, y2));
       }else{
         float newY = y1 + random(buffer, height-buffer);  //split with horizontal line
         rects.add(new Rectangle(x1, y1, x2, newY));
         rects.add(new Rectangle(x1, newY, x2, y2));

       }
     }else if(action==9){
       //fill in a random solid primary colour
       /*fill(150, 0, 0);
       rect(x1, y1, x2, y2);   
       fill(255);*/
       
       //for testing purposes move rects.poll().develop() to a draw(), add delay(),
       //and fill each rectangle a progressively different shade as it goes on?
       //Might also help to print out area of current rect to console
       
     } //or nothing, a dead end
   }
   
}
