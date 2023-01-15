import java.util.HashSet;
import java.util.Arrays;
import processing.sound.*;
import java.time.LocalDateTime;

static String path = "D:\\Data\\Dev\\Finished Projects\\Rocketeer\\testProject";

static float fpsAdjust;
static int maxX;
static int maxY;
static HashSet<Character> keys = new HashSet<Character>();
static ArrayList<SpaceObject> spaceObjects = new ArrayList<SpaceObject>();
static ArrayList<Player> players = new ArrayList<Player>();
ArrayList<SpaceObject> toDestroy = new ArrayList<SpaceObject>();
ArrayList<SpaceObject> toAdd = new ArrayList<SpaceObject>();
static ArrayList<SpaceObject> destroyedEffect = new ArrayList<SpaceObject>();
HashMap<String, Skin> skins = new HashMap<String,Skin>();
String timeShow;
LocalDateTime time; 
String wholeText =
  "Admiral,     \n"+
  "     \n"+
  "In the midst of centuries old intergalactic war between dozens of alien species, an explosion of an ore-rich planet has been detected.     \n"+
  "It was a mining planet that belonged to one of the alien species and was secret prior to the explosion.     \n"+
  "Some of these resources contain rare compounds required to build an ultimate weapon of destruction.     \n" +
  "It's just one piece of the puzzle crucial to win the war, but is nontheless a deciding factor.     \n" +
  "     \n"+
  "Your faithfull commander.";

SoundFile laser;
String currentText = "";
float progression = 0;
PImage img;
PImage boxImg;
PFont font;
GamePhase gp = GamePhase.BACKSTORY;
SoundFile s;
Rocket r1;
Rocket r2;
Rocket r3;
Rocket r4;

Game game = new Game();

void settings(){
  maxX = displayWidth;
  maxY = displayHeight;
  fullScreen();
  //size(maxX,maxY);
}

void setup(){

  game.addSkins();
  //s=new SoundFile(this,"C:\\Users\\Zrinka\\Desktop\\testProject\\assets\\Sounds\\space_atmosphere.mp3");
  //s.amp(0.5);
  //s.play();
  imageMode(CENTER);
  img = loadImage (path + "\\assets\\space2.jpg");
  boxImg = loadImage(path + "\\assets\\box3.png");
  font = loadFont(path + "\\Main\\data\\cons.vlw");
  img.resize(maxX,maxY);
  noStroke();
  rectMode(CENTER);

  laser = new SoundFile(this, path + "\\assets\\Sounds\\laser_shoot.mp3");
  game.placeAsteroids(50);

}
void draw(){

  //ALWAYS
  game.adjustFps();
  
  if(gp == GamePhase.BACKSTORY){
    time = LocalDateTime.now();
    timeShow = time.getHour() + ":" + time.getMinute() + " " + time.getDayOfMonth() + "/" + time.getMonthValue() +"/"+ (time.getYear()+1234);
    game.showBackground();
    game.showAll();
    game.moveAll();
    game.detectHits();
    game.controlRockets();
    game.updateAll();
    game.fadeEffect();
    game.restockAsteroids();
    game.refresh();
    progression += fpsAdjust/3f;
    currentText = wholeText.substring(0,int(min(progression,wholeText.length()))) + (int(progression)%8<4?"|":"");
    game.showBackground();
    game.showBox(maxX/2,maxY/2,3*maxX/4,3*maxY/4);
    game.showText(currentText, 30, maxX/2,maxY/2,maxX/3,maxY/2.25);
    textAlign(CENTER);
    game.showText(timeShow, 40, (7f/8f)*maxX-maxX/5.5,(1f-17f/18f)*maxY+maxY/4.4,maxX/7,maxY/7);
    textAlign(LEFT);
  }
  
  // WHILE GAME IS ON
  if(gp == GamePhase.PLAY)
  {
    game.showBackground();
    game.showAll();
    game.moveAll();
    game.detectHits();
    game.controlRockets();
    game.updateAll();
    game.fadeEffect();
    game.restockAsteroids();
    game.refresh();
  }
}

void putSpaceObject(SpaceObject so){
  toAdd.add(so);
}

void removeSpaceObject(SpaceObject so){
  toDestroy.add(so);
}


void keyTyped(){
  if(key == ' ') {
    if(gp == GamePhase.PLAY) {
      game.reset();
    }
    else if(gp == GamePhase.BACKSTORY) {
      game.prepareToPlay();
    }
    return;
  }
  keys.add(key);
}

void keyReleased(){
  keys.remove(key);
}
