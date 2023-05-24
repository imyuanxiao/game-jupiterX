/**
* @author imyuanxiao, participants
* Class for player
* 'useItem()' - change status of player, should be updated
*/
public class Player extends ActionProp{
  
  protected int blinkCount; 
  
  protected float bWidthInc, bHeightInc, bSpeed, bDp;
  protected int bNum;

  protected ArrayList<Item> items;
  protected Item[] weapons;
  protected int currentWeaponIndex;
  protected int currentItemIndex;
  protected boolean isShoot;
  protected boolean isRun;
  
  protected PImage[] hpGif;
  protected float hpGifCount;
  
  protected Timer portalTimer, showFlyTriggerTimer;
  protected boolean showFlyTrigger;
  protected boolean isMinning;
  protected float spInc;
  
  public Player(){
    this.type = Type.PLAYER;    
    this.location = new PVector(width/2, height/2);
    this.w = 24;
    this.h = 34;
    this.hp = 100;
    this.maxHp = hp;
    this.bSpeed = dif.bSpeed;
    this.bDp = dif.bDp;
    this.bNum = dif.bNum;
    this.spInc = 0;
    
    //Timer and blink effects
    this.invincibleTimer = new Timer();
    this.knockBackTimer = new Timer();
    this.blinkCount = 0;
    
    //weapons and items
    this.weapons = new Item[2];
    this.items = new ArrayList();

    this.transported = true;
    //img of heart_zero
    this.img = loadImage("imgs/player/hp.png");
    this.img.resize(Type.BOARD_GRIDSIZE *2/3, Type.BOARD_GRIDSIZE *2/3);
  }
  
  //add weapon
  public void addItem(Item t){
     if(t.category == Type.ITEM_WEAPON){
        weapons[0] = t;
     /*
     }else if(t.getCategory() == Type.ITEM_CRYSTAL)(  //for crystal, not put into the store section, but add score or sth directly
        add score or crystal to player
     */
     }else{ 
        items.add(t);
     }  
  }
  
  public Item getCurrentItem(){
       if(items.size() == 0){
          return null;
       }
       return items.get(currentItemIndex);
  }
  
  
  public void changeItem(){
     if(items.size() == 0){  
        println("no items");
        return;
     }
     //println(this.currentItemIndex);
     this.currentItemIndex = (this.currentItemIndex + 1) % items.size();
     //println("change items: " + currentItemIndex);
     Item cur = this.items.get(currentItemIndex);
     if(cur.showMe == true){
         cur.showMe = false;
         cur.showTimer = new Timer();
     }
     cur.showMe = true;
  }
  
  public void showCurrentItem(){
     if(this.items.size() <= 0) return;
     this.items.get(currentItemIndex).showMe(this.location);
     
     //for(Item t : items){
     //  if(t.showMe && t.id == this.currentItemIndex){
     //     t.showMe(this.location);
     //  }
     //}
  }
  
  public void removeCurrentItem(){
     this.items.remove(currentItemIndex--);
     if(currentItemIndex<0) currentItemIndex = 0;
  }
  
  public void switchWeapon(){
     this.currentWeaponIndex = (this.currentWeaponIndex + 1) % 2;
     this.isMinning = this.isMinning ? false : true;
  }
  

