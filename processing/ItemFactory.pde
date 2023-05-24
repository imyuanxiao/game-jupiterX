/**
* @author YWang0727, imyuanxiao
* Factory for item generation (randomly)
* For weapons, method 'shot()' (and other functions if needed) in this class should be overrided by creating an anonymous inner class in construcotr.
* How bullet moves should be reconsidered. Currently, bullets will move faster if shot upward.
* 
* For consumables such as potions, method 'useItem()' in Player.class should be refactored to change status of player temporarily
* For outfit, whick can permanently change status of player, method 'useItem()' or new method in Player.class should be set
* For coins, which should directly add score instead of being added to any class
*/
public class ItemFactory extends Factory{
    
    protected ArrayList<PImage> weaponImgs;
    protected ArrayList<PImage> potionImgs;
    //protected ArrayList<PImage> outfitImgs;
    
    protected int potionCd;
    protected Timer spTimer;
    protected Timer flyTimer;
    protected boolean isActive;
    
    /* for potion CD if needed
    protected int lastTime0 = 0;
    protected int lastTime1 = 0;
    protected int lastTime2 = 0;
    */

    public ItemFactory(){
       this.id = 0;
       this.weaponImgs = new ArrayList();
       this.potionImgs = new ArrayList();
       //this.coinImgs = new ArrayList();
       this.init(); 
       
       this.potionCd = 5000;
       this.spTimer = new Timer();
       this.flyTimer = new Timer();
       this.isActive = false;
    }
    
    /**
    * add all imgs of items
    */
    protected void init(){
       // imgs of weapons
       //weaponImgs.add(loadImage("imgs/items/weapon/0_1.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/0_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/0_3.png")); 
       weaponImgs.add(loadImage("imgs/items/bullet/01.png")); 

       //weaponImgs.add(loadImage("imgs/items/weapon/1_1.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/1_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/1_3.png")); 
       weaponImgs.add(loadImage("imgs/items/bullet/11.png")); 

   
       //weaponImgs.add(loadImage("imgs/items/weapon/2_1.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/2_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/2_3.png")); 
       weaponImgs.add(loadImage("imgs/items/bullet/21.png")); 


       // imgs of consumables
       potionImgs.add(loadImage("imgs/items/potion/0.png"));
       potionImgs.add(loadImage("imgs/items/potion/1.png"));
       potionImgs.add(loadImage("imgs/items/potion/2.png"));       
       

    }
    
    /*
    public boolean checkCD(int lastTime){
       int currentTime = millis();
       int elapsed = currentTime - lastTime;
       if (elapsed < potionCd) {
          println("Item is on cooldown. Remaining time: " + (potionCd - elapsed) + "ms");
          return false;
       }
       return true;
    }*/
    
    //all effects of items can be written here
    public void useItemByPlayer(Player p){
        Item t = p.getCurrentItem();
         if(t == null){
            println("no items");
            return;
         }
         if(t.category == Type.ITEM_POTION){
            if(t.type == Type.POTION_HP){
                if(p.maxHp + Type.POTION_HP_EFFECT <= 200){
                   p.maxHp = p.maxHp + Type.POTION_HP_EFFECT; 
                }else{
                   p.hp = p.hp + Type.POTION_HP_EFFECT;
                }
                //println("use hp potion, id: " + t.id + ", playerHp: " + p.hp);
            }else if(t.type == Type.POTION_SP){
                //println("use sp potion, id: " + t.id);
                if(!isActive){
                   isActive = true;
                   p.spInc = Type.PLAYER_SPEEDINC;
                   spTimer.schedule(new TimerTask(){
                     @Override
                     public void run(){
                       p.spInc = 0;
                       println("sp off");
                       isActive = false;
                     }
                  }, 5000);
               }
            }else{
               println("use fly potion, id: " + t.id);
                if(!isActive){
                   isActive = true;
                   p.fly = true;
                   p.jump = false;
                   p.fall = false;
                   p.velocity.y = 0;
                   if(p.showFlyTrigger == false) p.showFlyTrigger = true;
                   else return;
                   flyTimer.schedule(new TimerTask(){
                     @Override
                     public void run(){
                       p.fly = false;
                       p.jump = true;
                       p.fall = true;
                       println("fly off");
                       isActive = false;
                     }
                  }, 8000);
               }
            }
         }
         p.removeCurrentItem();
    }
    
