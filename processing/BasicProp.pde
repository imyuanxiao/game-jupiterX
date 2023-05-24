/**
* @author imyuanxiao
* Basic properties and methods for subclasses
*/
public abstract class BasicProp{
  
  protected int id, type, value;
  protected PVector location;
  protected int w, h;
  protected boolean isAlive;
  protected float hp, dp, maxHp;
  protected int dpCd, dpTimer;
  protected PImage img;

  protected ArrayList<PImage[]> gifsImgs;
  protected float[] gifsImgsCount;
  
  public BasicProp(){}

  public void addGifsImgs(PImage[]... gifs){
    if(this.gifsImgs == null) this.gifsImgs = new ArrayList();
    int cnt = 0;
    for(PImage[] gif : gifs){
       cnt++;
      for(int i = 0; i < gif.length; i++){
          gif[i].resize(this.w, this.h);
       }
       this.gifsImgs.add(gif);
    }
    this.gifsImgsCount = new float[cnt];
  }

}
