abstract class Rocket extends SpaceObject{
  
  public Rocket(int x, int y, float angle, Skin skin, float engP, float rotP, float hitpoints, float shootCooldown, float pd){
    super(x,y,angle, engP, rotP, hitpoints, 20,0,0);
    this.skin = skin;
    img = loadImage(skin.imgs.get(0));
    imgU = loadImage(skin.imgs.get(1));
    imgB = loadImage(skin.imgs.get(2));
    imgE = loadImage(skin.imgs.get(3));
    this.shootCooldown = maxShootCooldown = shootCooldown;
    gas = Vect.newAM(angle,engP);
    mass = pow(size,2);
    primaryDmg = pd;
    maxHP = hitpoints;
  }
  
  float maxHP;
  float shootCooldown;
  float maxShootCooldown;
  float ultCooldown = 0;
  float maxUltCooldown = 0;
  float shock=0;
  float ores = 0;
  float primaryDmg = 0;
  float secondaryDmg = 0;
  float hpRegen = 0.0005;
  ArrayList<Buff> buffs = new ArrayList<Buff>();
  
  Bullet bulletType;
  Skin skin;
  PImage img;
  PImage imgU;
  PImage imgB;
  PImage imgE;
  
  
  public void show(){
    textMode(CENTER);
    game.showText(Math.round(hitpoints*10)/10f+"",20,pos.x,pos.y-30,50,20);
  }
  
  
  
  public void shoot(){
    course = course.add(Vect.newAM(angle-PI,shock));
  }
  
  public void destroyedEffect(){
    tint(255,fadeEffect/fadeEffectMax*255);
    show();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle+QUARTER_PI);
    tint(255,100-fadeEffect/fadeEffectMax*100);
    image(imgE,0,0);
    fadeEffect = max(0,fadeEffect-fpsAdjust);
    popMatrix();
  }
  
  public void rocketRotate(boolean right){
    if(hitpoints<=0) return;
    if(right){
      angle+=rotP*fpsAdjust;
    }
    else{
      angle-=rotP*fpsAdjust;
    }
  }
  
  public void update(){
    super.update();
    course = course.add(gas.subtract(course).scale(drag*fpsAdjust));
    shootCooldown = max(0,shootCooldown-=fpsAdjust);
    gas = Vect.newAM(angle,engP);
    shock = maxShootCooldown/10;
    hitpoints = min(maxHP,hitpoints+maxHP*hpRegen*fpsAdjust);
  }
  
  void iHit(SpaceObject what, boolean first){
    if(what.getClass().getSuperclass() == Bullet.class){
      if(((Bullet)what).ownerRocket==this){
        return;
      }
      else {
        what.hitpoints -= 0.5;
      }
    }
    else if(what.getClass().getSuperclass() == Asteroid.class){
      what.hitpoints -= 0.25;
    }
    else if(what.getClass().getSuperclass() == Rocket.class){
      what.hitpoints -= 1;
    }
    super.iHit(what,first);
  }

  
  public void destroyed(){
    toDestroy.add(this);
    destroyedEffect.add(this);
  }
  

  
  public abstract void ultimate();
  
  
  
}
