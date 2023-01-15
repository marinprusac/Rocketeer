class Laser extends Rocket{
  
  
  
  public Laser(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 3, 0.035, 40, 20, 0.8);
    newShootCooldown = maxShootCooldown;
    sf = laser;
    sf.amp(0.2);
    maxUltCooldown = 1000;
  }
  
  float ultTime = 0;
  float maxUltTime = 500;
  float newShootCooldown;
  SoundFile sf;
  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    rotate(PI/2);
    
    tint(255,abs(250-ultTime)+5);
    image(img,0,0);
    tint(255,250-abs(250-ultTime));
    image(imgU,0,0);
    tint(255,255);
    popMatrix();
    
  }
  
  
  public void shoot(){
    
    if (shootCooldown==0 && hitpoints > 0){
      laser.play();
      super.shoot();
      Bullet bullet = new LaserBullet(pos.x+cos(angle+PI/4)*30, pos.y+sin(angle+PI/4)*30, angle, this);
      putSpaceObject(bullet);
      bullet = new LaserBullet(pos.x+cos(angle-PI/4)*30, pos.y+sin(angle-PI/4)*30, angle, this);
      putSpaceObject(bullet);
      shootCooldown = newShootCooldown;
    }
  }
  
  public void ultimate(){
    if(ultCooldown>0) return;
    ultCooldown = maxUltCooldown;
    ultTime = maxUltTime;
  }
  
  public void update(){
    super.update();
    shock = 1;
    if(ultTime>0) {
      shoot();
      newShootCooldown = maxShootCooldown / (1 + (250-abs(maxUltTime/2-ultTime))/(maxUltTime/2)*5);
    }
    else {
      newShootCooldown = maxShootCooldown;
    }
    ultCooldown = max(0,ultCooldown-fpsAdjust);
    ultTime = max(0,ultTime-fpsAdjust);
    rotP = abs(maxUltTime/2-ultTime)/(maxUltTime/2)*0.03+0.005;
  }
  
  


}
