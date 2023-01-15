public class Game {
  
  int numOfAsteroids = 15;
 

  public void prepareToPlay(){
    //s.stop();
    r1 = new Sniper(maxX/10,9*maxY/10,-PI/4,skins.get("Stardust Sniper"));
    r2 = new Bruiser(9*maxX/10,9*maxY/10,-3*PI/4,skins.get("Magma Bruiser"));
    spaceObjects.clear();
    players.clear();
    gp = GamePhase.PLAY;
    placeAsteroids(numOfAsteroids);
    game.addPlayers(r1,r2);
  }
  
  public void showText(String text, float size, float posx, float posy, float sx, float sy) {
    pushMatrix();
    fill(116, 204, 255);
    textFont(font);
    textSize(size);
    text(text,posx,posy,sx,sy);
    popMatrix();
  }
  
  public void showBox(float posx, float posy, float sx, float sy){
    boxImg.resize((int)sx,(int)sy);
    image(boxImg,posx,posy);
  }
  
  public void showBackground(){
    tint(255,90);
    image(img,maxX/2,maxY/2);
    tint(255,255);
  }
  
  public void adjustFps(){
    fpsAdjust = 60f/frameRate * 0.8;
  }
  
  public void refresh(){
    spaceObjects.removeAll(toDestroy);
    spaceObjects.addAll(toAdd);
    toAdd.clear();
    toDestroy.clear();
  }

  public void placeAsteroids(int n){
    for(int i=0; i<n;i++){
      float size = random(10,50);
      
      float chance = 0.3;
      float speed = random(0.2,0.5);
      float x = random(maxX);
      float y = random(maxY);
      float direction = random(MySystem.angleTo(x,y,maxX,maxY+size),MySystem.angleTo(x,y,0,maxY+size));
      spaceObjects.add(new Asteroid(x,y,speed,direction,chance,size));
    }
  }
  public void restockAsteroids(){
    int m = MySystem.get(Asteroid.class).size();
    for(int i=m; i<numOfAsteroids; i++){
      float size = random(10,50);
      float chance = 0.3;
      float speed = random(0.2,0.5);
      float x = random(maxX);
      float y = -size*0.95;
      float direction = random(MySystem.angleTo(x,y,maxX,maxY+size),MySystem.angleTo(x,y,0,maxY+size));
      
      spaceObjects.add(new Asteroid(x,y,speed,direction,chance,size));
    }
  }
  
  public void addPlayers(Rocket r1){
    spaceObjects.add(r1);
    players.add(new Player1(r1));
  }
  
  public void addPlayers(Rocket r1, Rocket r2){
    spaceObjects.add(r1);
    spaceObjects.add(r2);
    players.add(new Player1(r1));
    players.add(new Player2(r2));
  }
  
  public void addPlayers(Rocket r1, Rocket r2, Rocket r3){
    spaceObjects.add(r1);
    spaceObjects.add(r2);
    spaceObjects.add(r3);
    players.add(new Player1(r1));
    players.add(new Player2(r2));
    players.add(new Player3(r3));
  }
  
  public void addPlayers(Rocket r1, Rocket r2, Rocket r3, Rocket r4){
    spaceObjects.add(r1);
    spaceObjects.add(r2);
    spaceObjects.add(r3);
    spaceObjects.add(r4);
    players.add(new Player1(r1));
    players.add(new Player2(r2));
    players.add(new Player3(r3));
    players.add(new Player4(r4));
  }
  
  public void showAll(){
    for(SpaceObject spaceObject : spaceObjects) {
      spaceObject.show();
    }
  }
  
  public void moveAll(){
    for(SpaceObject spaceObject : spaceObjects) {
      spaceObject.move();
    }
  }
  
  public void detectHits(){
    for(int i = 0; i<spaceObjects.size()-1;i++){
      SpaceObject so1 = spaceObjects.get(i);
      for(int j = i+1; j<spaceObjects.size(); j++){
        SpaceObject so2 = spaceObjects.get(j);
        if(so1.hitpoints>0&&so2.hitpoints>0&&so1!=so2){
          if(so1.size+so2.size>=MySystem.distance(so1,so2)){
            so1.iHit(so2, true);
          }
        }
      }
    }
  }
  
  public void controlRockets(){
    for(Player player : players) {
      player.control();
    }
  }
  
  public void updateAll(){
    for(SpaceObject so : spaceObjects){
      so.update();
    }
  }
  
  public void fadeEffect(){
    for(SpaceObject so : destroyedEffect){
      if(so.fadeEffect>0) so.destroyedEffect();
    }
  }
  
  public void reset(){
    prepareToPlay();
  }
  
  public void addSkins(){
    skins.put("Magma Laser",new Skin("magmaLaser","magmaLaserU", "magmaLaserB", "magmaLaserE"));
    skins.put("Crystal Laser",new Skin("crystalLaser","crystalLaserU", "crystalLaserB", "crystalLaserE"));
    skins.put("Pride Laser",new Skin("prideLaser","prideLaserU", "prideLaserB", "prideLaserE"));
    skins.put("Magma Bruiser",new Skin("magmaBruiser","magmaBruiserU", "magmaBruiserB", "magmaBruiserE"));
    skins.put("Nether Bruiser",new Skin("netherBruiser","netherBruiserU", "netherBruiserB", "netherBruiserE"));
    skins.put("Control Hacker",new Skin("controlHacker","controlHackerU", "controlHackerB", "controlHackerE"));
    skins.put("Poison Hacker",new Skin("poisonHacker","poisonHackerU", "poisonHackerB", "poisonHackerE"));
    skins.put("Pride Hacker",new Skin("prideHacker","prideHackerU", "prideHackerB", "prideHackerE"));
    skins.put("Stardust Sniper",new Skin("stardustSniper","stardustSniperU", "stardustSniperB", "stardustSniperE"));
    skins.put("Void Sniper",new Skin("voidSniper","voidSniperU", "voidSniperB", "voidSniperE"));
    skins.put("Trinity Tracker",new Skin("trinityTracker","trinityTrackerU","trinityTrackerB", "trinityTrackerE","trinityTrackerB2"));
    skins.put("Fungi Tracker",new Skin("fungiTracker","fungiTrackerU","fungiTrackerB", "fungiTrackerE","fungiTrackerB2"));
    skins.put("Sparrow Jumper",new Skin("sparrowJumper","sparrowJumperU","sparrowJumperB", "sparrowJumperE","sparrowJumperB2"));
    skins.put("Stardust Jumper",new Skin("stardustJumper","stardustJumperU","stardustJumperB", "stardustJumperE","stardustJumperB2"));
    //skins.put("Control Defender",new Skin("controlDefender","controlDefenderU","controlDefenderB", "controlDefenderE","controlDefenderB2"));
    skins.put("Thorn Defender",new Skin("thornDefender","thornDefenderU","thornDefenderB", "thornDefenderE","thornDefenderB2"));
  }
}

enum GamePhase {
  BACKSTORY, PLAYERS, PLAY 
}
