/**
* @author imyuanxiao
* Common properties and methods for all factory classes
*/
public class Factory{
    protected int id;
    protected ArrayList<PImage> imgs;
    
    public Factory(){
       
    }
    
    public void setImgs(ArrayList<PImage> imgs){
       this.imgs = imgs;
    }
    
    public void addImg(PImage img){
       this.imgs.add(img);
    }  //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    
    public PImage getImg(int i){
       return this.imgs.get(i);
    }
    
    public void increaseId(){
       this.id++;
    }

}
