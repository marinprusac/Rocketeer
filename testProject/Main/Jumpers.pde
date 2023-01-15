class Jumper extends Rocket{
  
  public Jumper(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 4, 0.08, 32, 16.67, 1.2);
    shock = 1;
    secondaryDmg = 3;
    maxUltCooldown = 150;
  }
  
  Bullet anchor = null;
  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    rotate(PI/2);
    if(anchor != null && anchor.hitpoints>0) image(imgU,0,0);
    else image(img,0,0);
    
    
    popMatrix();
    
  }


  
  public void shoot(){
    if (shootCooldown==0 && hitpoints > 0){
      super.shoot();
      Bullet bullet = new JumperBullet(pos.x, pos.y, angle, this, false);
      putSpaceObject(bullet);
      bullet = new JumperBullet(pos.x, pos.y, angle+PI, this, false);
      putSpaceObject(bullet);
      shootCooldown = maxShootCooldown;
    }
  }
  
  public void ultimate(){
    if(ultCooldown>0) return;
    ultCooldown = maxUltCooldown;
    if(anchor!= null && anchor.hitpoints>0){
      pos.x = anchor.pos.x;
      pos.y = anchor.pos.y;
      anchor.hitpoints=0;
      anchor = null;
      
      return;
    }
    Bullet bullet = new JumperBullet(pos.x, pos.y, angle+PI, this, true);
    putSpaceObject(bullet);
    anchor = bullet;
    pos.x = max(0,min(maxX,pos.x+cos(angle)*300));
    pos.y = max(0,min(maxY,pos.y+sin(angle)*300));
    
  }
  
  public void update(){
    super.update();
    ultCooldown = max(0,ultCooldown-fpsAdjust);
  }
  
  
}
