/**
* @author imyuanxiao
* Get and change data from model. Most of functions related to real-time processing are here.
* Collision detections and player controls are here.
*/
public class Controller{
   protected Model model;
   //protected int bulletTimer;
   protected Collision collision;
   //protected GifPlayer gifPlayer;
   
   public Controller(Model mod){
      this.model = mod;
      this.collision = new Collision();
      collision.decorationFactory = model.decorationFactory;
      //this.bulletTimer = Type.BULLET_CD_SHORT;
   };
   
   /**
   * Includes all methods to run in each frame
   */
   public void display(){
      
      //only work when game starts
      if(model.gameStart){
          changeRoomAndPlayerPos();
          Player p = model.player;
          Room r = model.getCurrentRoom();
          collision.checkAllAround(p, r);
          p.move();
          model.addBossToMap();
          
          //boss and player
          collision.checkBossAndPlayer(model.map, model.player);
          dif.increaseByTime(model.player);
          
          if(p.hp <= 0){
             model.gameStart = false;
             model.gameOver = true;
             canReset = true;
          }
          
      }
      
      //if(model.gameOver){
         
      
      //}

     
   }
   
   /**
   * Check player's direction and use corresponding method
   */
   public void changeRoomAndPlayerPos(){
      Player p = model.player;
      if(p.location.x <= 0){
         goLeft(p, p.w);
         if(model.map.enemies.size() >0){
             model.map.enemies.get(0).location.x += width;
         }
      }else if(p.location.x + p.w > width){
         goRight(p); 
         if(model.map.enemies.size() >0){
         model.map.enemies.get(0).location.x -= width;
         }
      }else if(p.location.y < 0){
         goUp(p, p.h);
         if(model.map.enemies.size() >0){
         model.map.enemies.get(0).location.y += width;
         }
      }else if(p.location.y + p.h > height){
         goDown(p);
         if(model.map.enemies.size() >0){
         model.map.enemies.get(0).location.y -= width;
         }
      }
      //println(model.map.getCurrentRoom().type);
   }
  
   /**
   * If going left, set current room index in Model.class
   * change position of player and ghost
   */
   public void goLeft(Player p, float sx){
       this.generateLeft();
       int index =model.getIndexByDirection(Type.TO_LEFT);         
       model.setCurrentRoomIndex(index);
       p.location.x = width - sx - 1;
   }
   
   /**
   * Similar to the previous method, but the direction is to the right
   */
   public void goRight(Player p){
       this.generateRight(); 
       int index =model.getIndexByDirection(Type.TO_RIGHT);
       model.setCurrentRoomIndex(index);
       p.location.x = 1;
   }
   
   /**
   * Similar to the previous method, but the direction is upward
   */
   public void goUp(Player p, float sy){
       this.generateUp(); 
       int index =model.getIndexByDirection(Type.TO_UP);
       model.setCurrentRoomIndex(index);
       p.location.y = height - sy -1;
   }
   
   /**
   * Similar to the previous method, but the direction is downward
   */
   public void goDown(Player p){
       this.generateDown(); 
       int index =model.getIndexByDirection(Type.TO_DOWN);
       model.setCurrentRoomIndex(index);
       p.location.y = 1;
   }
   
   public void addElements(Room newRoom){
       model.enemyFactory.addEnemiesToRoom(newRoom);
       model.decorationFactory.addDecorationToRoom(newRoom);
   }
   
