import java.util.*;
int i;

PriorityQueue<Rectangle> rects = new PriorityQueue();

void setup(){
  size(550, 600); 
  background(255);
  strokeWeight(4);
  rects.add(new Rectangle(0, 0, 550, 600));
  i = 0;
}

class Rectangle implements Comparable<Rectangle>{
  float x, y, width, height, area;
  
   Rectangle(float x, float y, float w, float h){
     this.x = x;
     this.y = y;
     width = w;
     height = h;   
     area = height * width;
    
     int[] colours = new int[4];
      colours[0] = #d10a0f;  //red  
      colours[1] = #3d487e;  //blue  
      colours[2] = #fcd202;  //yellow
      colours[3] = #000000;  //black
      
      
     int r= int(random(15));
     int colour = (r<4? colours[r]: #ffffff);
     
     //TODO: Favour colours that haven't been picked yet i.e. choose yellow once before red for a second time
     //TODO: Make sure two black rectangles don't border each other?
     
     fill(colour);
     rect(x, y, width, height);   
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
   
   void split(){
     float min = 20;    //no longer needed?
     float buffer = 8;  //ditto?
     
     //TODO: make outermost borders offscreen so appears borderless 
     //to stay true to the Mondrian look
     
     //only one dimension needs to be bigger than min, 
     //as long as we ensure that's the one that gets split
     if(width>min || height>min){  //([current])||rects.size()<5
     //||size bit to ensure first few get developed and so there's no longer a small
     //chance of stalling right at the start
     
       //split into two smaller rectangles
       int direction = int(random(2));
       if(direction==0 && width>min){   
         float xOffset = random(buffer, width-buffer);  //split with vertical line
         rects.add(new Rectangle(x, y, xOffset, height));
         rects.add(new Rectangle(x+xOffset, y, width-xOffset, height));
       }else{
         float yOffset = random(buffer, height-buffer);  //split with horizontal line
         rects.add(new Rectangle(x, y, width, yOffset));
         rects.add(new Rectangle(x, y+yOffset, width, height-yOffset));
       }
     }
   }
}
void draw(){

  if(i++<15 && !rects.isEmpty()){
    rects.poll().split();
    delay(400);
  }
}
