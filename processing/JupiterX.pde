//need install: tools > manage tools> libraries > GifAnimation
import gifAnimation.*;
import ddf.minim.*;


Controller controller;
View view;

IntList pkeys = new IntList(); 

// Menu
Minim minim;
AudioPlayer bgMusic, click, shoot, enemyHurt,  trampoline, portal, stab, 
playerHurt, mining, enemyShoot, touchGround, ding, gameOver;

// SoundFile bgMusic;
PImage bgImg, optionImg, optionMuteImg, rankImg, gameoverImg, helpImg;
PImage inGameHome, inGameMute, inGamePause,inGameHelp, inGamePausePage, score;
PImage easy, normal, hard,musicOn, musicOff, returnBtn;

Difficulty dif;

ArrayList<Record> records = new ArrayList();

boolean canReset = false;


/**
* Initialize all project, run once
*/
void setup(){
    
    //records.add(new Record("Arlo", 100));
    //records.add(new Record("Cla", 200));
    //records.add(new Record("Eva", 990));
    //records.add(new Record("Arlo", 100));
    //records.add(new Record("Cedric", 200));
    //records.add(new Record("Eva", 50));
    //records.add(new Record("David", 120));
    //records.add(new Record("Nina", 90));
    //records.add(new Record("Cedric", 200));
    //records.add(new Record("Eva", 50));
    //records.add(new Record("David", 120));
    //records.add(new Record("Nina", 90));
 
    size(1160,800);
    dif = new Difficulty();
        
    Model model = new Model();
    
    EnemyFactory e = new EnemyFactory();
    GifsToEenemyFactory(e);
    model.enemyFactory = e;
    //model.addBossToMap();
    ItemFactory t = new ItemFactory();
    Player p = new Player();
    p.weapons[0] = t.weaponPistol();
    p.weapons[1] = t.weaponMinergun();
    GifsToPlayer(p);
    
    DecorationFactory d = new DecorationFactory();
    GifsToDecorationFactory(d);
    d.addDecorationToRoom(model.map.rooms.get(0));
    model.addPlayer(p);
    model.itemFactory = t;
    model.decorationFactory = d;
    
    initMenu();
    if (model.isMusicPlaying){
      bgMusic.play();
    }
    
    controller = new Controller(model);
    //Collision c = new Collision(g);
    //controller.collision = c;
    view = new View(this, model,p);

}

void reset(){
    canReset = false;
    
    boolean music = controller.getIsMusicPlaying();
    int difficulty = controller.getDifficulty();
    Model newModel = new Model();
    
    EnemyFactory e = new EnemyFactory();
    GifsToEenemyFactory(e);
    newModel.enemyFactory = e;
    
    //model.addBossToMap();
    ItemFactory t = new ItemFactory();
    Player p = new Player();
    p.weapons[0] = t.weaponPistol();
    p.weapons[1] = t.weaponMinergun();
    GifsToPlayer(p);
    
    DecorationFactory d = new DecorationFactory();
    GifsToDecorationFactory(d);
    d.addDecorationToRoom(newModel.map.rooms.get(0));
    newModel.addPlayer(p);
    newModel.itemFactory = t;
    newModel.decorationFactory = d;
    
    //if (newModel.isMusicPlaying){
    //  bgMusic.play();
    //}
    
    controller.model = newModel;
    controller.setIsMusicPlaying(music);
    if (difficulty == 2){
      controller.setDifficulty();
    } else if (difficulty == 3){
      controller.setDifficulty();
      controller.setDifficulty();
    }
    controller.collision.decorationFactory = newModel.decorationFactory;
    
    view.model = newModel;
    view.mvc = this;
    view.p = p;

    pkeys = new IntList(); 
    
}


/**
* Code inside will run by order in each frame
*/
void draw(){
    
    mouseListener();
    keyListener();

    controller.display();
    view.paint();
  
}

public void GifsToPlayer(Player p){
  
     //0 shoot, 1 stand_left, 2 stand_right,  3 run_left, 4 run_right, 5 jump_left, 6 jump_right
     PImage[] playerShoot = Gif.getPImages(this, "imgs/player/shoot.gif");
     PImage[] playerShootMine = Gif.getPImages(this, "imgs/player/shoot_mine.gif");

     PImage[] playerStand = Gif.getPImages(this, "imgs/player/stand_left.gif");
     PImage[] playerStand2 = Gif.getPImages(this, "imgs/player/stand_right.gif");

     PImage[] playerRun = Gif.getPImages(this, "imgs/player/run_left.gif");
     PImage[] playerRun2 = Gif.getPImages(this, "imgs/player/run_right.gif");

     PImage[] playerJump = Gif.getPImages(this, "imgs/player/jump_left.gif");
     PImage[] playerJump2 = Gif.getPImages(this, "imgs/player/jump_right.gif");


     p.addGifsImgs(playerShoot, playerStand, playerStand2, playerRun, playerRun2, playerJump, playerJump2, playerShootMine);
     
     PImage[] hpGif = Gif.getPImages(this, "imgs/player/hp.gif");
     for(PImage hp : hpGif){
         hp.resize(Type.BOARD_GRIDSIZE *2/3, Type.BOARD_GRIDSIZE *2/3);
     }
     p.hpGif = hpGif;
     
}

