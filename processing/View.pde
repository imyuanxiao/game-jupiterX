/**
* @author imyuanxiao
* @participant arlo
* Class for painting. This class will draw everything for each frame by getting data from Model.class.
* Next stage: finish draw*() methods behind
*/

import controlP5.*;


ControlP5 cp5;
Textfield playerNameInput;
boolean inputFieldCreated = false;

public class View{
  protected Model model;
  JupiterX mvc; 
  Player p;
  PImage danger;
  
  public View(JupiterX mvc, Model model, Player p){
     this.model = model;
     this.mvc = mvc;
     this.p = p;
     danger = loadImage("imgs/menu/danger.png");
     danger.resize(225, 50);
  }
  
  /**
  * Includes all methods to run in each frame
  */
  public void paint(){
    if(model.menuHomePage){
       drawMenuHomePage();
    }else if(model.helpPage){
      drawHelpPage();
    }else if(model.menuControl){
       drawMenuControl();
    }else if(model.globalList){
       drawGlobalList();
    }else if(model.gamePause){
       drawGamePause();
    }else if(model.gameOver){
      drawGameOver();
    }else if(model.gameStart){
         
         drawRoom();
         //drawGhost();
         drawBoss();
         drawPlayer();
         
         //showAround(model.player);
         drawRoomBeforePlayer();
         // Draw in game menu
         drawInGameMenu();
         
         //image(this.instructionImg,0,0);
         //drawRoomNumber();
         drawDifficultyLevel();
         
    }
         
  }
  
  public void drawBoss(){
    if(model.map.enemies.size() <= 0) return;
     Enemy boss = model.map.enemies.get(0);
     boss.move(model.player.location);
     boss.display();
  }
 
