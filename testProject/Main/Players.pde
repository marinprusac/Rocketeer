static abstract class Player {
  
  public Player(Rocket r){
    myRocket = r;
  }
  
  public Rocket myRocket;
  public abstract void control();
}

class Player1 extends Player {
  
  public Player1(Rocket r){
    super(r);
  }
  
  public void control(){
    if(keyPressed){
      if (keys.contains('a')){
        myRocket.rocketRotate(false);
      }
      if (keys.contains('d')){
        myRocket.rocketRotate(true);
      }
      if (keys.contains('w')){
        myRocket.shoot();
      }
      if (keys.contains('s')){
        myRocket.ultimate();
      }
    }
  }
  
}

class Player2 extends Player {
  
  public Player2(Rocket r){
    super(r);
  }
  
  public void control(){
    if(keyPressed){
      if (keys.contains('j')){
        myRocket.rocketRotate(false);
      }
      if (keys.contains('l')){
        myRocket.rocketRotate(true);
      }
      if (keys.contains('i')){
        myRocket.shoot();
      }
      if (keys.contains('k')){
        myRocket.ultimate();
      }
    }
  }
}

class Player4 extends Player {
  
  public Player4(Rocket r){
    super(r);
  }
  
  public void control(){
    if(keyPressed){
      if (keys.contains('f')){
        myRocket.rocketRotate(false);
      }
      if (keys.contains('h')){
        myRocket.rocketRotate(true);
      }
      if (keys.contains('t')){
        myRocket.shoot();
      }
      if (keys.contains('g')){
        myRocket.ultimate();
      }
    }
  }
}

class Player3 extends Player {
  
  public Player3(Rocket r){
    super(r);
  }
  
  public void control(){
    if(keyPressed){
      if (keys.contains('4')){
        myRocket.rocketRotate(false);
      }
      if (keys.contains('6')){
        myRocket.rocketRotate(true);
      }
      if (keys.contains('8')){
        myRocket.shoot();
      }
      if (keys.contains('5')){
        myRocket.ultimate();
      }
    }
  }
}

abstract class AI extends Player {
  
  public AI(Rocket r){
    super(r);
  }
  
  public abstract void control();
}