   /**
   * Get current room info, if no room on the left, generate one on the left
   * if there is already on room on the left, just return index of that room
   */
   public void generateLeft(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.adjacent;
      if(adjacent[Type.TO_LEFT] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM, curRoom.index});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,newRoom.index,Type.NO_ROOM});
         addElements(newRoom);
      }
   }
   
   /**
   * Similar to the previous method, but the direction is to the right
   */
   public void generateRight(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.adjacent;
      if(adjacent[Type.TO_RIGHT] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,curRoom.index,Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM, newRoom.index});
         addElements(newRoom);
      }
   }
   
   /**
   * Similar to the previous method, but the direction is upward
   */
   public void generateUp(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.adjacent;
      if(adjacent[Type.TO_UP] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_UP);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,curRoom.index,Type.NO_ROOM,Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{newRoom.index,Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM});
         addElements(newRoom);
      }
   }
   
   /**
   * Similar to the previous method, but the direction is downward
   */
   public void generateDown(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.adjacent;
      if(adjacent[Type.TO_DOWN] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_DOWN);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{curRoom.index,Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,newRoom.index,Type.NO_ROOM,Type.NO_ROOM});
         addElements(newRoom);
      }
   }
     
        /**
   * If player use portal, player's position will be changed
   * according to int[] portal of that portal block
   */
   public void interact(BasicProp o){
      Room r = model.getCurrentRoom();
      
       //pick up items
      ArrayList<Item> items = r.items;
      for(int i = items.size() - 1; i >= 0; i--){
        Item t = items.get(i);
        if(collision.detect(o, t)){
            Player p = model.player;
            //println("pick up item");
            items.remove(i);
            //if crystal
            if(t.category == Type.ITEM_CRYSTAL){
              p.value += t.value;
              continue;
            }
            /*
            //change weapon
            if(t.category == Type.ITEM_WEAPON){
               Item tmp = p.weapons[0];
               tmp.location = t.location;
               items.add(tmp);
            }*/
            p.addItem(t);
            break;
         }
     }
      
      //open crate
      for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
          for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
              if(r.blockType[i][j] == Type.BLOCK_CRATE && collision.detect(o, i, j)){
                r.items.add(model.newItem(new int[]{i, j}));
                r.blockType[i][j] = Type.BLOCK_CRATE_OPEN;
              }
          }
       }
   }
  
 
     
   /**
   * set properties of player according to different key passed in
   */
   public void controlPlayer(int keyType){
     Player p = model.player;
     
     //move left by set speedX
     if(keyType == Type.KEY_A){
        if(mousePressed == false) p.left = true;
        p.velocity.x = -Type.PLAYER_SPEED_X;
        p.velocity3.x = -p.spInc;
        p.isRun = true;
     }
    
     //move right by set speedX
     if(keyType == Type.KEY_D){
        if(mousePressed == false) p.left = false;
        p.velocity.x = Type.PLAYER_SPEED_X;
        p.velocity3.x = p.spInc;
        p.isRun = true;
     }
     
     //stop move left/right
     if(keyType == Type.KEY_RELEASED_AD){
        p.velocity.x = 0;
        p.velocity2.x = 0;
        p.velocity3.x = 0;
        p.isRun = false;
     }
     
     //activate or cancel fly mode
     /*
     if(keyType == Type.KEY_F){
       if(p.showFlyTrigger == false) p.showFlyTrigger = true;
       else return;
       //cancel fly mode
       if(p.fly){
          p.fly = false;
          p.jump = true;
          p.fall = true;
       }else{
          p.fly = true;
          p.jump = false;
          p.fall = false;
          p.velocity.y = 0;
       }
     }*/
     
     //stop move up/down
     if(keyType == Type.KEY_RELEASED_WS){
       if(p.fly){
          p.velocity.y = 0;
       }else{
          p.velocity2.x = 0;
       }
     }
     
     if(keyType == Type.KEY_S_SPACE){
        p.throughDown = true;
        return;
     }else{
        p.throughDown = false;
     }
     //not in fly mode
     if((keyType == Type.KEY_SPACE || keyType == Type.KEY_W) && !p.fly){
        if(p.jump && p.doubleJump){
          return;
        };
        if(p.highJump){
          trampoline.play(2);
          model.decorationFactory.addJumpGif(model.getCurrentRoom());
          p.velocity.y = -Type.PLAYER_HIGH_JUMP_SPEEDY;
        }
        else{
          if(!p.jump){
            p.jump = true;
            p.velocity.y = -Type.PLAYER_JUMP_SPEEDY;
          }else if(!p.doubleJump && p.canDoubleJump){
            p.doubleJump = true;
            p.velocity.y = -Type.PLAYER_JUMP_SPEEDY;
          }
          p.fall = true;
        }
     }
     
     
     if(keyType == Type.KEY_RELEASED_SPACE){
         if(!p.fly){
            p.canDoubleJump = true;
         }
     }
     
     
     // W - speed up or move upward
     if(keyType == Type.KEY_W){
       //in fly mode, move upward
       if(p.fly){
          p.velocity.y = -Type.PLAYER_SPEED_Y/2;
       }
       //not fly, speed up
       else{
         //not in fly mode
            if(p.jump && p.doubleJump){
              return;
            };
            if(p.highJump){
              trampoline.play(2);
              model.decorationFactory.addJumpGif(model.getCurrentRoom());
              p.velocity.y = -Type.PLAYER_HIGH_JUMP_SPEEDY;
            }
            else{
              if(!p.jump){
                p.jump = true;
                p.velocity.y = -Type.PLAYER_JUMP_SPEEDY;
              }else if(!p.doubleJump && p.canDoubleJump){
                p.doubleJump = true;
                p.velocity.y = -Type.PLAYER_JUMP_SPEEDY;
              }
              p.fall = true;
            }
       }
     }
     
     
      // S - slow down or move upward
      if(keyType == Type.KEY_S){
        //in fly mode, move down
        if(p.fly){
           p.velocity.y = Type.PLAYER_SPEED_Y/2;
        }
        // not fly, slow down
       else{
         if(p.left && p.velocity.x != 0){
             p.velocity2.x = Type.PLAYER_SPEED_X * 2/3;
         }else if(p.velocity.x != 0){
             p.velocity2.x = -Type.PLAYER_SPEED_X * 2/3;
         }
       }
    }

     // E - use to interact with props
     if(keyType == Type.KEY_E){
       if(p.onPortal){
            p.transported = false;
       }
        //interact with items
        interact(p);
       
     }
     
     if(keyType == Type.KEY_Q){
        p.changeItem();
     }
     
     if(keyType == Type.MOUSE_RIGHT){
        model.useItemByPlayer();
     }
     
     if(keyType == Type.MOUSE_LEFT){
        p.isShoot = false;
     }
     
     if(keyType == Type.KEY_R){
        p.switchWeapon();
     }
     
   }
   
   /**
   * Add a bullet to ArrayList<Bullet> in current room
   */
   public void shotBullet(){
      Player p = model.player;
      if(mouseX < p.location.x + p.w/2){
        p.left = true;
      }else{
        p.left = false;
      }
      p.isShoot = true;
      Room r = model.getCurrentRoom();
      Item w = p.weapons[p.currentWeaponIndex];
      if(w.type != Type.WEAPON_MINER){
         w.shot(r, p.getBulletLocation(), p.bWidthInc, p.bHeightInc, p.bDp, p.bSpeed, p.bNum);
      }
   }
   
   public void setIsMusicPlaying(boolean flag){
       model.isMusicPlaying = flag;
   }
   
   public boolean getIsMusicPlaying(){
       return model.isMusicPlaying;
   }
   
   public void setMenuHomePage(boolean flag){
       model.menuHomePage = flag;
   }
   
   public boolean getMenuHomePage(){
       return model.menuHomePage;
   }
   
   public void setHelpPage(boolean flag){
       model.helpPage = flag;
   }
   
   public boolean getHelpPage(){
       return model.helpPage;
   }
   
   public void setMenuControl(boolean flag){
       model.menuControl = flag;
   }
   
   public boolean getMenuControl(){
       return model.menuControl;
   }
   
   public void setGameStart(boolean flag){
       model.gameStart = flag;
   }
   
   public boolean getGameStart(){
       return model.gameStart;
   }
   
   public void setGamePause(boolean flag){
       model.gamePause = flag;
   }
   
   public boolean getGamePause(){
       return model.gamePause;
   }
   
   public void setGameOver(boolean flag){
       model.gameOver = flag;
   }
   
   public boolean getGameOver(){
       return model.gameOver;
   }
   
   public void setGlobalList(boolean flag){
       model.globalList = flag;
   }
   
   public boolean getGlobalList(){
       return model.globalList;
   }
   
   public void setDifficulty(){
     model.difficulty = (model.difficulty+1)%3;
   }
   
   public Integer getDifficulty(){
       return model.difficulty;
   }
   
    public void setInGame(boolean flag){
       model.inGame = flag;
   }
   
   public boolean getInGame(){
       return model.inGame;
   }
   
}
