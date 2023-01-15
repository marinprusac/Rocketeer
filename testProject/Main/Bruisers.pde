class Bruiser extends Rocket{
  

  
  public Bruiser(int x, int y, float angle, Skin skin) {
    // xPos yPos angle skin eng rot hitpts shootCooldown
    super(x,y, angle, skin, 2.5, 0.04, 60, 40, 1);
    maxUltCooldown = 500;
  }
  
  float ultTypeCooldown = 0;
  float maxUltTypeCooldown = 15;
  float maxBoostFrames = 100;
  float boostFrames = 0;
  boolean usedReturn = false;
  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    rotate(PI/2);
    
    image(img,0,0);
    tint(255,boostFrames*10);
    image(imgU,0,0);
    tint(255,255);
    popMatrix();
    
  }
  
  public void shoot(){
    if (shootCooldown==0 && hitpoints > 0){
      super.shoot();
      Bullet bullet = new BruiserBullet(pos.x+cos(angle+PI/4)*25, pos.y+sin(angle+PI/4)*25, angle, this);
      putSpaceObject(bullet);
      bullet = new BruiserBullet(pos.x+cos(angle-PI/4)*25, pos.y+sin(angle-PI/4)*25, angle, this);
      putSpaceObject(bullet);
      bullet = new BruiserBullet(pos.x+cos(angle)*30, pos.y+sin(angle)*30, angle, this);
      putSpaceObject(bullet);
      shootCooldown = maxShootCooldown;
    }
  }
  
  public void ultimate(){
    if(ultTypeCooldown>0) return;
    ultTypeCooldown = maxUltTypeCooldown;
    if(boostFrames > 0 && !usedReturn){
      boostFrames = maxBoostFrames/5;
      usedReturn = true;
    }
    if(ultCooldown>0) return;
    usedReturn = false;
    ultCooldown = maxUltCooldown;
    boostFrames = maxBoostFrames;
  }
  
  public void update(){
    super.update();
    gas = gas.scale(gas.mag/maxEngP);
    gas = gas.scale(1+boostFrames/maxBoostFrames*10);
    ultCooldown = max(0,ultCooldown-fpsAdjust);
    ultTypeCooldown = max(0,ultTypeCooldown-fpsAdjust);
    if(abs(boostFrames)<fpsAdjust) boostFrames = 0;
    else boostFrames += (boostFrames>0?-1:1)*fpsAdjust;
    if(boostFrames>0) rotP = maxRotP/4;
    else rotP = maxRotP;
  }
  
  
}