/**
* Load all gifs for enemies
*/
public void GifsToEenemyFactory(EnemyFactory e){
     //gifs for gunner
     ArrayList<PImage[]> gunnerGifs = new ArrayList();
     PImage[] gunner = Gif.getPImages(this, "imgs/enemy/gunner.gif");
     PImage[] gunnerDeath = Gif.getPImages(this, "imgs/enemy/gunnerDeath.gif");

     gunnerGifs.add(gunner);
     gunnerGifs.add(gunnerDeath);

     ArrayList<PImage[]> alienFlyGifs = new ArrayList();
     PImage[] alienFly = Gif.getPImages(this, "imgs/enemy/fly1.gif");
     PImage[] alienFlyDeath = Gif.getPImages(this, "imgs/enemy/fly2.gif");
     alienFlyGifs.add(alienFly);
     alienFlyGifs.add(alienFlyDeath);
     
     ArrayList<PImage[]> alienSpiderGifs = new ArrayList();
     PImage[] alienSpider = Gif.getPImages(this, "imgs/enemy/spider.gif");
     PImage[] alienSpiderDeath = Gif.getPImages(this, "imgs/enemy/spider.gif");
     alienSpiderGifs.add(alienSpider);
     alienSpiderGifs.add(alienSpiderDeath);

     ArrayList<PImage[]> alienKillerGifs = new ArrayList();
     PImage[] alienKiller = Gif.getPImages(this, "imgs/enemy/boss1.gif");
     PImage[] alienKillerDeath = Gif.getPImages(this, "imgs/enemy/boss1.gif");
     alienKillerGifs.add(alienKiller);
     alienKillerGifs.add(alienKillerDeath);

     //gifs for others...

     e.addEnemyGifs(gunnerGifs, alienFlyGifs, alienSpiderGifs, alienKillerGifs);
}

/**
* Load all gifs for enemies
*/
public void GifsToDecorationFactory(DecorationFactory d){
     //gifs for gunner
     PImage[] jumpEffect = Gif.getPImages(this, "imgs/effect/jump_effect.gif");
     PImage[] portalEffect = Gif.getPImages(this, "imgs/effect/portal_effect.gif");
     PImage[] blood = Gif.getPImages(this, "imgs/effect/blood.gif");
     PImage[] pressE = Gif.getPImages(this, "imgs/effect/pressE.gif");
     PImage[] crystal = Gif.getPImages(this, "imgs/decoration/d1.gif");
     PImage[] hp = Gif.getPImages(this, "imgs/decoration/d2.gif");
     PImage[] d3 = Gif.getPImages(this, "imgs/decoration/d3.gif");
     PImage[] arrow_down = Gif.getPImages(this, "imgs/decoration/arrow_down.gif");
     PImage[] arrow_left = Gif.getPImages(this, "imgs/decoration/arrow_left.gif");
     PImage[] arrow_right = Gif.getPImages(this, "imgs/decoration/arrow_right.gif");
     PImage[] arrow_up = Gif.getPImages(this, "imgs/decoration/arrow_up.gif");
     
     d.addDecorationGifs(jumpEffect, portalEffect, blood, pressE, crystal, hp, d3, arrow_down, arrow_left, arrow_right, arrow_up);
}


