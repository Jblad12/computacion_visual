import fisica.*;
  FWorld world;

void setup(){
 size(500,500,P2D);
  Fisica.init(this);
    
  world = new FWorld();
  world.setEdges(); 
  
  FCompound compound = new FCompound();
  compound.setPosition(width/2,height/2);
  world.add(compound);
   
  FCircle circle = new FCircle(40);
  circle.setPosition(width/2,height/2);
  circle.setRestitution(0.8f);
  circle.setStatic(true);
  compound.addBody(circle);
   
  circle = new FCircle(30);
  circle.setPosition(width/2,height/2); // posiccion de l
  circle.setRestitution(0.8f);
  //circle.setStatic(true);
  world.add(compound);
  compound.addBody(circle);
   
  circle = new FCircle(20);
  circle.setPosition(width/2-5,30); // posiccion de l
  circle.setRestitution(0.8f);
  //circle.setStatic(true);
  world.add(compound);
  compound.addBody(circle);
  
 // time = System.currentTimeMillis();
  //tipos de objetos dinamicos y estáticos 
  
world.add(compound);

 FBox box = new FBox(100,10);
  box.setPosition(width/4,height/2);
  box.setStatic(true);
  world.add(box);
  
  box = new FBox(100,10);
  box.setPosition(width*3f/4,height/2);
  box.setStatic(true);
  world.add(box);

}


void draw(){
  background (128);
  
  //text((System.currentTimeMillis()-time)/1000,10,30))
  if (frameCount%(10)==0){
  FCircle circle = new FCircle(20);
  circle.setPosition(random(20,width-20),20); // posiccion de l
  circle.setRestitution(0.8f);
  //circle.setStatic(true);
  world.add(circle);
  
  FBlob blob = new FBlob();
  blob.setPosition(random(20,width-20),20);
  blob.setAsCircle(10);
  world.add(blob);
 
  }
   world.step();
   world.draw();
}
FPoly poly;
void mouseDragged (){
  if (poly == null){
     poly= new FPoly();
     poly.setStatic(true);
  }
  poly.vertex(mouseX,mouseY);
  poly.recreateInWorld();

}

void mouseReleased(){
  if (poly != null){
   poly.setStatic(false);
   poly=null;
  }


}