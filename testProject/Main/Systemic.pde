static class MySystem{
  static SpaceObject closest(SpaceObject from, Class type){
    float distC = 0;
    SpaceObject closest = null;
    ArrayList<SpaceObject> candidates = get(type);
    for(SpaceObject so : candidates){
      float dist = distance(from,so);
      if((closest==null||dist<distC)&&so!=from){
        distC = dist;
        closest = so;
      }
    }
    return closest;
  }
  
  static float distance(SpaceObject so1, SpaceObject so2){
    return so1.pos.subtract(so2.pos).mag;
  }
  
  static float angleTo(SpaceObject so1, SpaceObject so2){
    float angle = atan((so2.pos.y-so1.pos.y)/(so2.pos.x-so1.pos.x));
    if(so1.pos.x>so2.pos.x) angle+=PI;
    angle = ((angle%TWO_PI)+TWO_PI)%TWO_PI;
    return angle;
  }
  
    static float angleTo(float x1, float y1, float x2, float y2){
    float angle = atan((y2-y1)/(x2-x1));
    if(x1>x2) angle+=PI;
    angle = ((angle%TWO_PI)+TWO_PI)%TWO_PI;
    return angle;
  }
  
  static ArrayList<SpaceObject> get(Class type){
    ArrayList<SpaceObject> candidates = new ArrayList<SpaceObject>();
    for(SpaceObject so : spaceObjects){
      
      if(so.getClass() == type || so.getClass().getSuperclass() == type){
        candidates.add(so);
      }
    }
    return candidates;
  }
}

static class Vect {
  

  
  private Vect(float x, float y, boolean isNormal){
    this.x = x;
    this.y = y;
    calc(isNormal);
  }
  
  float x;
  float y;
  float ang;
  float mag;
  Vect norm;
  
  private void calc(boolean isNormal){
    ang = -(atan2(x,y)-PI/2);
    mag = sqrt(pow(x,2)+pow(y,2));
    if(isNormal) norm = this;
    else norm = new Vect(x/mag,y/mag,true);
  }

  
  public Vect subtract(Vect another){
    return new Vect(x-another.x,y-another.y,false);
  }
  
  public Vect add(Vect another){
    return new Vect(x+another.x,y+another.y,false);
  }
  
  public Vect scale(float scalar){
    return new Vect(x*scalar,y*scalar,false);
  }
  
  public Vect rotate(float ang){
    return newAM(ang+this.ang,mag);
  }
  
  public static Vect newAM(float ang, float mag){
    float x,y;
    x = mag * cos(ang);
    y = mag * sin(ang);
    return new Vect(x,y,false);
  }
    public static Vect newAM(float ang){
    float x,y;
    x = cos(ang);
    y = sin(ang);
    return new Vect(x,y,true);
  }
  public static Vect newXY(float x, float y){
    return new Vect(x,y,false);
  }
  
  public static Vect newXY(float x, float y, boolean isNormal){
    return new Vect(x,y,isNormal);
  }
}
