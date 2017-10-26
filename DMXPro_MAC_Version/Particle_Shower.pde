//an object the culminates the particles
class Shower{
  
 //create the array list of particles
 ArrayList<Particle> Particles;
 int perFrame;
 float sz;
 
 //float particleSpeed = 0;
 //constructor takes number per frame and size of each particle
 Shower(int count, float s){
  Particles = new ArrayList<Particle>();
  perFrame = count;
  sz = s;
 }
 
 //calling this method in draw will run the particle shower
 //must have a graphic to apply the effect to as an argument of the method
 void run(PGraphics g, float hue, float saturation, float brightness,float alpha, float particleSpeed, float nppf, float size, boolean oneC){
   PVector dir = new PVector(0, 1);
   
   //adds particles every frame
   for(int i = 0; i < nppf; i++){
     PVector location = new PVector(random(0, width), 0);
     Particles.add(new Particle(sz,location));
   }
   //Tests to see of the particle should be removed,
   //applies the changes to the characteristics of it, and draws it on the layer passed
   for(int i = 0; i < Particles.size(); i++){
    Particle p = Particles.get(i);
    if(p.isDead()){
      Particles.remove(i);
    }else{
     p.direction(dir);
     p.update(hue, saturation, brightness, alpha, particleSpeed, size, oneC);
     p.display(g);
    }
   }
 }
}

class Fountain{
   PVector direction;
   ArrayList<Particle> Particles;
   
   Fountain(){
    direction = new PVector(random(-1,1), random(-1,1));
    Particles = new ArrayList<Particle>();
   }
   
   void run(PGraphics g, float hue, float saturation, float brightness,float alpha, float particleSpeed, float nppf, float size, boolean oneC, float x, float y){
     PVector temp = new PVector(x, y);
    for(int i = 0; i < nppf; i++){
      PVector loc = new PVector(width / 2, height / 2);
     Particles.add(new Particle(size,loc)); 
    }
    for(int i = 0; i < Particles.size(); i++){
    Particle p = Particles.get(i);
    if(p.isDead()){
      Particles.remove(i);
    }else{
     p.direction(temp);
     p.update(hue, saturation, brightness, alpha, particleSpeed, size, oneC);
     p.display(g);
    }
   }
   }
}

//a Particle class with a basic physics engine for use in multiple effect presets
class Particle{
  
 PVector location;
 PVector velocity;
 PVector acceleration;
 float sz;
 float hue = 0;
 float hueOffset = 0;
 float saturation = 0;
 float brightness = 255;
 float alpha;
 float speed;
 int startFrame;
 
 
 Particle(float s, PVector loc){
  location = loc;
  velocity = new PVector(0, random(3, 7));
  acceleration = new PVector(0, 0);
  sz = s;
  startFrame = frameCount;
  
  //the function that chooses the probability of each particle to be an offset color
  float rand = random(1);
  if(rand < 0.15){
    hueOffset = 127;
  }
  else if(rand >= 0.15 && rand < 0.30){
    hueOffset = -15;
  }
  else{
    hueOffset = 0;
  }
 }
 
 
 //applying the physics for each particle
 void update(float hu, float sat, float bri,float al, float Sp, float siz, boolean oneC){
   sz = siz;
   speed = Sp;
   if(velocity.x + velocity.y == 0){
     velocity.y = 1.0;
   }
   velocity.normalize();
   velocity.mult(speed);
  velocity.add(acceleration);
  PVector rand = new PVector(random(-10,10), random(-10,10));
  velocity.add(rand);
  location.add(velocity);
  
  //a switch for whether or not the function is using multiple colors
  if(oneC){
   hue = hu; 
  }
  else{
  hue = (hu + hueOffset) % 255;
  }
  saturation = sat;
  brightness = bri;
  alpha = al;
 }
 
 
 //takes the graphic you want to effect and adds the particle
 void display(PGraphics g){
   g.colorMode(HSB);
   g.fill(hue, saturation, brightness, alpha);
   g.noStroke();
   g.ellipse(location.x, location.y, sz, sz);
 }
 
 void direction(PVector dir){
   velocity.set(dir);
 }
 
 //a function that can be called to delete the particle after it leaves the display window or has been there for 1000 frames
 boolean isDead(){
  if(frameCount - startFrame > 1000){
     return true;
   }
  else if(location.y > height || location.x > width || location.x < 0 || location.y < 0){
   return true; 
  }else{
   return false; 
  }
 }
}