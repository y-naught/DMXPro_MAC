class TwoColorGradient{
 
  PVector location;
  PVector velocity;
  float hue = 0;
  float saturation = 0;
  float brightness = 0;
  float hueOffset = 127;
  float gradWidth = 0;
  
  TwoColorGradient(){
   location = new PVector(-width / 2, 0);
   velocity = new PVector(1,0);
  }
  
  void display(PGraphics g, float gradSp,float hu,float sat,float bri, float wi, int hu2, int sat2, int bri2){
    brightness = bri;
    hue = (hu + hueOffset) % 255;;
    saturation = sat;
    gradWidth = wi;
    if(gradSp != 0 && velocity.x == 0){
     velocity.x = 1; 
    }
    velocity.normalize();
    velocity.mult(gradSp);
    location.add(velocity);
    g.colorMode(HSB);
    g.rectMode(CENTER);
    g.noStroke();
    g.fill(hu2, sat2, bri2);
    g.rect(location.x, location.y, gradWidth, 1000);
  }
  
  void checkEdges(){
   if(location.x > width + gradWidth / 2 ){
    location.x = -gradWidth / 2; 
   }
  }
}