class DefenderBullet extends Bullet {
  public DefenderBullet(float x, float y, float angle, Rocket owner, boolean isShield){
    super(x,y,owner,10,11,angle,0.02,owner.primaryDmg);
    if(isShield){
      course = Vect.newAM(angle,40);
      size = 20;
      decay = 0.0025;
    }
    this.isShield = isShield;
    img2 = loadImage(owner.skin.imgs.get(4));
  }

  boolean isShield;
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(3*PI/4);
    rotate(angle);
    tint(255,255*hitpoints);
    if(!isShield)image(img,0,0);
    else image(img2,0,0);
    popMatrix();
  }
  
  void move(){
    if(isShield){
      pos = ownerRocket.pos.add(course);
    }
    else {
      super.move();
    }
  }
  
  void update(){
    super.update();
    if(isShield){
      course = course.rotate(0.1*fpsAdjust);
    }
  }
  
  void destroyed(){
    super.destroyed();
    if(!isShield)
      return;
    if(ownerRocket.getClass() == Defender.class){
      ((Defender)ownerRocket).shields.remove(this);
    }
  }
}

class JumperBullet extends Bullet {
  public JumperBullet(float x, float y, float angle, Rocket owner, boolean isAnchor){
    super(x,y,owner,10,11,angle,0.02,owner.primaryDmg);
    if(isAnchor){
      course = Vect.newXY(0,0);
      size = 20;
      decay = 0.0025;
      dmg = owner.secondaryDmg;
    }
    this.isAnchor = isAnchor;
    img2 = loadImage(owner.skin.imgs.get(4));
  }

  boolean isAnchor;
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    tint(255,255*hitpoints);
    if(!isAnchor)image(img,0,0);
    else image(img2,0,0);
    popMatrix();
  }
}


class HackerBullet extends Bullet {
  public HackerBullet(float x, float y, float angle, Rocket owner){
    super(x,y,owner, 10, 4.5, angle, 0.008,owner.primaryDmg);
  }

  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    tint(255,255*hitpoints);
    image(img,0,0);
    popMatrix();
  }
  
  
}

class TrackerBullet extends Bullet {
  public TrackerBullet(float x, float y, float angle, Rocket owner, Rocket toFollow){
    super(x,y,owner,10,10,angle,0.007,owner.primaryDmg);
    img2 = loadImage(owner.skin.imgs.get(4));
    this.toFollow = toFollow;
    if(toFollow!=null){
      course = Vect.newAM(angle,5);
      decay = 0.004;
      size = 15;
      maxRotP = 0.02;
      rotP = maxRotP;
      dmg = owner.secondaryDmg;
    }
  }
  
  Rocket toFollow;
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle+PI);
    if(toFollow==null){
      tint(255,255*hitpoints);
      image(img2,0,0);
      tint(255,255);
    }
    else{
      tint(255,255*hitpoints);
      image(img,0,0);
      tint(255,255);
    }
    popMatrix();
  }
  

  
  void update(){
    super.update();
    if(toFollow!=null){
      float angleToEnemy = MySystem.angleTo(this,toFollow);
      
      if(abs(angleToEnemy-course.ang)>PI){
        if(course.ang<angleToEnemy){
          course=course.rotate(-rotP*fpsAdjust);

        }
        else{
          course = course.rotate(rotP*fpsAdjust);
        }
      }
      else {
        if(course.ang<angleToEnemy){
          course = course.rotate(rotP*fpsAdjust);
        }
        else{
          course=course.rotate(-rotP*fpsAdjust);
        }
      }
      
    }
  }
  
}

class BruiserBullet extends Bullet {
  public BruiserBullet(float x, float y, float angle, Rocket owner){
    super(x,y,owner,10,7,angle,0.015,owner.primaryDmg);
  }
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    tint(255,255*hitpoints);
    image(img,0,0);
    tint(255,255);
    popMatrix();
  }
  
  
}

class SniperBullet extends Bullet {
  public SniperBullet(float x, float y, float angle, Rocket owner){
    super(x,y,owner,30,30,angle,0.005,owner.primaryDmg);
  }
  
  
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle+PI);
    image(img,0,0);
    popMatrix();
  }
  
}
class LaserBullet extends Bullet {
  public LaserBullet(float x, float y, float angle, Rocket owner){
    super(x,y,owner,10,20,angle,0.005,owner.primaryDmg);
  }
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle+PI);
    tint(255,hitpoints*255);
    image(img,0,0);
    tint(255,255);
    popMatrix();
  }
  
  
}
abstract class Bullet extends SpaceObject{
  

  
  public Bullet(float x, float y, Rocket owner, float size, float speed, float course, float decay, float dmg){
    super(x,y,course, 0, 0, 1, size, speed, course);
    ownerRocket = owner;
    this.decay = decay;
    img = owner.imgB;
    this.dmg =  dmg;
    mass = size;
  }
  
  float dmg;
  PImage img;
  PImage img2;
  float decay = 0;
  Rocket ownerRocket;
  
  
  public abstract void show();
  
  public void move(){
    pos = pos.add(course.scale(fpsAdjust));
  }
  
  void iHit(SpaceObject what, boolean first){
    if(what.getClass().getSuperclass()==Rocket.class) {
      if(ownerRocket == what) {
        return;
      }
      else{
        what.hitpoints-=dmg;
      }
    }
    else if(what.getClass().getSuperclass()==Bullet.class) {
      Bullet w = (Bullet)what;
      if(ownerRocket == w.ownerRocket){
        return;
      }
      else {
        w.hitpoints -= hitpoints*dmg;
      }
    }
    else if(what.getClass()==Asteroid.class){
      what.hitpoints -= dmg;
    }
    super.iHit(what,first);
  }
  

  public void destroyedEffect(){
    
  }
  
  void update(){
    super.update();
    angle = course.ang;
    hitpoints-=decay*fpsAdjust;
    if(hitpoints<=0){
      destroyed();
    }
  }
  
  
  
  
  public void destroyed(){
    toDestroy.add(this);
  }
  
}
