class Sniper extends Rocket{
  
  public Sniper(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 4.5, 0.03, 40, 60, 4);
    maxUltCooldown = 25;
  }
  
  boolean ultimate = false;
  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    rotate(PI/2);
    
    if(ultimate){
      if(ultCooldown>0){
        tint(255,255f*(ultCooldown/maxUltCooldown));
        image(img,0,0);
        tint(255,255f*(1-ultCooldown/maxUltCooldown));
        image(imgU,0,0);
      }
      else {
        tint(255,0);
        image(img,0,0);
        tint(255,255);
        image(imgU,0,0);
      }
    }
    else {
      if(ultCooldown>0) {
        tint(255,255f*(1-ultCooldown/maxUltCooldown));
        image(img,0,0);
        tint(255,255f*(ultCooldown/maxUltCooldown));
        image(imgU,0,0);
      }
      else {
        tint(255,255);
        image(img,0,0);
        tint(255,0);
        image(imgU,0,0);
      }
    }
    
    
    tint(255,255);
    popMatrix();
    
  }

  
  public void shoot(){
    if (shootCooldown==0 && hitpoints > 0 && ultimate){
      super.shoot();
      Bullet bullet = new SniperBullet(pos.x+cos(angle)*30, pos.y+sin(angle)*30, angle, this);
      putSpaceObject(bullet);
      shootCooldown = maxShootCooldown;
    }
  }
  
  public void ultimate(){
    if(ultCooldown > 0)
    return;
    ultimate = !ultimate;
    ultCooldown = maxUltCooldown;
  }
  
  void update(){
    super.update();
    if(ultimate) {
      rotP = maxRotP*3f/4f;
      engP = 0;
    }
    else {
      rotP = maxRotP;
      engP = maxEngP;
    }
    ultCooldown=max(ultCooldown-fpsAdjust,0);
    shock = 0;
  }
  
  
}
