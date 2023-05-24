public class Collision{
   protected DecorationFactory decorationFactory;
   protected boolean portalFlag;
   protected Timer portalTimer;

   Collision(){
      portalTimer = new Timer();
   }
   
   /**
   * Collision detection between two BasicProp obj
   * Only useful when two objects are rect
   */
   public boolean detect(BasicProp a, BasicProp b){
       if(a.location.x + a.w > b.location.x &&
          a.location.x < b.location.x + b.w &&
          a.location.y + a.h > b.location.y &&
          a.location.y < b.location.y + b.h){
          return true;   
       }
       return false;
   }
   
   /**
   * Collision detection between one BasicProp obj and one block
   * block's position can be calculated by i and j
   */
   public boolean detect(BasicProp a, int i, int j){
       int s = Type.BOARD_GRIDSIZE;
       if(a.location.x + a.w > j * s &&
          a.location.x < j * s + s &&
          a.location.y + a.h > i * s &&
          a.location.y < i * s + s){
          return true;   
       }
       return false;
   }
   
   public boolean detect(BasicProp a, Decoration b){
       if(a.location.x + a.w > b.location.x &&
          a.location.x < b.location.x + b.w &&
          a.location.y + a.h > b.location.y &&
          a.location.y < b.location.y + b.h){
          return true;   
       }
       return false;
   }
   
   
   //added this boolean so that we can turn off collision detection for blocks other than the background
   //if return false, player can through these type of blocks
   //when player, throughDown = p.getThroughDown(), others, checkDown = false && throughDown = true
   public boolean cantThrough(int type, boolean checkDown, ActionProp o){
     if(type == Type.BLOCK_EMPTY || type == Type.BLOCK_CRATE || type == Type.BLOCK_CRATE_OPEN || type == Type.BLOCK_SPIKE){
       return false;
     }
     
     if(type == Type.BLOCK_PLATFORM){
        // o == null - o is bullet or o is fly, can through
        if(o == null || o.fly){
           return false;
        }
        if(checkDown && !o.throughDown){
           return true;
        }else{
           return false;
        }
     }
     return true;
   }
   
   
   public void checkBossAndPlayer(Map map, Player p){
      if(map.enemies.size() ==0) return;
      Enemy boss = map.enemies.get(0);
      Room r = map.getCurrentRoom();
            
        Iterator<Bullet> iterator = r.playerBullets.iterator();
        while(iterator.hasNext()) {
           Bullet b = iterator.next();
           if(detect(boss, b)){
              if(boss.isAlive){
                  //boss.attacked(b.dp, b);
                  decorationFactory.addBulletRemoveGif(r, b);
                  iterator.remove();
              }
           }
        }
        
        if(detect(p, boss) && boss.isAlive){
           p.attacked(boss.dp, boss);
        }
       
       
   }
  
   /**
   * Collision detection between:
   * enemies and blocks,
   * enemies and player
   * enemies and bullets
   * bullets and blocks
   * player and blocks
   */
   public void checkAllAround(Player p, Room r){
      
      //collision detection between enemies and blocks, enemies and player,enemies and bullets
      ArrayList<Enemy> enemies = r.enemies;
      ArrayList<Bullet> bullets = r.playerBullets;
      
       //if b out of board, remove
       for(int j = bullets.size() - 1; j >= 0 ; j--){
           Bullet b = bullets.get(j);
            if(b.location.y >= Type.SCREEN_HEIGHT || b.location.y <= 0 || b.location.x >= Type.SCREEN_WIDTH || b.location.x <= 0){
              bullets.remove(j);
           }
       }
      
      for(int i = enemies.size() - 1; i >= 0; i--){
         Enemy e = enemies.get(i);
         
         //legal position
         if(e.location.x <= 0 || e.location.x + e.w >= width
          || e.location.y <= 0 || e.location.y + e.h >= height
         ){
           e.isAlive = false;
           e.canRemove = true;
           println("out of bound");
         }
         
         
         if(!e.isAlive &&  e.canRemove){
             p.value += e.value;
             enemies.remove(i);
             continue;
         }
         if(isEnemyNeedDetect(e.type)){
             checkAround(e, r);
         }
         if(detect(p,e)){
            p.attacked(e.dp, e);
         }
         for(int j = bullets.size() - 1; j >= 0 ; j--){
             Bullet b = bullets.get(j);
             //check bullets and enemies
             if(detect(b,e)){
                if(e.isAlive){
                    e.attacked(b.dp, b);
                    decorationFactory.addBulletRemoveGif(r, b);
                               if(b.type == Type.BULLET_TYPE_LASER && b.split == false){
                                 float sp = sqrt(b.velocity.x * b.velocity.x + b.velocity.y * b.velocity.y);
                                 Bullet b1 = new Bullet(new PVector(b.location.x + b.w * 2, b.location.y), new PVector(sp, 0), b.w, b.h, b.dp/3);
                                 b1.type = Type.BULLET_TYPE_LASER;
                                 b1.split = true;
                                 bullets.add(b1);
                                 Bullet b2 = new Bullet(new PVector(b.location.x - b.w * 2, b.location.y), new PVector(-sp, 0), b.w, b.h, b.dp/3);
                                 b2.type = Type.BULLET_TYPE_LASER;
                                 b2.split = true;
                                 bullets.add(b2);
                                 Bullet b3 = new Bullet(new PVector(b.location.x, b.location.y + b.h * 2), new PVector(0, sp), b.w, b.h, b.dp/3);
                                 b3.type = Type.BULLET_TYPE_LASER;
                                 b3.split = true;
                                 bullets.add(b3);
                                 Bullet b4 = new Bullet(new PVector(b.location.x, b.location.y - b.h * 2), new PVector(0, -sp), b.w, b.h, b.dp/3);
                                 b4.type = Type.BULLET_TYPE_LASER;
                                 b4.split = true;
                                 bullets.add(b4);
                                 
                               }  
                    bullets.remove(j);          
                }
                break;
             }
         }
      }
      
      //collision detection between bullets and blocks
       //if b crash blocks, remove
         for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(cantThrough(r.blockType[i][j], false, null)
                //&& b.type != Type.BULLETS_THROUGH_WALL
                ){
                       for(int k = bullets.size() - 1; k >= 0 ; k--){
                            Bullet b = bullets.get(k);
                            if(detect(b, i, j)){
                               if(b.type == Type.BULLET_TYPE_LASER && b.split == false){
                                 float sp = sqrt(b.velocity.x * b.velocity.x + b.velocity.y * b.velocity.y);
                                 Bullet b1 = new Bullet(new PVector(b.location.x + b.w * 2, b.location.y), new PVector(sp, 0), b.w, b.h, b.dp/3);
                                 b1.type = Type.BULLET_TYPE_LASER;
                                 b1.split = true;
                                 bullets.add(b1);
                                 Bullet b2 = new Bullet(new PVector(b.location.x - b.w * 2, b.location.y), new PVector(-sp, 0), b.w, b.h, b.dp/3);
                                 b2.type = Type.BULLET_TYPE_LASER;
                                 b2.split = true;
                                 bullets.add(b2);
                                 Bullet b3 = new Bullet(new PVector(b.location.x, b.location.y + b.h * 2), new PVector(0, sp), b.w, b.h, b.dp/3);
                                 b3.type = Type.BULLET_TYPE_LASER;
                                 b3.split = true;
                                 bullets.add(b3);
                                 Bullet b4 = new Bullet(new PVector(b.location.x, b.location.y - b.h * 2), new PVector(0, -sp), b.w, b.h, b.dp/3);
                                 b4.type = Type.BULLET_TYPE_LASER;
                                 b4.split = true;
                                 bullets.add(b4);
                                 
                               }   
                               bullets.remove(k); 
                             }
                       }
                       for(int k = r.enemyBullets.size() - 1; k >= 0 ; k--){
                            Bullet b = r.enemyBullets.get(k);
                            if(detect(b, i, j)){
                                 r.enemyBullets.remove(k);
                             }
                       }
                       for(int k = r.enemyBullets.size() - 1; k >= 0 ; k--){
                            Bullet b = r.enemyBullets.get(k);
                            if(detect(p, b)){
                                 p.attacked(b.dp, b);
                                 r.enemyBullets.remove(k);
                             }
                       }
                }
            }
      }
      checkAround(p, r);
      checkDecorations(p, r);
      checkSpikes(p, r);
   }
   
   
   public void checkDecorations(ActionProp p, Room r){
        Iterator<Decoration> iterator = r.decorations.iterator();
        while(iterator.hasNext()) {
           Decoration d = iterator.next();
           if(d.type ==  Type.GIF_HP || d.type ==  Type.GIF_CRYSTAL){
              if(detect(p, d)){
                 //println(d.type);
                 if(d.type == Type.GIF_HP){
                   //println("check" + p.hp);
                   if(p.hp < p.maxHp){
                      ding.play(2);
                      p.hp += 10;
                      if(p.hp > p.maxHp) p.hp = p.maxHp;
                   //println("check" + p.hp);
                      iterator.remove();
                   }
                 }else{
                   p.value += 200;
                   ding.play(2);
                   iterator.remove();
                 }
              }
           }
           
        }
   }
   
   public void checkSpikes(ActionProp p, Room r){
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
         for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
            if(r.blockType[i][j] == Type.BLOCK_SPIKE && detect(p, i, j) && !p.isInvincible){
                stab.play(2);
                p.attacked(10, null);
                p.isKnockBack = true;
                p.velocity3 = new PVector(p.left ? 5 : -5, -10);
            }
         }
       }
   }
   
   
   public boolean isEnemyNeedDetect(int type){
      if(type == Type.ENEMY_GUNNER){
         return true;
      }
      return false;
   }
   
   
   /**
   * Collision detection between player and blocks
   */
   public void checkAround(ActionProp o, Room r){
      checkLeft(o, r);
      checkRight(o, r);
      checkUp(o, r);
      checkDown(o, r);
      checkMore(o, r);
   }

   public boolean canInteract(int type){
      if(type == Type.BLOCK_CRATE || type == Type.BLOCK_CRATE){
         return true;
      }
      return false;
   }
   
   /**
   * Collision detection between player and blocks above
   */
    public void checkUp(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w;
      float s = Type.BOARD_GRIDSIZE;
      int upper = (int)(y/s) - 1;
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      //all blocks above are !cantThrough(), o can through
      boolean canThrough = true;
      for(int i = L; i <= R && upper >= 0; i++){
         if(cantThrough(r.blockType[upper][i],false,o) && (y + o.getFullVelocityY() <= upper * s + s)){
            canThrough = false;
         }
      }
      if(!canThrough){
          o.setAllVelocityY(0);
          o.fall = false;
          o.location.y = upper * s + s + 1;
      }
   }
 
   /**
   * Collision detection between player and blocks below
   * Changing properties of player by checking whether player is on special blocks.
   */
    public void checkDown(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w, h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int below = (int)((y + h)/s) + 1;
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      boolean canFall = true, canHighJump = false, canUsePortal = false;
      int portalPos = 0;

      //all blocks below are !cantThrough(), o can through
      for(int i = L; i <= R && below < Type.BOARD_MAX_HEIGHT; i++){
         int bType = r.blockType[below][i];
         
         //for all obj
         if(cantThrough(bType,true,o)){
             canFall = false;
         }
         
         //for player
         if(o.type == Type.PLAYER){
             //portal
             if(bType == Type.BLOCK_PORTAL){
                 canUsePortal = true;
                 decorationFactory.portalBlock[0] = i;
                 decorationFactory.portalBlock[1] = below;
                 portalPos = i;
             }
             
             //bounce
             o.highJump = false;
             if(bType == Type.BLOCK_BOUNCE){
                 canHighJump = true;
                 decorationFactory.jumpBlock[0] = i;
                 decorationFactory.jumpBlock[1] = below;
             }
             
             //spike - basic implemenation for now as we don't yet have a death mechanic
             //if(o.fall && (bType == Type.BLOCK_SPIKE)){
             //   stab.play(2);
             //   o.attacked(5, null);
             //}
         }
         
      }
      
       //if enemies, change direction
       if(o.type != Type.PLAYER){
           //make enemy move to right
           if(L >= 0 && o.left && !cantThrough(r.blockType[below][L], false, null)){
              o.left = false;
              o.velocity.x = abs(o.velocity.x);
              o.location.x = L * s + s + 1;
           }
           //make enemy move to left
           if(R < 29 && !o.left && !cantThrough(r.blockType[below][R], false, null)){
               o.left = true;
               o.velocity.x = -abs(o.velocity.x);
               o.location.x = R * s - w - 1;
           }
       }
      
      
      if(!canFall && (o.location.y + h + o.getFullVelocityY() >= below * s)){
            o.fall = false;
            o.jump = false;
            o.doubleJump = false;
            o.canDoubleJump = false;
            o.setAllVelocityY(0);
            o.location.y = below * s - o.h - 1;
           if(o.type == Type.PLAYER){
                 if(o.fallDist > Type.FALL_DAMAGE_DIST){
                     //o.attacked(Type.FALL_DAMAGE, null);
                     o.fallDist = 0;
                     touchGround.play(1);
                     //playerHurt.play(2);
                 }
           }
            
       }else{
             o.fall = true;
             o.jump = true;
       }
       
       if(canHighJump){
           o.highJump = true;
       }
       
       if(canUsePortal){
           o.onPortal = true;
           if(!o.transported){
               Block b = r.getBlockByPos(below , portalPos);
               decorationFactory.addPortalGif(r, new int[]{decorationFactory.portalBlock[0], decorationFactory.portalBlock[1]});
               usePortal(o, b, r);
               o.transported = true;
               return;
           }
       }else{
             o.onPortal = false;
       }
         
   }
   
   /**
   * If player use portal, player's position will be changed
   * according to int[] portal of that portal block
   */
   public void usePortal(ActionProp o, Block b, Room r){
       portal.play(2);
       if(!portalFlag){
           portalFlag = true;
           portalTimer.schedule(new TimerTask(){
              @Override
              public void run() {
               float  s = Type.BOARD_GRIDSIZE;
               int[] portal = b.portal; 
               o.location.y = s * portal[0];
               o.location.x = s * portal[1] + 5;
               decorationFactory.addPortalGif(r, new int[]{portal[1], portal[0]});
               portalFlag = false;
              }
           }, 350);
       }
   }
   
    public void checkLeft(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      
      boolean canMoveForward = true;
      for(int i = U; i <= D && left >= 0; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.blockType[i][left];
            if(o.type != Type.PLAYER){
              if(cantThrough(bType,false,null) && (x + o.getFullVelocityX() * 10 <= left * s + s)){
                 canMoveForward = false;
              }
            }else{
                if(cantThrough(bType,false,null) && (x + o.getFullVelocityX() <= left * s + s)){
                   canMoveForward = false;
                }
            }
      }
      
     if(!canMoveForward){
        if(o.type != Type.PLAYER){
           o.changeDir(false);
        }else{
           o.setAllVelocityX(0);
        }
        o.location.x = left * s + s + 1;
      }
   }
   
   public void checkRight(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w, h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int right = (int)((x + w)/s) + 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      boolean canMoveForward = true;
      for(int i = U; i <= D && right < Type.BOARD_MAX_WIDTH; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.blockType[i][right];
            if(o.type != Type.PLAYER){
              if(cantThrough(bType,false,null) && (x + w + o.getFullVelocityX()*10 >= right * s)){
                  canMoveForward = false;
              }
            }else{
              if(cantThrough(bType,false,null) && (x + w + o.getFullVelocityX() >= right * s)){
                  canMoveForward = false;
              }
            }
      }
      
      if(!canMoveForward){
          if(o.type != Type.PLAYER){
             o.changeDir(true);
          }else{
             o.setAllVelocityX(0);
          }
          o.location.x = right * s - w - 1;
      }
      
   }

   //if still collision, player collides with corner of block, need to reset position
   public void checkMore(ActionProp o, Room r){
        for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(cantThrough(r.blockType[i][j] , false, o) && detect(o, i, j)){
                    float s = Type.BOARD_GRIDSIZE;
                    float y = o.location.y, by = i * s;
                    float  h = o.h;
                   if(y > by && y < by + s){
                        o.setAllVelocityY(0);
                        o.location.y = by + s + 1;
                    }else if(y + h > by && y + h < by + s){
                        o.setAllVelocityY(0);
                        o.location.y = by - h - 1;
                    }
                }
            }
         }
   }

}