public void initMenu(){

    // Menu
    bgImg = loadImage("Data/imgs/menu/background.png");
    helpImg = loadImage("Data/imgs/menu/helpPage.png");
    optionImg = loadImage("Data/imgs/menu/option.png");
    gameoverImg = loadImage("Data/imgs/menu/gameover.png");
    optionMuteImg = loadImage("Data/imgs/menu/option_mute.png");
    rankImg = loadImage("Data/imgs/menu/rank.png");
    inGameHome = loadImage("Data/imgs/menu/exit.png");
    inGameHelp = loadImage("Data/imgs/menu/helpBtn.png");
    inGameMute = loadImage("Data/imgs/menu/music.png");
    inGamePause = loadImage("Data/imgs/menu/pause.png");
    inGamePausePage = loadImage("Data/imgs/menu/pausePage.png");
    score = loadImage("Data/imgs/menu/score.png");
    
    easy = loadImage("Data/imgs/menu/easy.png");
    normal = loadImage("Data/imgs/menu/normal.png");
    hard = loadImage("Data/imgs/menu/hard.png");
    musicOn = loadImage("Data/imgs/menu/music_on.png");
    musicOff = loadImage("Data/imgs/menu/music_off.png");
    returnBtn = loadImage("Data/imgs/menu/return.png");
    
    minim = new Minim(this);
    bgMusic = minim.loadFile("Data/music/bgmusic.mp3");
    bgMusic.setGain(-10);
    
    gameOver = minim.loadFile("Data/music/gameOver.mp3");
    gameOver.setGain(-5);
    
    click = minim.loadFile("Data/music/click.mp3");
    click.setGain(-8);
    shoot = minim.loadFile("Data/music/shoot.mp3");
    shoot.setGain(-18);
    portal = minim.loadFile("Data/music/portal.wav");
    portal.setGain(-5);
    enemyHurt = minim.loadFile("Data/music/enemyHurt.wav");
    //enemyHurt.setGain(-5);
    playerHurt = minim.loadFile("Data/music/playerHurt.wav");
    playerHurt.setGain(-5);
    mining = minim.loadFile("Data/music/mining.wav");
    enemyShoot = minim.loadFile("Data/music/enemyShot.wav");
    touchGround = minim.loadFile("Data/music/touchGround.wav");
    ding = minim.loadFile("Data/music/ding.wav");
    stab = minim.loadFile("Data/music/stabbed.mp3");
    stab.setGain(-3);
    trampoline = minim.loadFile("Data/music/trampoline.wav");

}

/**
* Processing can not record two keys at one time,
* so we have to use a list to record keys
*/
public void keyListener(){

    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
  
    if(pkeys.size()== 0) return;
    
    for(int i=pkeys.size()-1; i>=0; i--){
      if(validKey(pkeys.get(i))){
        if(pkeys.hasValue(Type.KEY_S) && pkeys.hasValue(Type.KEY_SPACE)){
          controller.controlPlayer(Type.KEY_S_SPACE);
        }else{
          controller.controlPlayer(pkeys.get(i));
        }
        
      }      
    }
    
}

public boolean validKey(int value){
  if(value == Type.KEY_D 
  || value == Type.KEY_A 
  || value == Type.KEY_SPACE
  || value == Type.KEY_W
  || value == Type.KEY_S
  ){
  return true;
  }
  return false;
}


public void keyPressed(){
  
    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
    
    key = Character.toLowerCase(key);
    
    //use WASD to move
    if(!pkeys.hasValue(int(key))) {
      pkeys.append(int(key));
    }
    
}

public void keyReleased(){
  
   key = Character.toLowerCase(key);

   if(key == 'p' && controller.getGameStart()){
      controller.setGamePause(controller.getGamePause() ? false : true);
    }
  
    //only work when game starts
    if(!controller.getGameStart()  || controller.getGamePause()){
        return;
    }
    //use WASD to move
    for(int i=pkeys.size()-1; i>=0; i--){
      if(pkeys.get(i) == int(key)){
          pkeys.remove(i); 
      }
    }
    
    if((int)key == 32){
        controller.controlPlayer(Type.KEY_RELEASED_SPACE);
    }
    
    if(key == 'w'){
        controller.controlPlayer(Type.KEY_RELEASED_SPACE);
    }
    
    if(key == 'a' || key == 'd'){
      controller.controlPlayer(Type.KEY_RELEASED_AD);
    }
    if(key == 'w' || key == 's'){
      controller.controlPlayer(Type.KEY_RELEASED_WS);
    }
    //if(key == 'f'){
    //  controller.controlPlayer(Type.KEY_F);
    //}
    if(key == 'e'){
      controller.controlPlayer(Type.KEY_E);
    }
    if(key == 'q'){
      controller.controlPlayer(Type.KEY_Q);
    }
    if(key == 'r'){
      controller.controlPlayer(Type.KEY_R);
    }
    
    
    
}

public void mouseListener(){
   //only work when game starts
   if(controller.getGameStart() && !controller.getGamePause()){
        if(mousePressed == true && mouseButton == LEFT){
           controller.shotBullet();
        }
    }

}

