public class Ore extends SpaceObject{
  
  String ext = ".png";
  String sep  = "\\";
  
  PImage img;
  
  public Ore(float x, float y, AsteroidType type){
    super(x,y,0,0,0,1,15,0,0);
    knockbackable = false;
    String name = "";
    this.type = type;
    switch(type){
      case BLUE:
        name = "blue";
        break;
      case RED:
        name = "red";
        break;
      case PURPLE:
        name = "purple";
        break;
      case GREEN:
        name = "green";
        break;
      default:
        return;
    }
    name += "Buff";
    img = loadImage(path + "\\assets" + sep + name + ext);
  }
  
  AsteroidType type;
  
  void iHit(SpaceObject what, boolean first){
    
    if(what.getClass().getSuperclass() == Rocket.class){
      Rocket r =(Rocket)what; 
      r.ores += 1;
      Buff buff;
      switch(type){
        case BLUE:
          buff = new HitpointsBuff(r, 1.025);
          break;
        case RED:
          buff = new DamageBuff(r, 1.05);
          break;
        case PURPLE:
          buff = new CooldownBuff(r, 0.976);
          break;
        case GREEN:
          buff = new AttackSpeedBuff(r, 0.962);
          break;
        default:
          buff = null;
      }
      buff.turnOn();
      r.buffs.add(buff);
      destroyed();
    }
    if(first){
      what.iHit(this,false);
    }
  }
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    image(img,0,0);
    popMatrix();
  }
  
  void destroyed(){
    removeSpaceObject(this);
  }
  
  void destroyedEffect(){}
  
  
}