    public Item newItem(int[] pos, boolean tutorial){
       int r = (int)random(14);
       //r = 0;
       Item t = null;
       if (tutorial){
         t = weaponShotgun();
       }else 
       if(r >= 0 && r <= 3){   
           t = newWeapon();
       }else if(r > 3 && r <= 9){
            //randomly generate a new potion
           t = newPotion();
       }else{
           t = newCrystal();
       }
       //
       //else if(category == Type.ITEM_PERMANENT){
       //    item = newOutfit();
       //}
       
       if(t != null){
         //t.pos = pos;
         t.location = new PVector(pos[1] * Type.BOARD_GRIDSIZE, pos[0] * Type.BOARD_GRIDSIZE);
         //println(t.location);
         t.id = this.id;
         this.increaseId();
       }
       return t;
    }
    
    //new-hand weapon
    public Item weaponPistol(){
       //overload shot method
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 5, 1, 500, Type.BULLET_TYPE_PISTOL);
       //set category and type
       t.category = Type.ITEM_WEAPON;
       t.type = Type.WEAPON_PISTOL;
       
       //remember to set width and height
       t.w = Type.BOARD_GRIDSIZE*2/3;
       t.h = Type.BOARD_GRIDSIZE*2/3;
       //set PImage and resize them
       t.setImgs(weaponImgs.get(t.type));

       //setId
       t.id = this.id;
       this.increaseId();
       
       return t;
    }
    
   
    //new-hand weapon
    public Item weaponMinergun(){  //Player comes with own miner gun initially
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 10, 1, 250, Type.BULLET_TYPE_MINER);
       t.category = Type.ITEM_WEAPON;
       t.type = Type.WEAPON_MINER;

       //Type must be set
       //get PImage and resize them
       t.w = Type.BOARD_GRIDSIZE*2/3;
       t.h = Type.BOARD_GRIDSIZE*2/3;
       //t.setImgs(weaponImgs.get(t.type));
       t.id = this.id;
       this.increaseId();
       return t;
    }
    
    //randomly generate a new weapon
    public Item newWeapon( ){
       //randomly generate a weapon
       int r = (int)random(10);
       //r = 6; 
       Item t = null;
       if(r >=0 && r <= 5){     
          t =  weaponShotgun();
       }else{
          t =  weaponLaser();
       } 
       //each wapon may have different size, so this part of code can be moved to their generation function
       
       //set category
       t.category = Type.ITEM_WEAPON;
       return t;
    }
    

    public Item weaponShotgun(){
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 5, 3, 600, Type.BULLET_TYPE_SHOT);
       t.type = Type.WEAPON_SHOTGUN;
       t.w = Type.BOARD_GRIDSIZE*2/3;
       t.h = Type.BOARD_GRIDSIZE*2/3;
       t.setImgs(weaponImgs.get(t.type));

       return t;
    }
    
    public Item weaponLaser(){
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 10, 1, 500, Type.BULLET_TYPE_LASER);
       t.type = Type.WEAPON_LASER;

       t.w = Type.BOARD_GRIDSIZE*2/3;
       t.h = Type.BOARD_GRIDSIZE*2/3;

       //get PImage and resize them
       t.setImgs(weaponImgs.get(t.type));


       return t;
    }
    
    public Item newPotion(){
       //randomly generate a potion
       int r = (int)random(10);
       //r = 2;
       Item t = null;
       if(r >= 0 && r <= 4){ 
          t =  potionHp();
       }else if(r > 4 && r <= 7){
          t =  potionSp();
       }else{
          t =  potionFly(); 
       }
       
       //set category
       t.category = Type.ITEM_POTION;
       return t; 
    }
    
    public Item potionFly(){
        Item t = new Item();
        t.type = Type.POTION_FLY;
        t.w = Type.BOARD_GRIDSIZE*2/3;
        t.h = Type.BOARD_GRIDSIZE*2/3;
        t.setImgs(potionImgs.get(t.type));

        return t;
    }
    
    public Item potionHp(){
        Item t = new Item();
        t.type = Type.POTION_HP;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE*2/3;
        t.setImgs(potionImgs.get(t.type));

        return t;
    }
    
    public Item potionSp(){
        Item t = new Item();
        t.type = Type.POTION_SP;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE*2/3;
        t.setImgs(potionImgs.get(t.type));
        return t;
    }
    
    //randomly generate a new crystal
    public Item newCrystal( ){
        Item t = new Item();
        t.category = Type.ITEM_CRYSTAL;
        t.type = Type.CRYSTAL;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE * 2/3;
        t.value = 500;
        PImage img = loadImage("imgs/items/crystal.png");
        t.setImgs(img);
        return t;
    }
    
    
}
