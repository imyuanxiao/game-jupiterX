/**
* @author participants, imyuanxiao
* Class for Gunner, who can shot toward player
* When bullets touch player, player hp decrease, this can be realized by adding a new ArrayList in Room.class and another collision detection in Controller.class
*/
public class Gunner extends Enemy{

    PVector targetLocation;
   
    private int lastShootTime = 0; 
   private int shootInterval = 2000;

  
    public Gunner(float hp, float dp){
      this.type = Type.ENEMY_GUNNER;
      this.velocity = new PVector(Type.ENEMY_SPEED_X_NORMAL, 0);
      this.w = (int)(Type.BOARD_GRIDSIZE + 10);
      this.h = (int)(Type.BOARD_GRIDSIZE + 10);
      this.hp = hp;
      this.maxHp = hp;
      this.dp = dp;
      this.value = 300;
    }
    
    
    //200 = attack range
    public void move(PVector playerLocation, Room r){
         if(!isAlive){ return;};
        float distance = PVector.dist(location, playerLocation);
        
        int currentTime = millis();
        if(isAlive && distance <= 200  && currentTime - lastShootTime >= shootInterval){
          PVector velocity = PVector.sub(playerLocation, location);
          velocity.normalize().mult(5);
          left = playerLocation.x < location.x;
          shot(velocity, r);
          lastShootTime = currentTime; 
        }else{
           super.move();
        }
        
        if(this.velocity.x > 0){
           this.left = false;
        }
        if(this.velocity.x < 0){
           this.left = true;
        }
        float x = this.location.x;
        float y = this.location.y;
        if(x <= 0 || x + this.w >= width){
           this.velocity.x = - this.velocity.x;
           this.left = x <= 0 ? false : true;
        }
        if(y <= 0 || y + this.h >= height){
           this.velocity.y = - this.velocity.y;
        }
   }
   
   public void shot(PVector velocity, Room r){
       enemyShoot.play(2);
       PVector newLocation = location.copy();
       newLocation.x += this.w/2;
       newLocation.y += this.h/2;
       Bullet b = new Bullet(newLocation, velocity.copy(), 7, 7, this.dp){
           public void paint(){
             fill(70, 100 ,100);
             ellipse(this.location.x, this.location.y, this.w, this.h);
             noFill();
          }
       };
       r.enemyBullets.add(b);
   }
   
     public void drawGif(){
       if(isAlive){
           drawGif(Type.GIF_RUN);
       }else{
            if(!canRemove){
                 PImage[] imgs = this.gifsImgs.get(Type.GIF_DEATH);
                 pushMatrix();
                 translate(location.x, location.y);
                 if (!this.left) {
                      scale(-1, 1);
                     image(imgs[(int)this.gifsImgsCount[Type.GIF_DEATH]], -imgs[0].width, 0);
                 }
                 else {
                     image(imgs[(int)this.gifsImgsCount[Type.GIF_DEATH]], 0, 0);
                 }
                 popMatrix();
                 this.gifsImgsCount[Type.GIF_DEATH] = (this.gifsImgsCount[Type.GIF_DEATH] + Type.GIF_PLAY_SPEED) % (float)imgs.length;
                 canRemoveTimer.schedule(new TimerTask(){
                    @Override
                    public void run() {
                      canRemove = true;
                    }
                 }, 1000);
            }
       }
  }
    
}
