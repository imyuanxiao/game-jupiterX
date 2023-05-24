/**
* @author participants, imyuanxiao
* Class for enemies. This class includes some basic properties that all enemies have.
*/
class Enemy extends ActionProp{
  
  protected int[] spawn;
  //protected int imgAlpha = 255;
  
  Enemy(){
      this.location = new PVector(0, 0);
      this.fall = true;
      this.knockBackTimer = new Timer();
      this.canRemoveTimer = new Timer();
      this.isAlive = true;
  };
   
   public void init(float x, float y, float speed){};
   
  public void setSpawn(int[] spawn){
     this.spawn[0] = spawn[0];
     this.spawn[1] = spawn[1];
  }
  
  public void move(){
      super.move();
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
         this.hp = 0;
      }

  }
  
  
   public void move(PVector location){}
   
   public void move(PVector location, Room r){}
   
  public void attacked(float dp, ActionProp b){
     super.attacked(dp);
     if(!isKnockBack){
       enemyHurt.play(2);
       this.isKnockBack = true;
       this.velocity2 = new PVector(b.velocity.x,0);
       this.velocity2.normalize();
       this.velocity2.mult(2);
       knockBackTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            isKnockBack = false;
             velocity2 = new PVector();
          }
       }, 100);
     }
  }
  
  public void addGifsImgs(ArrayList<PImage[]> gifs){
    this.gifsImgs = gifs;
    for(PImage[] gif : gifsImgs){
      for(int i = 0; i < gif.length; i++){
          gif[i].resize(this.w, this.h);
       }
    }
    this.gifsImgsCount = new float[gifs.size()];
  }
  
  
  public void display(){     
     drawGif();
     drawHp();
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
                 }, 750);
            }
       }
  }
  
  public void drawHp(){
      if(this.hp < maxHp && isAlive){
        fill(0,100,100);
        rect(location.x, location.y - 5, (float)hp/ (float) maxHp * w, 2);    
        noFill();
        stroke(255);
        strokeWeight(1);
        rect(location.x, location.y - 6, w, 4);
        noStroke();
      }
  }
  
}
