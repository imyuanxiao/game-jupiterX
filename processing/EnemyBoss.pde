public class AlienKiller extends Enemy{

    PVector targetLocation;

    public AlienKiller(){
      this.fall = false;
      this.type = Type.ENEMY_KILLER;
      this.velocity = new PVector(0.1, 0.1);
      this.w = (int)(Type.BOARD_GRIDSIZE * 3);
      this.h = (int)(Type.BOARD_GRIDSIZE) * 3;
      this.hp = 20000;
      this.maxHp = 20000;
      this.dp = dif.bossDp;
      this.value = 10000;
      this.targetLocation = new PVector(0, 0);
    }
    
    //control speed by changing 0.5 in velocity.normalize().mult(0.5); 
    public void move(PVector playerLocation){
       
        if(!isAlive){ return;};
          PVector target = PVector.sub(playerLocation, location);
        
          PVector jitter = PVector.fromAngle(random(-PI/8, PI/8)).mult(random(0.1, 0.3));
          target.add(jitter);
        
          target.normalize();
          target.mult(3); 
          velocity.lerp(target, 0.05f); 
          velocity.normalize();
          velocity.mult(dif.bossV);
          location.add(velocity);


        if(this.velocity.x > 0){
           this.left = false;
        }
        if(this.velocity.x < 0){
           this.left = true;
        }
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
                 this.gifsImgsCount[Type.GIF_DEATH] = (this.gifsImgsCount[Type.GIF_DEATH] + Type.GIF_PLAY_SPEED * 2) % (float)imgs.length;
                 canRemoveTimer.schedule(new TimerTask(){
                    @Override
                    public void run() {
                      canRemove = true;
                    }
                 }, 700);
            }
       }
  }
}
