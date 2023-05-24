/**
* @author imyuanxiao
* All items that can be generated in game, e.g. weapon
* 'category' - means primary category, e.g. weapon, potion, coin, outfit...
* 'type' - secondary category, e.g. weapon_gun, weapon_laser 
* 'imgs[]' - for weapons, at least two PImage needed (left/right), for others, one PIame may be enough.
*/
public class Item extends BasicProp{
     
    // Primary category = category
    protected int category;
    // Secondary category = type in basicProp
    
    //left and right
    protected PImage[] imgs;
     
    protected Timer cdTimer;
    protected boolean inCd;
    
    protected Timer showTimer;
    protected boolean showMe;
    
    // w.shot(r, new PVector(bx, by), p.bWidthInc, p.bHeightInc, p.bDp, p.bSpeed, p.bNum);
    protected float bW, bH, bSpeed, bDp;
    
    protected int bNum, bCd, bType;
    
    public Item(){
       //this.pos = new int[2];
       this.imgs = new PImage[2];
       this.location = new PVector();
    }

    //basic prop of bullets
    public Item(float bW, float bH, float bSpeed, float bDp, int bNum, int bCd, int bType){
       this();
       this.cdTimer = new Timer();
       this.bW = bW;
       this.bH = bH;
       this.bSpeed = bSpeed;
       this.bDp = bDp;
       this.bNum = bNum;
       this.bCd = bCd;
       this.bType = bType;
    }
    
    public void setImgs(PImage... imgs){
      for(int i = 0; i < imgs.length; i++){
        this.imgs[i] = imgs[i];
        this.imgs[i].resize(this.w, this.h);
      }
    }
  
  public void display(){
      image(imgs[0], location.x, location.y);
  }
  
  //if item is weapon
  public void shot(Room r, PVector location, float pBW, float pBH, float pBDp, float pBSpeed, int pBNum){
      if(!inCd){
          inCd = true;
          shoot.play(2);
          r.addBullet(this.bullets(location, pBW, pBH, pBDp, pBSpeed, pBNum));
          cdTimer.schedule(new TimerTask(){
            @Override
            public void run() {
              inCd = false;
            }
         }, bCd);
      }  
  }
  
  public ArrayList<Bullet> bullets(PVector location, float pBW, float pBH, float pBDp, float pBSpeed, int pBNum){
    float angleStep = 10; 
    PVector mousePos = new PVector(mouseX, mouseY);
    ArrayList<Bullet> bs = new ArrayList();
    for (int i = 0; i < this.bNum + pBNum; i++) {
        float offset = i * angleStep - (this.bNum + pBNum - 1) * angleStep / 2;
        PVector bulletVel = PVector.sub(mousePos, location);
        bulletVel.normalize();
        bulletVel.mult(this.bSpeed + pBSpeed);
        PVector bulletVelOffset = bulletVel.copy();
        bulletVelOffset.rotate(radians(offset));  
        Bullet b = new Bullet(new PVector(location.x, location.y), new PVector(bulletVelOffset.x, bulletVelOffset.y), this.bW + pBW, this.bH + pBH, this.bDp + pBDp);
        b.type = bType;
        b.id = i;
        bs.add(b);
    }
    return bs;
  }

  
  void display(Player p) {
     float offset = 10;
    if(p.isShoot){
     int i = mouseX > p.location.x + p.w/2 ? 1 : 0;
        //5 = arm length  = offset
        float distance = offset/2 + this.w/2;
        PVector rotatePoint;
        rotatePoint = new PVector(p.location.x + p.w/2, p.location.y + p.h/2);
        location.set(rotatePoint);
        pushMatrix();
        translate(rotatePoint.x, rotatePoint.y);
        rotate(atan2(mouseY - rotatePoint.y, mouseX - rotatePoint.x));
        translate(distance, 0);
        if(p.left){
           scale(-1, -1);
        }
        image(imgs[i], -w/2, -h/2);
        popMatrix();
    }else{
      if (p.left) {
        this.location = new PVector(p.location.x - this.w + offset * 2, p.location.y + p.h/3 - offset/2);
        image(imgs[0], location.x, location.y);
      } else {
        this.location = new PVector(p.location.x + p.w + this.w - offset * 2, p.location.y + p.h/3 - offset/2);
        image(imgs[1], location.x - this.w, location.y);
      }
    }

  }
  
    public void minerLaser(PVector start, Room r){
      
      if(!mining.isPlaying()){
         mining.play(2);
      }
      
      PVector end = new PVector(mouseX, mouseY);
      
      float maxDist = 200;
      float distance = start.dist(end);
      
      if (distance > maxDist) {
        end = PVector.sub(end, start);
        end.setMag(maxDist);
        end.add(start);
      }
      
      PVector center = PVector.lerp(start, end, 0.5f);
      PVector diff = PVector.sub(end, start);
      diff.setMag(maxDist); 
      
      float controlMag = maxDist / 5;
      PVector control1 = PVector.add(center, PVector.fromAngle(random(TWO_PI)).mult(random(-controlMag, controlMag)));
      PVector control2 = PVector.add(center, PVector.fromAngle(random(TWO_PI)).mult(random(-controlMag, controlMag)));
      
      noFill();
      stroke(60, 255, 255);
      strokeWeight(3);
      beginShape();
      vertex(start.x, start.y);
      bezierVertex(control1.x, control1.y, control2.x, control2.y, end.x, end.y);
      endShape();
      
      
      //check collision between blocks and this curve
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(r.blockType[i][j] == Type.BLOCK_CRYSTAL && detect(end, i , j )){
                     Block b = r.getBlockByPos(i, j);
                     if(b == null){
                        //add new block
                        Block newB = new Block(Type.BLOCK_CRYSTAL, new int[]{i,j}, 1000, 120);
                        r.blocks.add(newB);
                        b = newB;
                     }
                     b.update();
                }
           }
         }
    }
    
    public boolean detect(PVector location, int i, int j){
       int s = Type.BOARD_GRIDSIZE;
       if(location.x> j * s &&
          location.x < j * s + s &&
          location.y > i * s &&
          location.y < i * s + s){
          return true;   
       }
       return false;
   }
   
   public void showMe(PVector playerLoction){

      if(showMe){
         //rect(playerLoction.x, playerLoction.y - Type.BOARD_GRIDSIZE, this.w, this.h);
         image(imgs[0], playerLoction.x, playerLoction.y - Type.BOARD_GRIDSIZE);
         
         showEffect(playerLoction);
         
         if(showTimer == null) {showTimer = new Timer();};
         
          showTimer.schedule(new TimerTask(){
            @Override
            public void run() {
              showMe = false;
            }
         }, 5000);
      }
   }
    
   public void showEffect(PVector playerLoction){
       noTint();
      stroke(0); 
      strokeWeight(1); 
      fill(255);
      textSize(20); 
      textAlign(CENTER, TOP);
      String s = "";
      if(this.type == 0){
         s = "MaxHP +1";
      }else if(this.type == 1){
         s = "SPEED UP: 5s";
      }else{
         s = "FLY mode: 8s";
      }
      text("Effect: " + s, playerLoction.x, playerLoction.y - Type.BOARD_GRIDSIZE * 2); 
      noStroke();
      noFill();
   }
   
    
}
