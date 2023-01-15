class Tracker extends Rocket {
  
  public Tracker(int x, int y, float angle, Skin skin){
    super(x,y, angle, skin, 3, 0.05, 40, 30, 1);
    secondaryDmg = 3;
    maxUltCooldown = 10;
  }
  
  int index = 0;
  boolean first = true;
  Rocket selected = null;
  float angleToEnemy;


  
  public void show(){
    super.show();
    pushMatrix();
    translate(pos.x,pos.y);
    pushMatrix();
    rotate(angle);
    rotate(PI/2);    
    image(img,0,0);
    tint(255,(selected!=null&&selected.hitpoints>0?255:0));
    image(imgU,0,0);
    tint(255,255);
    popMatrix();
    pushMatrix();
    if(selected!=null && selected.hitpoints>0){
      angleToEnemy = MySystem.angleTo(this,selected);
      angle = ((angle%TWO_PI) + TWO_PI)%TWO_PI;
      pushMatrix();
      rotate(angleToEnemy);
      fill(200, 60, 70);
      triangle(40,15,40,-15,50,0);
      popMatrix();
    }
    popMatrix();
    popMatrix();
  }
  
  public void shoot(){
    if (shootCooldown==0 && hitpoints > 0){
      super.shoot();
      
      if(selected == null || !(selected.hitpoints>0)) selected = null;
        
      if(selected==null){
        Bullet bullet = new TrackerBullet(pos.x+cos(angle+PI/4)*25, pos.y+sin(angle+PI/4)*25, angle, this, selected);
        putSpaceObject(bullet);
        bullet = new TrackerBullet(pos.x+cos(angle-PI/4)*25, pos.y+sin(angle-PI/4)*25, angle, this, selected);
        putSpaceObject(bullet);
        shootCooldown = maxShootCooldown;
      }
      else{
        Bullet bullet = new TrackerBullet(pos.x+cos(angle)*30, pos.y+sin(angle)*30, angle, this, selected);
        putSpaceObject(bullet);
        shootCooldown = maxShootCooldown*3;
      }
    }
  }
  
  public void ultimate(){
    if(ultCooldown>0) return;
    ultCooldown = maxUltCooldown;
    ArrayList<SpaceObject> rockets = MySystem.get(Rocket.class);
    if(first) index = rockets.indexOf(this);
    else if(selected!=null&&selected.hitpoints<=0) index = (index+1)%rockets.size();
    first = false;
    index = (index+1)%rockets.size();
    if(rockets.get(index)==this){
      selected = null;
      return;
    }
    selected = (Rocket)rockets.get(index);
    
  }
  
  void update(){
    super.update();
    ultCooldown = max(0,ultCooldown-fpsAdjust);
  }
  
  
}
