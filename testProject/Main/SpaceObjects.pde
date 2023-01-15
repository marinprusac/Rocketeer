import java.time.LocalTime;
import java.util.Random;

static abstract class SpaceObject {
   
  public SpaceObject(float x, float y, float angle, float engP, float rotP, float hitpoints, float size, float speed, float course){
    this.course = Vect.newAM(course,speed);
    pos = Vect.newXY(x,y);
    gas = Vect.newXY(0,0);
    this.angle = angle;
    maxEngP = engP;
    this.engP = maxEngP;
    maxRotP = rotP;
    this.rotP = maxRotP;
    this.hitpoints = hitpoints;
    this.size = size;
  }
  
  static float drag = 0.05;

  float angle;
  float rotP;
  float maxRotP;
  float engP;
  float maxEngP;
  Vect gas;
  Vect pos;
  Vect course;
  Vect toUpdate = Vect.newXY(0,0);
  
  float mass;
  float hitpoints;
  float size;
  float fadeEffect = 100;
  float fadeEffectMax = 100;
  
  boolean knockbackable = true;
  
  
  
  void update(){
    course = course.add(toUpdate);
    toUpdate = Vect.newXY(0,0);
    if(pos.x+size<0||pos.x-size>maxX||pos.y+size<0||pos.y-size>maxY){
      hitpoints = 0;
    }
    if(hitpoints<=0){
      destroyed();
    }
  }
  
  abstract void destroyedEffect(); 
  
  public abstract void destroyed();
  
  abstract void show();
  
  void move(){
    pos = pos.add(course.scale(fpsAdjust));
  }
  
  void iHit(SpaceObject what, boolean first){
    if(knockbackable&&what.knockbackable){
      float dist = MySystem.distance(this,what);
      float ang = MySystem.angleTo(this,what);
      float comb = size + what.size;
      float diff = comb - dist;
      float sum = mass+what.mass;
      pos = pos.add(Vect.newAM(ang+PI,diff*(what.mass/sum)));
      what.pos = what.pos.add(Vect.newAM(ang,diff*(mass/sum)));
      Vect change = Vect.newXY(0,0);
      float m1 = mass;
      float m2 = what.mass;
      float scalar1 = 2*m2/(m1+m2);
      
      Vect v1 = course.subtract(what.course);
      Vect v2 = pos.subtract(what.pos);
      
      float scalar2 = v1.x * v2.x + v1.y * v2.y;
      float scalar3 = abs(pow(v2.x,2)+pow(v2.y,2));
      change = change.subtract(v2.scale(scalar1*scalar2/scalar3));
      toUpdate = toUpdate.add(change);
    }
    
    if(first) what.iHit(this,!first);
  }

  
}
