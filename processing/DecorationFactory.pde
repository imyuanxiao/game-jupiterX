/**
* @author participants, imyuanxiao
* Factory for enemy generation.
* If gifs are needed, you need to build another function similar to addplayerGifs() in JupiterX.pde
* If no gifs, only PImage, you can add imgs in this class, just like ItemFactory.class
*/


public class DecorationFactory extends Factory{    
    
   protected ArrayList<PImage[]> decorationGifs;
   protected int[] jumpBlock = new int[2];
   protected int[] portalBlock = new int[2];
   

    public DecorationFactory(){
       decorationGifs = new ArrayList();
    }
    
   public void addDecorationGifs(PImage[]... gifs){
      for(int i = 0 ; i < gifs.length; i++){
         PImage[] gif = gifs[i];
         for(PImage img : gif){
              if(i == Type.GIF_ARROW_DOWN || i == Type.GIF_ARROW_UP){
                 img.resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE * 2);
              }else if(i == Type.GIF_ARROW_LEFT || i == Type.GIF_ARROW_RIGHT){
                 img.resize(Type.BOARD_GRIDSIZE * 2, Type.BOARD_GRIDSIZE);
               }else{
                  img.resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
               }
           }
          decorationGifs.add(gif);   
      }
     
     // for(PImage[] gif : gifs){
     //     for(PImage img : gif){
     //         img.resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
     //      }
     //     decorationGifs.add(gif);      
     // }
      
