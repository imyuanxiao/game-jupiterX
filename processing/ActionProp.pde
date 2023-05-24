/**
* @author imyuanxiao
* Action properties, includes all actions and related properties
*/
public class ActionProp extends BasicProp{

  protected PVector velocity, velocity2, velocity3;
  
  protected boolean fall, jump, transported, highJump, left, onPortal, throughDown;
  protected boolean doubleJump, canDoubleJump;
  protected float fallDist;
  
  protected boolean fly;

  protected boolean isInvincible, isKnockBack, canRemove;
  protected Timer invincibleTimer, knockBackTimer, canRemoveTimer;
  
  public ActionProp(){
    this.fall = true;
    this.velocity = new PVector(0, 0);
    this.velocity2 = new PVector(0, 0);
    this.velocity3 = new PVector(0, 0);
  }

  public void attacked(float dp){
       if(this.hp > 0){
          this.hp -= dp;
       }
       if(this.hp <=0 ){
          hp = 0;
          this.isAlive = false;
       }
  }
  
  public void attacked(float dp, ActionProp e){};
  
  /**
  * In each frame, player's position depends on x + speedX and y + speedY
  */
  public void move(){
     this.location.x += this.getFullVelocityX();
     if(this.fly){
         this.location.y +=  this.getFullVelocityY();
     }else{
         if(this.jump){
            this.location.y +=  this.getFullVelocityY();
            if(this.getFullVelocityY() < Type.PLAYER_SPEED_Y) this.velocity.y += Type.PLAYER_SPEED_INCREMENT;
         }
     }
  }
  
  public void setAllVelocityY(float i){
     this.velocity.y = i;
     this.velocity2.y = i;
     this.velocity3.y = i;
  }
  
  public void setAllVelocityX(float i){
     this.velocity.x = i;
     this.velocity2.x = i;
     this.velocity3.x = i;
  }
 
  public float getFullVelocityX(){
     return this.velocity.x + this.velocity2.x +  + this.velocity3.x;
  }
  
  public float getFullVelocityY(){
       return this.velocity.y + this.velocity2.y +  + this.velocity3.y;
  }
  
  public void changeDir(boolean flag){
     this.left = flag;
     this.velocity.x = -velocity.x;
     this.velocity2.x = -velocity2.x;
     this.velocity3.x = -velocity3.x;
  }
    
  public void jump(){};

  public void display(){};
  
  public void drawGif(int gifType){
       PImage[] imgs = this.gifsImgs.get(gifType);
       pushMatrix();
       translate(location.x, location.y);
       if (!this.left) {
            scale(-1, 1);
           image(imgs[(int)this.gifsImgsCount[gifType]], -imgs[0].width, 0);
       }
       else {
           image(imgs[(int)this.gifsImgsCount[gifType]], 0, 0);
       }
       popMatrix();
       this.gifsImgsCount[gifType] = (this.gifsImgsCount[gifType] + Type.GIF_PLAY_SPEED) % (float)imgs.length;
  }
  
}
