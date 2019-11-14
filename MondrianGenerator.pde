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
     float min = 42;    
     float buffer = 20;  
     
     //TODO: make outermost borders offscreen so appears borderless 
     //to stay true to the Mondrian look
     
     //only one dimension needs to be bigger than min, 
     //as long as we ensure that's the one that gets split
     if(width>min || height>min){  
     
     toColour.remove(this);
       //split into two smaller rectangles
       //TODO: Consider replacing (width>min) condition 
       //with one that instead considers the height/width ratio
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
  int rand1 = int(random(2));
  int rand2 = int(random(3));
  int[][] colours = new int[4][2];
      colours[0][0] = #d10a0f;  //red  
      colours[0][1] = 2 + rand1;
      colours[1][0] = #3d487e;  //blue  
      colours[1][1] = 5 - colours[0][1];
      colours[2][0] = #fcd202;  //yellow
      colours[2][1] = 2;
      colours[3][0] = #000000;  //black
      colours[3][1] = rand2;  

  
  if(i<17){
    i++;
    rects.poll().split();
    delay(180);
  }else if(i==17){
   i++;    //remove this for seizurey fun times
   for(int[] c: colours){
    for(int j = 0; j < c[1]; j++){
      fill(c[0]);
      int rectNum = int(random(toColour.size()));
      Rectangle chosen = toColour.get(rectNum);
      toColour.remove(chosen);
      chosen.redraw();
      }
    } 
    //TODO: make sure two black rects don't border each other, generally doesn't look great 
  }
}
 
void keyPressed(){
  if(key == ' ' ){
    background(255);
    i = 0;
    rects.clear();  
    rects.add(new Rectangle(0, 0, 550, 600));
    toColour.clear();
  }
}
