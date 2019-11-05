import java.util.*;
int i;

PriorityQueue<Rectangle> rects = new PriorityQueue();
ArrayList<Rectangle> toColour = new ArrayList();

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
    
     
     //int colour = (r<4? colours[r]: #ffffff);
     
     //TODO: Favour colours that haven't been picked yet i.e. choose yellow once before red for a second time
     //TODO: Make sure two black rectangles don't border each other?
     
     fill(255);
     rect(x, y, width, height);   
   }
   
   void redraw(){
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
     
     toColour.remove(this);
       //split into two smaller rectangles
       int direction = int(random(2));
       if(direction==0 && width>min){   
         float xOffset = random(buffer, width-buffer);  //split with vertical line
         Rectangle rect1 = new Rectangle(x, y, xOffset, height);
         rects.add(rect1);
         toColour.add(rect1);
         Rectangle rect2 = new Rectangle(x+xOffset, y, width-xOffset, height);
         rects.add(rect2);
         toColour.add(rect2);
       }else{
         float yOffset = random(buffer, height-buffer);  //split with horizontal line
         Rectangle rect1 = new Rectangle(x, y, width, yOffset);
         rects.add(rect1);
         toColour.add(rect1);
         Rectangle rect2 = new Rectangle(x, y+yOffset, width, height-yOffset);
         rects.add(rect2);
         toColour.add(rect2);
       }
     }
   }
}
void draw(){
  
  int[] colours = new int[4];
      colours[0] = #d10a0f;  //red  
      colours[1] = #3d487e;  //blue  
      colours[2] = #fcd202;  //yellow
      colours[3] = #000000;  //black
  
  if(i<15){
    i++;
    rects.poll().split();
    delay(400);
  }else if(i==15){
   i++;    //remove this for seizurey fun times
   for(int c: colours){
    for(int j = 0; j < 2; j++){
      fill(c);
      int rectNum = int(random(toColour.size()));
      Rectangle chosen = toColour.get(rectNum);
      chosen.redraw();
      }
    } 
    //TODO: make sure colours don't overwrite each other - each 'chosen' should be a number that hasn't already been picked
    //TODO: make sure two black rects don't border each other, generally doesn't look great
    
  }
  

   
      
}
