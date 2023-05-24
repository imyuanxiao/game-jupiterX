public class AlienSpider extends Enemy{
   
    protected int imgAlpha = 255;
    protected float speed;
    protected float downDistance;
    protected PVector initialLocation;

    public AlienSpider(float hp, float dp){
      this.type = Type.ENEMY_GUNNER;
      this.velocity = new PVector(Type.ENEMY_SPEED_X_NORMAL, 0);
      this.w = (int)(Type.BOARD_GRIDSIZE - 5);
      this.h = (int)(Type.BOARD_GRIDSIZE - 5);
      this.hp = hp;
      this.maxHp = hp;
      this.dp = dp;
      this.value = 200;
      this.type = Type.ENEMY_SPIDER;
    }
    
    public void init(float x, float y, float speed){
      this.location = new PVector(x, y);
      this.initialLocation = location.copy();
      this.velocity = new PVector(0, speed);
      this.speed = speed;
      this.downDistance = (int)random(500, 700);
    }
    
    public void move() {
      if(!this.isAlive){
         return;
      }
      
      if (location.y < downDistance / 2) {
        velocity.y += 0.1;
      } else {
        velocity.y -= 0.1;
      }
      
      if (velocity.y < 0 && location.y < initialLocation.y) {
        location.y = initialLocation.y;
        velocity.y = 0;
      }
      
      location.add(velocity);
      if (location.y >= downDistance) {
        location.y = downDistance;
        velocity.y = 0;
      } else if (location.y < downDistance / 4) {
        location.y = downDistance /4;
        velocity.y = 0;
      }
    }
    
    
     
   public void drawGif(){
       drawLine();
       if(isAlive){
           drawGif(Type.GIF_RUN);
       }else{
            if(!canRemove){
                 PImage[] imgs = this.gifsImgs.get(Type.GIF_RUN);
                 tint(255, imgAlpha);
                 imgAlpha -= 5;
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
                 noTint();
                 canRemoveTimer.schedule(new TimerTask(){
                    @Override
                    public void run() {
                      canRemove = true;
                    }
                 }, 500);
            }
       }
  }
  
  
  public void drawLine(){
      stroke(0, 0, 100);
     strokeWeight(2);
     line(initialLocation.x + this.w/2, initialLocation.y, location.x + this.w/2, location.y);
     strokeWeight(0);
     noStroke(); 
  }
    
}