  /**
  * Draw blocks, enemies, and bullets in current room
  */
  public void drawRoom(){
     Room r = model.getCurrentRoom();  
    colorMode(HSB, 360, 100, 100);
    float hue = sin(r.tint) * 180 + 180;
     ArrayList<PImage> imgs = model.blockFactory.imgs;
     //draw room
     for(int i = 0; i < 20; i++){
        for(int j = 0; j < 29; j++){
          int type = r.blockType[i][j];
          if(emptyBack(type)){
             tint(hue, 100, 100);
             image(imgs.get(Type.BLOCK_EMPTY), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
             noTint();
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }else if(wallBack(type)){
             tint(hue, 100, 100);
             image(imgs.get(Type.BLOCK_WALL), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
             noTint();
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }else{
             tint(hue, 100, 100);
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }
        }
      }
      noTint();
      //colorMode(RGB);
      r.display(model.player);
      //remove crystal
      r.removeBlockByPos(model.player);
      
      if(r.index == 0 && !r.isTutorial){
         addTutorialToStartRoom(r);
      }
      
  }

  public void drawRoomNumber(){
  
      translate(0, 0);
      noTint();
      stroke(0); 
      strokeWeight(1); 
      fill(255);
      textSize(32); 
      textAlign(RIGHT, TOP);
      text("Room Num: " + this.model.roomFactory.id, Type.BOARD_GRIDSIZE * (Type.BOARD_MAX_WIDTH - 1) + Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE *3/2); 

  
  }
  
  public void drawDifficultyLevel(){
      // Draw Difficulty btn
      if(model.isTutorial){
        return;
      }
      if (controller.getDifficulty()==0){
        image(easy, 170, 60, 64, 30);
      } else if (controller.getDifficulty()==1){
        image(normal, 170, 60, 64, 30);
      } else {
        image(hard, 170, 60, 64, 30);
      }
        
      fill(60, 255, 255);
      textSize(21); 
      textAlign(LEFT, TOP);
      image(danger, Type.BOARD_GRIDSIZE/2-10, Type.BOARD_GRIDSIZE * 5/2);
      text("Danger Level: " + dif.lastLevel, Type.BOARD_GRIDSIZE/2+50, Type.BOARD_GRIDSIZE * 5/2 + 10); 
      
  }


   public void drawRoomBeforePlayer(){
     Room r = model.getCurrentRoom();  
     r.drawGifBeforePlayer();
   }

  public boolean emptyBack(int type){
     if(type == Type.BLOCK_SPIKE || type == Type.BLOCK_PLATFORM
     || type == Type.BLOCK_CRATE || type == Type.BLOCK_CRATE_OPEN ){
       return true;
     }
     return false;
  }

  public boolean wallBack(int type){
     if(type == Type.BLOCK_CRYSTAL || type == Type.BLOCK_BOUNCE
     || type == Type.BLOCK_PORTAL){
       return true;
     }
     return false;
  }


  public void drawPlayer(){
      Player p = model.player;
      p.display();
      Item w = p.weapons[p.currentWeaponIndex];
      if(p.isShoot && w.type == Type.WEAPON_MINER){
         w.minerLaser(p.getBulletLocation(), model.getCurrentRoom());
      }
  }
  

  
     /**
   * Game start menu should be written here
   */
   public void drawMenuHomePage(){
     textAlign(CENTER, CENTER);
     textSize(64);
     // Draw background Image
     image(bgImg, 0, 0, width, height);
     
     /*
      // Draw Head
      fill(255);
      text("Main Menu", width/2, height/4);
      
      // Draw Game Start Button
      rectMode(CENTER);
      fill(0, 255, 0);
      rect(width/2, height*1/2, 200, 60);
      fill(255);
      textSize(32);
      text("Start", width/2, height*1/2);
      
      // Draw Option Button
      rectMode(CENTER);
      fill(0, 255, 0);
      rect(width/2, height*3/4, 200, 60);
      fill(255);
      textSize(32);
      text("Option", width/2, height*3/4);
      */
      
      
     // Tutorial?
     
     // Collection
     
     // History Ranking
     
     // Quit
   }
   
   public void drawHelpPage(){
     image(helpImg, 0, 0, width, height);
     //image(returnBtn, 825, 625);
   }
   
   
   // Appear during game when press "ESC"?
   public void drawMenuControl(){
     textAlign(CENTER, CENTER);
     textSize(64);
      // Draw background Image
      image(optionImg, 0, 0, width, height);
      
      // Draw Difficulty btn
      if (controller.getDifficulty()==0){
        image(easy, 462, 209);
      } else if (controller.getDifficulty()==1){
        image(normal, 462, 209);
      } else {
        image(hard, 462, 209);
      }
      
      if (model.isMusicPlaying){
        image(musicOn, 462, 329);
      } else {
        image(musicOff, 462, 329);
      }
      
      image(returnBtn, 462, 448);
      
     /*
     // Draw Music control Button
      rectMode(CENTER);
      if (model.getIsMusicPlaying()) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rect(width/2, height/4, 200, 60);
      fill(255);
      textSize(16);
      text("Music", width/2, height/4);
      
      // Draw Return Button
      fill(0, 255, 0);
      rect(width/2, height/2, 200, 60);
      fill(255);
      textSize(16);
      text("Return", width/2, height/2);
      */
      
   }
   
   // Menu when game is paused 
   public void drawGamePause(){
    tint(255, 6);
    image(inGamePausePage,0,0);
    noTint();
   }
   
   // When player lose all HP
   public void drawGameOver(){
     
     bgMusic.pause();

     gameOver.play();

     image(gameoverImg, 0, 0, width, height);
     
     textSize(32);
     textAlign(CENTER, CENTER);
     String scoreString = str(p.value);
     text(scoreString, width/2, height/2-30);
     
     // Create input field for entering the player's name
    if (!inputFieldCreated) {
      cp5 = new ControlP5(mvc);
      playerNameInput = cp5.addTextfield("")
         .setPosition(width / 2 - 100, 520)
         .setSize(200, 50)
         .setAutoClear(false)
         .setColorBackground(color(255, 255, 255)) // Set background color to white
         .setColorForeground(color(240, 240, 240)) // Set foreground color to light gray
         .setColorActive(color(200, 200, 200)) // Set active color to gray
         .setColorValue(color(0, 0, 0)) // Set text color to black
         .setFont(createFont("Arial", 32)) // Set the font to Arial and make it larger (24pt)
         .setVisible(false); // Initially hide the input field
      inputFieldCreated = true;
    }
    
    playerNameInput.setVisible(true); // Show the input field when game over
      
   //// Restart
   //   rect(width/2, height*3/4, 200, 60);
   //   fill(255);
   //   textSize(16);
   //   text("Restart?", width/2, height*3/4);
     
   // Check Global Ranking
   
   // Quit
     // Detect click on the "Restart" button
   
   // RESTART
   //if (mousePressed && mouseX > 460 && mouseX < 727 && mouseY > 439 && mouseY < 477) {
   //   // Save the player's name and score to the ranking string
   //   String playerName = playerNameInput.getText();
   //   playerNameInput.clear();
   //   String updatedRankingData = playerName + ":" + "100" + ";";
   //   //playerName += updatedRankingData;
   //   setRankingData(updatedRankingData);
      
   //   controller.setGameOver(false);
   //   gameOver.pause();
   //  if (gameOver.position() > 0){
   //    gameOver.rewind();
   //  }
   //   controller.setGameStart(true);
   //   bgMusic.rewind();
   //   bgMusic.play();
   //   playerNameInput.setVisible(false); // Hide the input field after restarting
   // }
    
    // SUBMIT
   if (mousePressed && mouseX > 447 && mouseX < 711 && mouseY > 628 && mouseY < 716) {
      click.play(2);

     // Save the player's name and score to the ranking string
      String playerName = playerNameInput.getText();
      if (playerName.length()>0){
        playerNameInput.clear();
        // String updatedRankingData = playerName + ":" + scoreString + ";";
        
        //playerName += updatedRankingData;
        setRankingData(playerName, p.value);
        
        controller.setGameOver(false);
        mvc.reset();
        gameOver.pause();
       if (gameOver.position() > 0){
         gameOver.rewind();
       }
        controller.setMenuHomePage(true);
        controller.setInGame(false);
        bgMusic.rewind();
        bgMusic.play();
        playerNameInput.setVisible(false); // Hide the input field after restarting        
      }

    }
     
    /* 
  if (mousePressed && dist(mouseX, mouseY, width / 2, height * 3 / 4) < 100) {
    // Save the player's name and score to the ranking string
    String playerName = playerNameInput.getText();
    playerNameInput.clear();
    String updatedRankingData = playerName + ":" + "100" + ";";
    //playerName += updatedRankingData;
    setRankingData(updatedRankingData);

    // Restart the game or go to the homepage
    // ...
    controller.setGameOver(false);
    controller.setMenuHomePage(true);
    playerNameInput.setVisible(false); // Hide the input field after restarting
  }
  */
   
   }
   
   // Afer game finished, the marking ranking
   // Also can be accessed from Home Page Menu

   public void drawGlobalList(){
    
    ArrayList<Record> sortedRecords = sortRecordsByMarksDescending(mvc.records);
    drawTop10Records(sortedRecords);
    
    image(returnBtn, 462, 620);

  }
    
  void drawTop10Records(ArrayList<Record> sortedRecords) {
    
    image(rankImg, 0, 0, width, height);

    //noStroke(); 
    //fill(128,128,128,128);
    //rect(380, 0, 400, height);

    fill(0); // Set text color to black
    textSize(40); // Set text size to 24 pixels
    textAlign(CENTER, CENTER);
  
    int counter = 0;
    float lineHeight = 50;
    
    float startY = height / 2 - (Math.min(sortedRecords.size(), 10) * lineHeight) / 2-20;
    
    if (sortedRecords.size()==0){
      text("No records", width / 2, startY + (counter * lineHeight));
    }
    for (Record record : sortedRecords) {
      if (counter >= 10) {
        break;
      }
      String text = (counter + 1) + ": " + record.name + " " + record.marks;
      text(text, width / 2, startY + (counter * lineHeight));
      counter++;
    }
  }
  
  ArrayList<Record> sortRecordsByMarksDescending(ArrayList<Record> records) {
    Collections.sort(records, new Comparator<Record>() {
      public int compare(Record r1, Record r2) {
        return Integer.compare(r2.marks, r1.marks);
      }
    });
    return records;
  }
    

   
   public void drawInGameMenu(){

     image(inGameHome, 1100, 10, 53, 37);
     image(inGamePause, 1030, 10, 53, 37);
     image(inGameMute, 960, 10, 53, 37);
     image(inGameHelp, 890, 10, 53, 37);
   }
   
   public void addTutorialToStartRoom(Room r){
       
       for(int i = 1; i < Type.BOARD_MAX_HEIGHT - 1; i++){
           for(int j = 1; j < Type.BOARD_MAX_WIDTH - 1; j++){
              if(r.blockType[i][j] == Type.BLOCK_CRYSTAL && r.blockType[i - 1][j] != Type.BLOCK_SPIKE){
                 fill(120, 255,255);
                 drawHelp(i,j, "crystal");
              }
              else if(r.blockType[i][j] == Type.BLOCK_SPIKE && r.blockType[i][j - 1] != Type.BLOCK_SPIKE){
                 fill(120, 0,255);
                 drawHelp(i,j, "spike");
              }
              else if(r.blockType[i][j] == Type.BLOCK_CRATE){
                 fill(60, 255,255);
                 drawHelp(i,j, "crate");
              }
              else if(r.blockType[i][j] == Type.BLOCK_PORTAL){
                  fill(190, 255,255);
                  drawHelp(i,j, "portal");
              }else if(r.blockType[i][j] == Type.BLOCK_PLATFORM && r.blockType[i][j - 1] != Type.BLOCK_PLATFORM){
                  fill(120, 0,255);
                  drawHelp(i,j, "platfrom");
              }
              
          }
       }
        
    }
    
    
    public void drawHelp(int i, int j, String s){
      //stroke(3,255,255); 
      //strokeWeight(5); 
      //fill(200, 0,255);
      
      textSize(18); 
      textAlign(LEFT, TOP);
      
      text(s, j * Type.BOARD_GRIDSIZE, (i-1)* Type.BOARD_GRIDSIZE); 
      noStroke();
      noFill();
    }
   
   
}
  
  
  
  ///**
  //* Show collision detection range, can be deleted
  //*/
  //public void showAround(BasicProp o){
  //     showLeft(o);
  //     showRight(o);
  //     showUp(o);
  //     showDown(o); 
  // }

  //public void drawRect(float i, float j, float s){
  //   noFill();
  //   strokeWeight(1);
  //   rect(j * s, i * s, s, s);
  //}

  //  public void showUp(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int upper = (int)(y/s) - 1;
      
  //    int L = (int)(x/s) ;
  //    int R = (int)((x+w)/s);
  //    stroke(255);
  //    for(int i = L; i <= R; i++){
  //          drawRect(upper, i, s);
  //    }
  // }
 
  //  public void showDown(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w, h = o.h;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int below = (int)((y + h)/s) + 1;
  //    int L = (int)(x/s) ;
  //    int R = (int)((x+w)/s);
  //    stroke(255);
  //    for(int i = L; i <= R; i++){
  //          drawRect(below, i, s);
  //    }
      
  // }
 
  //  public void showLeft(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float h = o.h;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int left = (int)(x/s) - 1;
      
  //    int U = (int)(y/s) ;
  //    int D = (int)((y+h)/s);
  //    stroke(155);
  //    for(int i = U; i <= D; i++){
  //          drawRect(i, left, s);
  //    }
  // }
   
  // public void showRight(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w;
  //    float s = Type.BOARD_GRIDSIZE;
  //          float h = o.h;

  //    int right = (int)((x + w)/s) + 1;
      
  //    int U = (int)(y/s) ;
  //    int D = (int)((y+h)/s);
  //    stroke(155);
  //    for(int i = U; i <= D; i++){
  //          drawRect(i, right, s);
  //    }
  // }
   
//}