      //PImage[] arrow = this.decorationGifs.get(this.decorationGifs.size() - 1);
      // for(PImage img : arrow){
      //  img.resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE / 2);
      // }
      
   }
   
    public void addDecorationToRoom(Room r){
        
       //if(r.index == 0){
       //   addTutorialToStartRoom(r);
       //}
       if(r.isTutorial){
         addTutorialDecorations(r);
         return;
       }
      
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
         for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
            if(legalPosition(r, new int[]{i,j})){
                 int rd = (int)random(20);
                 if(rd > 13){
                     Decoration d = newDecoration(new int[]{j,i});
                     r.decorations.add(d);       
                 }
              }
            }
         }
         addPathArrow(r);
    }
    
    public void addTutorialDecorations(Room r){
      int col = Type.tutorialCrystalCoord[0];
      int row = Type.tutorialCrystalCoord[1];
      for(int i=0; i<Type.tutorialCrystalNum; i++){
        Decoration d = addDecoration(new int[]{col+i, row}, 4);
        r.decorations.add(d);    
      }
    }
    
    public Decoration addDecoration(int[] pos, int decorationType){
       Decoration d = new Decoration(pos);
       d.imgs = this.decorationGifs.get(decorationType);
       d.resizeGif(Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE/2);
       d.type = decorationType;
       d.w = Type.BOARD_GRIDSIZE/2;
       d.h = Type.BOARD_GRIDSIZE/2;
       return d;
    }

    /*
      static final int GIF_ARROW_DOWN = 7;
      static final int GIF_ARROW_LEFT = 8;
      static final int GIF_ARROW_RIGHT = 9;
      static final int GIF_ARROW_UP = 10;
      
      static final int BOARD_MAX_HEIGHT = 20;
      static final int BOARD_MAX_WIDTH = 29;
    */
    
    public void addPathArrow(Room r){
      
      //up
      Decoration up = new Decoration(new int[]{Type.BOARD_MAX_WIDTH/2 + 1 , 1});
      up.imgs = this.decorationGifs.get(Type.GIF_ARROW_UP);
      up.w = Type.BOARD_GRIDSIZE;
      up.h = Type.BOARD_GRIDSIZE * 2;
      
      //down
      Decoration down = new Decoration(new int[]{Type.BOARD_MAX_WIDTH/2 + 1 , Type.BOARD_MAX_HEIGHT - 3});
      down.imgs = this.decorationGifs.get(Type.GIF_ARROW_DOWN);
      down.w = Type.BOARD_GRIDSIZE;
      down.h = Type.BOARD_GRIDSIZE * 2;
      
      //left
      Decoration left1 = new Decoration(new int[]{1, Type.BOARD_MAX_HEIGHT / 3 + 1});
      left1.imgs = this.decorationGifs.get(Type.GIF_ARROW_LEFT);
      left1.h = Type.BOARD_GRIDSIZE;
      left1.w = Type.BOARD_GRIDSIZE * 2;
      
      Decoration left2 = new Decoration(new int[]{1, Type.BOARD_MAX_HEIGHT * 2 / 3 + 3});
      left2.imgs = this.decorationGifs.get(Type.GIF_ARROW_LEFT);
      left2.h = Type.BOARD_GRIDSIZE;
      left2.w = Type.BOARD_GRIDSIZE * 2;
      
      //right
      Decoration right1 = new Decoration(new int[]{Type.BOARD_MAX_WIDTH - 3, Type.BOARD_MAX_HEIGHT / 3 + 1});
      right1.imgs = this.decorationGifs.get(Type.GIF_ARROW_RIGHT);
      right1.h = Type.BOARD_GRIDSIZE;
      right1.w = Type.BOARD_GRIDSIZE * 2;
      
      Decoration right2 = new Decoration(new int[]{Type.BOARD_MAX_WIDTH - 3, Type.BOARD_MAX_HEIGHT * 2 / 3 + 3});
      right2.imgs = this.decorationGifs.get(Type.GIF_ARROW_RIGHT);      
      right2.h = Type.BOARD_GRIDSIZE;
      right2.w = Type.BOARD_GRIDSIZE * 2; 
      
      if(r.type == 0){
         r.decorations.add(up); 
         r.decorations.add(down); 
      }
      
      if(r.type == 1 || r.type == 4){
         r.decorations.add(up); 
         r.decorations.add(down); 
         r.decorations.add(left1); 
         r.decorations.add(left2); 

         r.decorations.add(right1); 
         r.decorations.add(right2); 

      }
      if(r.type == 2){
         r.decorations.add(left1); 
         r.decorations.add(left2); 
         r.decorations.add(right1); 
         r.decorations.add(right2); 
      }
      if(r.type == 3){
         r.decorations.add(down); 
      }
      if(r.type == 5){
         r.decorations.add(up); 
         r.decorations.add(right1); 
         r.decorations.add(right2); 
      }
    }
    
    
    //check position according target position and enemy's size
    //pos[0] = i, pos[1] = j
    public boolean legalPosition(Room r, int[] pos){
      if(pos[0] <=3 || pos[0] >= Type.BOARD_MAX_HEIGHT - 3 || pos[1] <=3 || pos[1] >= Type.BOARD_MAX_WIDTH - 3){
        return false;
      }
      for(int i = pos[0] - 1; i <= pos[0] + 1; i++){
            for(int j = pos[1] - 1; j <= pos[1] + 1; j++){
               if(r.blockType[i][j] != Type.BLOCK_EMPTY){
                 return false;
               }
            }
      }
      return true;
    }
    
    /*  static final int GIF_HP = 4;
        static final int GIF_CRYSTAL = 5;
        static final int GIF_LIGHT = 6;
        static final int GIF_ARROW = 7;
    */
    
    public Decoration newDecoration(int[] pos){
       Decoration d = new Decoration(pos);
       
       int rd = (int)random(4, 7);
       if(rd == 4 || rd == 5){
        int rd2 = (int)random(0, 10);
        if(rd2 <= 3) rd = 5;
         else rd = 4;
         d.imgs = this.decorationGifs.get(rd);
         d.resizeGif(Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE/2);
         d.type = rd;
         d.w = Type.BOARD_GRIDSIZE/2;
         d.h = Type.BOARD_GRIDSIZE/2;
       }else{
         d.imgs = this.decorationGifs.get(rd);
         d.resizeGif(Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE);
         d.type = Type.GIF_LIGHT;
       }
       

       
       return d;
    }
    
    //  public Decoration(int[] pos, boolean once, int cd){
    public void addPortalGif(Room r, int[] pos){
           pos[1] -= 1;
           Decoration d = new Decoration(pos, true, 750, Type.GIF_PLAY_SPEED * 3, true);
           d.imgs = this.decorationGifs.get(Type.GIF_PORTAL);//torch
           r.decorations.add(d);
    }
    
    public void addJumpGif(Room r){
           Decoration d = new Decoration(new int[]{jumpBlock[0], jumpBlock[1] - 1}, true, 750, Type.GIF_PLAY_SPEED * 3, true);
           d.imgs = this.decorationGifs.get(Type.GIF_BOUNCE);//torch
           r.decorations.add(d);
    }
    
    public void addBulletRemoveGif(Room r , ActionProp o){
           Decoration d = new Decoration(o, 750, this.decorationGifs.get(Type.GIF_BULLET_REMOVE));
           r.decorations.add(d);
    }
    
    
}
