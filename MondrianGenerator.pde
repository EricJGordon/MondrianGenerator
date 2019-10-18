import java.util.*;
int i, r;

PriorityQueue<Rectangle> rects = new PriorityQueue();

void setup(){
  size(550, 600); 
  background(255);
  strokeWeight(4);
  rects.add(new Rectangle(0, 0, 550, 600));
  i = 0;
  r = 0;
}

class Rectangle implements Comparable<Rectangle>{
  float x1, x2, y1, y2;
  float height, width, area;
  
   Rectangle(float x1, float y1, float x2, float y2){
     this.x1 = x1;
     this.y1 = y1;
     this.x2 = x2;
     this.y2 = y2;     
    
    fill(30*r++, 230, 0);
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
     float buffer = 8;  //ditto?
     
     //TODO: make outermost borders offscreen so appears borderless 
     //to stay true to the Mondrian look
     
     //only one dimension needs to be bigger than min, 
     //as long as we ensure that's the one that gets split
     if(action<9  && (width>min || height>min)){  //([current])||rects.size()<5
     //||size bit to ensure first few get developed and so there's no longer a small
     //chance of stalling right at the start
     print("\n\nCurrent Rectangle: \nx1 =" + round(x1) + "\ny1 = " + 
     round(y1) + "\nx2 = " + round(x2) + "\ny2 = " + round(y2));
     
       //split into two smaller rectangles
       int direction = int(random(2));
       if(direction==0 && width>min){   
         float xOffset = random(buffer, width-buffer);  //split with vertical line
         rects.add(new Rectangle(x1, y1, xOffset, y2));
         rects.add(new Rectangle(x1+xOffset, y1, x2-xOffset, y2));
         print("\n\nSplits into a: \nx1 =" + round(x1) + "\ny1 = " + 
         round(y1) + "\nx2 = " + round(xOffset) + "\ny2 = " + round(y2) + 
         "\nand b: \nx1 =" + round(xOffset) + "\ny1 = " + 
         round(y1) + "\nx2 = " + round(x2) + "\ny2 = " + round(y2));
       }else{
         float yOffset = random(buffer, height-buffer);  //split with horizontal line
         rects.add(new Rectangle(x1, y1, x2, yOffset));
         rects.add(new Rectangle(x1, y1+yOffset, x2, y2-yOffset));
         
         print("\n\nSplits into a: \nx1 =" + round(x1) + "\ny1 = " + 
         round(y1) + "\nx2 = " + round(x2) + "\ny2 = " + round(yOffset) + 
         "\nand b: \nx1 =" + round(x1) + "\ny1 = " + 
         round(yOffset) + "\nx2 = " + round(x2) + "\ny2 = " + round(y2));

       }
     }else if(action==9){
       //fill in a random solid primary colour
       /*fill(150, 0, 0);
       rect(x1, y1, x2, y2);   
       fill(255);*/       
     } //or nothing, a dead end
   }
}
void draw(){

  if(i++<10 && !rects.isEmpty()){
    rects.poll().develop();
    delay(700);
  }
         //Might also help to print out area of current rect to console
}