  public void move(){
    
    // println("v1:" + this.velocity.y);
    // println("v2:" + this.velocity2.y);
    // println("v3:" + this.velocity3.y);
    
     this.location.x += this.getFullVelocityX();
     if(this.fly){
         this.location.y +=  this.getFullVelocityY();
     }else{
         if(this.jump){
            this.location.y +=  this.getFullVelocityY();
            if(this.getFullVelocityX() < Type.PLAYER_SPEED_Y) this.velocity.y += Type.PLAYER_SPEED_INCREMENT;
         }
         if(this.getFullVelocityY() == 0){
           this.fallDist = 0;
         }
         float tmp = this.getFullVelocityY();
         if(tmp > 0){
            this.fallDist += tmp;
         }
     }
     
     if(this.isKnockBack){
       knockBackTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            isKnockBack = false;
             velocity3 = new PVector();
          }
       }, 100);
     }
     
     
  }
  
  //if Thorn Potion, e.attacked();
  public void attacked(float dp, ActionProp e){
    if(!isInvincible){
      
       if(e!= null && !e.isAlive){
          return;
       }
       
       //knockback
       if(e != null){
           this.isKnockBack = true;
           PVector direction = PVector.sub(this.location, e.location);
           direction.normalize();
           PVector knockback = direction.mult(10);
           this.velocity3 = knockback;
           playerHurt.play(2);
       }
       
       
       super.attacked(dp);
       //println(dp);
        
       //twinkle
       isInvincible = true;
       invincibleTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            isInvincible = false;
          }
       }, 2000);
    }
  }
  
  public void display(){
    

    if (isInvincible) {
      if (blinkCount < 8) {
        //if (frameCount % 3 == 0) {
          tint(0, 255, 255);
          drawPlayerAndWeapon();
          noTint();
          blinkCount++;
        //}else{
        //  drawPlayerAndWeapon();
        //}
      } 
      else {
        drawPlayerAndWeapon();
        blinkCount = 0;
      }
    } else {
       drawPlayerAndWeapon();
    }
    drawHp();
    drawScore();
    showFly();
    showCurrentItem();
  }
  
  
  public void showFly(){
    
    if(this.showFlyTrigger){
        if(showFlyTriggerTimer == null) showFlyTriggerTimer = new Timer();
        showFlyTriggerTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            showFlyTrigger = false;
          }
       }, 2000);
    }
    
     if(this.showFlyTrigger){
        noTint();
        stroke(0); 
        strokeWeight(1); 
        fill(100, 255,255);
        textSize(32); 
        text(this.fly ? "Fly mode activated! Use W/A/S/D to move" : "Fly mode invalid!", width/3, height/2); 
     }
  
  }
  
  
  public void drawHp(){
      
      for(int j = 0; j < this.maxHp; j += Type.PLAYER_HEART){
         image(this.img, Type.BOARD_GRIDSIZE/2 + (j/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
      }
     
     for(int j = 0; j < this.hp; j += Type.PLAYER_HEART){
         image(hpGif[(int)hpGifCount], Type.BOARD_GRIDSIZE/2 + (j/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
         this.hpGifCount = (hpGifCount + 0.01) % (float)hpGif.length;
      }
      
  }
  
   public void drawScore(){
      noTint();
      fill(125, 255,255);
      textSize(25); 
      textAlign(LEFT, TOP);
      image(score, Type.BOARD_GRIDSIZE/2-10, 49);
      text(this.value, Type.BOARD_GRIDSIZE/2+50, Type.BOARD_GRIDSIZE *3/2 - 2); 
  }
  
  public void drawPlayerAndWeapon(){
    drawGif();
  }
  
  public float getAngle() {
    float dx = mouseX - (location.x + w/2);
    float dy = mouseY - (location.y + h/2);
    return atan2(dy, dx);
  }
  
  public PVector getBulletLocation() {
   
    PVector direction = new PVector(mouseX - (this.location.x + this.w / 2), mouseY - (this.location.y + 14));

    direction.setMag(17);
    
    PVector target = new PVector(this.location.x + this.w / 2, this.location.y + 14);
    
    target.add(direction);
    
    return target;
  }
  
  public void drawGif(){
       drawLower();
       drawUpper();
  }
  
  //0 shoot, 1 stand_left, 2 stand_right,  3 run_left, 4 run_right, 5 jump_left, 6 jump_right
  public void drawLower(){
       int gifType = 0;
       //if(Math.abs(getFullVelocityY()) > 2){
       //  //jump 
       //  gifType = this.left ? 5 : 6;
       //  image(this.gifsImgs.get(gifType)[0], location.x - 4, location.y - 3, 32, 37);
       //}else 
       if(this.isRun && !this.fly){
         gifType = this.left ? 3 : 4;
         //run
         image(this.gifsImgs.get(gifType)[(int)this.gifsImgsCount[gifType]], location.x - 4, location.y - 3, 32, 37);
         this.gifsImgsCount[gifType] = (this.gifsImgsCount[gifType] + Type.GIF_PLAY_SPEED) % (float)this.gifsImgs.get(gifType).length;
       }else{
         //stand
         gifType = this.left ? 1 : 2;
         image(this.gifsImgs.get(gifType)[0], location.x - 4, location.y - 3, 32, 37);
       }
       
  }
  
  public void drawUpper(){
    PImage[] gif = this.gifsImgs.get(isMinning ? 7 : 0);
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mousePos, new PVector(location.x + w/2, location.y + h/2)).normalize();
    float angle = degrees(dir.heading());
    int frameIndex = round(map(angle, -180, 180, 0, 47));
    image(gif[frameIndex], location.x - 4, location.y - 3, 32, 37);
  }

  public void addGifsImgs(PImage[]... gifs){
    if(this.gifsImgs == null) this.gifsImgs = new ArrayList();
    int cnt = 0;
    for(PImage[] gif : gifs){
       cnt++;
      for(int i = 0; i < gif.length; i++){
          //player 26, 34, gif 32, 37
          gif[i].resize(32, 37);
       }
       this.gifsImgs.add(gif);
    }
    this.gifsImgsCount = new float[cnt];
  }
  
}