public void mouseReleased(){
    
  if(controller.getMenuHomePage()){
    //check mouse position, if in position and released, change booleans in model
    
    //// Game over test TO BE DELETED!!!!!!!
    //if (mouseX > 0 && mouseX < 400 && mouseY > 0 && mouseY < 200) {
    //  controller.setMenuHomePage(false);
    //  controller.setGameOver(true);
    //}
    
    
    // Clicked on Start
    if (mouseX > 192 && mouseX < 420 && mouseY > 100 && mouseY < 197) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setGameStart(true);
      controller.setInGame(true);
    }
    // Clicked on help
    if (mouseX > 192 && mouseX < 420 && mouseY > 228 && mouseY < 325) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setHelpPage(true);
    }
    // Click Option
    if (mouseX > 192 && mouseX < 420 && mouseY > 355 && mouseY < 452) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setMenuControl(true);
    }
    
    // Click history ranking
    if (mouseX > 192 && mouseX < 420 && mouseY > 478 && mouseY < 574) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setGlobalList(true);
    }
    
    // Click Quit
    if (mouseX > 192 && mouseX < 420 && mouseY > 602 && mouseY < 698) {
      click.play(2);
      exit();
    }
    
  } else if (controller.getHelpPage()){
    if (mouseX > 827 && mouseX < 1061 && mouseY > 598 && mouseY < 695) {
      click.play(2);
      // In game
      if (controller.getInGame()){
        controller.setHelpPage(false);
        controller.setGameStart(true);
      } else{
        controller.setHelpPage(false);
        controller.setMenuHomePage(true);
      }
    }
  
  } else if(controller.getMenuControl()){
     // Difficulty switch
    if (mouseX > 462 && mouseX < 696 && mouseY > 209 && mouseY < 306) {
      click.play(2);
      controller.setDifficulty();
      switch (controller.getDifficulty()){
        case 0: 
          dif.easyMode();
          break;
        case 1:
          dif.normalMode();
          break;
        case 2:
          dif.hardMode();
          break;
        default:
          break;
      }
    }
         
    // Switch Music ON/OFF
    if (mouseX > 462 && mouseX < 696 && mouseY > 329 && mouseY < 426) {
      if (controller.getIsMusicPlaying()) {
        click.play(2);
        bgMusic.pause();
        controller.setIsMusicPlaying(false);
      } else {
        click.play(2);
        bgMusic.play();
        controller.setIsMusicPlaying(true);
      }
      // isOptionMenuOpen = false;
    }
    
    // Return button
    if (mouseX > 462 && mouseX < 696 && mouseY > 448 && mouseY < 545) {
      click.play(2);
      controller.setMenuControl(false);
      controller.setMenuHomePage(true);
    }
    
  }
  else if(controller.getGlobalList()){
     //there should be a return button in this menu
   if (mouseX > 462 && mouseX < 696 && mouseY > 620 && mouseY < 717) {
      click.play(2);
      controller.setGlobalList(false);
      controller.setMenuHomePage(true);
    }
  }
  
  else if(controller.getGamePause()){
      //there should be a restart button in this menu
      if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
        click.play(2);
        controller.setGameStart(true);
        controller.setGamePause(false);
      }
  }
  
  else if(controller.getGameOver()){
      //there should be a restart button in this menu
      
      // player gameOver music

      // Restart
      
      /*
      if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
        
        //reset game
        this.reset();
        controller.model.menuHomePage = false;
        controller.setGameStart(true);
        controller.setGameOver(false);
      }
      */  
  }
  //only work when game starts
  else{
    // In game menu
    // Help
    if (mouseX > 890 && mouseX < 943 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      controller.setGameStart(false);
      controller.setHelpPage(true);
    }
    // Homepage button
    if (mouseX > 1100 && mouseX < 1153 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      controller.setGameStart(false);
      controller.setMenuHomePage(true);
      reset();
      //if(canReset){
      //      reset();
      //}
    }
    // Pause
    if (mouseX > 1030 && mouseX < 1083 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      if (controller.getGameStart()){
        controller.setGameStart(false);
        controller.setGamePause(true);
      } else {
        controller.setGameStart(true);
        controller.setGamePause(false);
      }
    }
    // Music ON/OFF
    if (mouseX > 960 && mouseX < 1013 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      if (controller.getIsMusicPlaying()){
        bgMusic.pause();
        controller.setIsMusicPlaying(false);
      } else {
        bgMusic.play();
        controller.setIsMusicPlaying(true);
      }
    }
        
    if(mouseButton == LEFT){
        controller.controlPlayer(Type.MOUSE_LEFT);
        if(mining.isPlaying()){
           mining.pause();
        }
    }
    if(mouseButton == RIGHT){
        controller.controlPlayer(Type.MOUSE_RIGHT);
    }
  }
}

public void mousePressed(){
  
}


public void setRankingData(String name, Integer score){
  this.records.add(new Record(name, score));
}

void stop(){
  bgMusic.close();
  minim.stop();
  
  super.stop();
}
