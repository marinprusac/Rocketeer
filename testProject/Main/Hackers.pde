class Hacker extends Rocket{
  
  public Hacker(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 3, 0.05, 40, 18, 0.8);
    maxUltCooldown = 200;
  }
  

  
  void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle+PI/2);
    image(img,0,0);
    tint(255,max(0,ultCooldown-maxUltCooldown/1.5)*4);
    image(imgU,0,0);
    tint(255,255);
    popMatrix();
  }
  
  void shoot(){
    if (shootCooldown==0 && hitpoints > 0){
      super.shoot();
      Bullet bullet = new HackerBullet(pos.x+cos(angle+PI/4)*30, pos.y+sin(angle+PI/4)*30, angle, this);
      putSpaceObject(bullet);
      bullet = new HackerBullet(pos.x+cos(angle-PI/4)*30, pos.y+sin(angle-PI/4)*30, angle, this);
      putSpaceObject(bullet);
      shootCooldown = maxShootCooldown;
    }
  }
  
  void ultimate(){
    if(ultCooldown > 0)
      return;
    for(SpaceObject so : spaceObjects){
      if(so.getClass().getSuperclass()==Bullet.class){
        Bullet b = (Bullet)so;
        b.dmg *= 1.25;
        if(b.ownerRocket==this){
          b.course = b.course.scale(2);
          b.hitpoints = 1;
          continue;
        }
        b.ownerRocket = this;
        b.course = b.course.rotate(PI + random(-PI/4,PI/4));
        b.hitpoints = 1;
        b.course = b.course.scale(0.5);
      }
    }
    ultCooldown = maxUltCooldown;
  }
  
  void update(){
    super.update();
    ultCooldown=max(ultCooldown-fpsAdjust,0);
  }
}
