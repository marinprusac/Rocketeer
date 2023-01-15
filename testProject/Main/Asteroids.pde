class Asteroid extends SpaceObject{
  
  String[] asteroidSkins = {"a","ap","ab","ar","ag"};
  String ext = ".png";
  String sep  = "\\";
  
  public Asteroid(float x, float y, float speed, float course, float chance, float size){
    
    super(x,y,0,0,0,pow(size,2)/30,size, speed, course);
    type = chooseRandom(chance);
    String name = "";
    int rand = int(random(0,4))+1;
    switch(type){
      case BASIC:
        name = "a";
        break;
      case PURPLE:
        name = "ap";
        break;
      case BLUE:
        name = "ab";
        break;
      case RED:
        name = "ar";
        break;
      case GREEN:
        name = "ag";
        break;
    }
    img = loadImage(path+"\\assets"+sep+name+rand+ext);
    imgE = loadImage(path+"\\assets"+sep+name+"E"+ext);
    img.resize((int)size*2,(int)size*2);
    imgE.resize((int)size*2,(int)size*2);
    rotP = random(-0.005,0.005);
    mass = pow(size,3);
  }
  
  AsteroidType type;
  PImage img;
  PImage imgE;
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    image(img,0,0);
    popMatrix();
  }
  
  AsteroidType chooseRandom(float chanceForSpecial){
    ArrayList<AsteroidType> types = new ArrayList<AsteroidType>();
    types.addAll(Arrays.asList(AsteroidType.values()));
    types.remove(AsteroidType.BASIC);
    float pick = random(0,1);
    if(pick<=chanceForSpecial){
      return types.get(int(pick/chanceForSpecial*4));
    }
    return AsteroidType.BASIC;
    
  }
  
  
  void iHit(SpaceObject what, boolean first){
    if(what.getClass().getSuperclass()==Bullet.class){
      what.hitpoints-=0.5;
    }
    else if(what.getClass()==Asteroid.class){
      
    }
    else if(what.getClass().getSuperclass()==Rocket.class){
      what.hitpoints -= 0.1;
    }
    super.iHit(what,first);
  }
  

  void destroyed(){
    toDestroy.add(this);
    destroyedEffect.add(this);
    if(type!=AsteroidType.BASIC && pos.x>0 && pos.y>0 && pos.x<maxX && pos.y<maxY){
      for(int i=0; i<round(size/10f);i++){
        float angle = random(0,TWO_PI);
        float magnitude = random(size*2);
        Vect posOre = Vect.newAM(angle,magnitude);
        Ore ore = new Ore(posOre.x+pos.x,posOre.y+pos.y,type);
        putSpaceObject(ore);
      }
    }
  }
  
  void destroyedEffect(){
    tint(255,fadeEffect/fadeEffectMax*255);
    show();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    tint(255,100-fadeEffect/fadeEffectMax*100);
    image(imgE,0,0);
    fadeEffect = max(0,fadeEffect-fpsAdjust);
    popMatrix();
  }
  
  void update(){
    super.update();
    angle += rotP*fpsAdjust;
  }
}



enum AsteroidType {
  RED, BLUE, PURPLE, GREEN, BASIC
}
