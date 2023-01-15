class Defender extends Rocket {
  
  public Defender(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 2.25, 0.03, 60, 50, 1);
    mass = pow(size,3);
    maxUltCooldown = 200;
  }
  


  ArrayList<DefenderBullet> shields = new ArrayList<DefenderBullet>();

  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    pushMatrix();
    rotate(angle);
    rotate(PI/2);
    image(img,0,0);
    tint(255,(shields.size()>0?255:0));
    image(imgU,0,0);
    tint(255,255);
    popMatrix();
    popMatrix();
  }
  
  public void shoot(){
    if (shootCooldown==0 && hitpoints > 0){
      super.shoot();



      
      
    Bullet bullet = new DefenderBullet(pos.x+cos(angle-PI/20)*40, pos.y+sin(angle-PI/20)*40, angle-PI/20, this, false);
    putSpaceObject(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle+TWO_PI/3-PI/20)*40, pos.y+sin(angle+TWO_PI/3-PI/20)*40, angle+TWO_PI/3-PI/20, this, false);
    putSpaceObject(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle-TWO_PI/3-PI/20)*40, pos.y+sin(angle-TWO_PI/3-PI/20)*40, angle-TWO_PI/3-PI/20, this, false);
    putSpaceObject(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle+PI/20)*40, pos.y+sin(angle+PI/20)*40, angle+PI/20, this, false);
    putSpaceObject(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle+TWO_PI/3+PI/20)*40, pos.y+sin(angle+TWO_PI/3+PI/20)*40, angle+TWO_PI/3+PI/20, this, false);
    putSpaceObject(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle-TWO_PI/3+PI/20)*40, pos.y+sin(angle-TWO_PI/3+PI/20)*40, angle-TWO_PI/3+PI/20, this, false);
    putSpaceObject(bullet);
      
      shootCooldown = maxShootCooldown;
    }
  }
  
  public void ultimate(){
    if(ultCooldown>0) return;
    ultCooldown = maxUltCooldown;
    DefenderBullet bullet = new DefenderBullet(pos.x+cos(angle)*25, pos.y+sin(angle)*25, angle, this, true);
    putSpaceObject(bullet);
    shields.add(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle-TWO_PI/3)*25, pos.y+sin(angle-TWO_PI/3)*25, angle-TWO_PI/3, this, true);
    putSpaceObject(bullet);
    shields.add(bullet);
    bullet = new DefenderBullet(pos.x+cos(angle+TWO_PI/3)*25, pos.y+sin(angle+TWO_PI/3)*25, angle+TWO_PI/3, this, true);
    putSpaceObject(bullet);
    shields.add(bullet);
    
  }
  
  void update(){
    super.update();
    ultCooldown = max(0,ultCooldown-fpsAdjust);
        shock = maxShootCooldown/20;
  }
  
  
}
