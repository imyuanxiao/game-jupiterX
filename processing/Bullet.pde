/**
* @author imyuanxiao
* Class for bullets. Each weapon should overload shot() method when generationg new bullet object
* Next stage: add damage here. Damage should be set when weapon is generated. Damage to enemies should be added with potion effects probably?
*/
public class Bullet extends ActionProp{
    
    //cause damage if alive
    //maybe two gifs, fly and die
    protected PVector target;
    
    protected ArrayList<PImage> bulletImgs;
    
    protected PImage img;
    
    protected boolean split;
    
    Bullet(PVector location, PVector velocity, float w, float h, float dp){
       this.bulletImgs = new ArrayList();
       this.init();
       this.isAlive = true;
       this.w = (int)w;
       this.h = (int)h;
       this.dp = dp;
       this.location = location;
       this.velocity = velocity;
       this.type = Type.BULLET_TYPE_PISTOL;
       this.split = false;
    }
    
    protected void init(){
       bulletImgs.add(loadImage("imgs/items/bullet/00.png")); 
       bulletImgs.add(loadImage("imgs/items/bullet/10.png")); 
       bulletImgs.add(loadImage("imgs/items/bullet/20.png")); 
    }
        
    public void move(){
        this.location.add(this.velocity);
    }
     
    public void paint(){
      this.w = Type.BOARD_GRIDSIZE*1/4;
      this.h = Type.BOARD_GRIDSIZE*1/4;
      if(this.type == Type.BULLET_TYPE_PISTOL){
           this.img = bulletImgs.get(0);
           //fill(60,60,100);
           //ellipse(this.location.x, this.location.y, this.w, this.h);
           //noFill();
      } else if(this.type == Type.BULLET_TYPE_SHOT){
           this.img = bulletImgs.get(1);
      } else{
           this.img = bulletImgs.get(2);
      }
      this.img.resize(this.w, this.h);
      image(img, location.x, location.y);
    }
}
