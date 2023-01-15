class CooldownBuff extends Buff{
  
  float amount;
  public CooldownBuff(Rocket effected, float amount){
    super(effected);
    this.amount = amount;
  }
  
  void turnOff(){
    effected.maxUltCooldown *= 1f/amount;
  }
  
  void turnOn(){
    effected.maxUltCooldown *= amount;
  }
}

class HitpointsBuff extends Buff{
  
  float amount;
  public HitpointsBuff(Rocket effected, float amount){
    super(effected);
    this.amount = amount;
  }
  
  void turnOff(){
    effected.maxHP *= 1f/amount;
  }
  
  void turnOn(){
    effected.maxHP *= amount;
  }
}

class AttackSpeedBuff extends Buff{
  
  float amount;
  public AttackSpeedBuff(Rocket effected, float amount){
    super(effected);
    this.amount = amount;
  }
  
  void turnOff(){
    effected.maxShootCooldown *= 1f/amount;
  }
  
  void turnOn(){
    effected.maxShootCooldown *= amount;
  }
}

class DamageBuff extends Buff{
  
  float amount;
  public DamageBuff(Rocket effected, float amount){
    super(effected);
    this.amount = amount;
  }
  
  void turnOff(){
    effected.primaryDmg *= 1f/amount;
    effected.secondaryDmg *= 1f/amount;
  }
  
  void turnOn(){
    effected.primaryDmg *= amount;
    effected.secondaryDmg *= amount;
  }
}


public abstract class Buff {
  
  public Buff(Rocket effected){
    this.effected = effected;
    
  }
  
  Rocket effected;
  abstract void turnOn();
  abstract void turnOff();
  
}
