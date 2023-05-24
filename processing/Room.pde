/**
* @author imyuanxiao, Edsat
* Class for rooms, each room consists of 9 sections which are generated randomly.
*/
public class Room extends HandleEnemies{
    protected int type;
    protected int index;
    protected int[] adjacent;
    protected int[][] blockType;
    protected String[] sections;
    protected ArrayList<Block> blocks;
    protected boolean isTutorial = false;
    
    
    protected ArrayList<Bullet> playerBullets;
    protected ArrayList<Bullet> enemyBullets;
    protected ArrayList<Item> items;
    protected float tint;
    
    protected ArrayList<Decoration> decorations;

    public Room(){
        this.blockType = new int[Type.BOARD_MAX_HEIGHT][Type.BOARD_MAX_WIDTH];
        this.adjacent = new int[4];
        this.enemies = new ArrayList();
        this.playerBullets = new ArrayList();
        this.enemyBullets = new ArrayList();
        this.blocks = new ArrayList();
        this.items = new ArrayList();
        this.decorations = new ArrayList();
        for(int i = 0; i < 4; i++){
            this.adjacent[i] = Type.NO_ROOM;
        }
        sections = new String[14];
        sections[0]="levels/section1.csv";
        sections[1]="levels/section2.csv";
        sections[2]="levels/section3.csv";
        sections[3]="levels/section4.csv";
        sections[4]="levels/section5.csv";
        sections[5]="levels/section6.csv";  
        sections[6]="levels/section7.csv";
        sections[7]="levels/section8.csv";
        sections[8]="levels/section9.csv";
        sections[9]="levels/section10.csv";
        sections[10]="levels/section11.csv";
        sections[11]="levels/section12.csv";
        sections[12]="levels/section13.csv";
        sections[13]="levels/section14.csv";
    }
    
    public void setIsTutorial(boolean tutorial){
      this.isTutorial = tutorial;
    }
    
    
    public void setAdjacent(int[] newIndex){
       for(int i = 0; i < 4; i++){
           if(newIndex[i] != Type.NO_ROOM){
              this.adjacent[i] = newIndex[i];
           }
       }
    }
    

    public Block getBlockByPos(int i, int j){
       for(int k = 0; k < blocks.size(); k++){
         int[] pos = blocks.get(k).pos;
         if( pos[0] == i && pos[1] == j){
            return blocks.get(k);
         }
       }
       return null;
    }
    
    public void removeBlockByPos(Player p){
        Iterator<Block> iterator = blocks.iterator();
        while(iterator.hasNext()) {
           Block b = iterator.next();
           b.drawHp();
           if(b.canRemove == true){
              this.blockType[b.pos[0]][b.pos[1]] = Type.BLOCK_EMPTY;
              iterator.remove();
              p.value += b.value;
           }
        }
    }
    
    public void addBullet(ArrayList<Bullet> bullets){
      for(Bullet b :bullets){
          this.playerBullets.add(b);
      }
    }
    
    public void  display(Player p){
      
        //draw items
        for(int i = 0; i < items.size(); i++){
           items.get(i).display();
        }
       
        Iterator<Bullet> iterator = playerBullets.iterator();
        while(iterator.hasNext()) {
           Bullet b = iterator.next();
           b.move();
           b.paint();
        }

        for(int i = 0; i < enemyBullets.size(); i++){
           Bullet b = enemyBullets.get(i);
           b.move();
           b.paint();
        }
        
        
        Iterator<Decoration> iterator2 = decorations.iterator();
        while(iterator2.hasNext()) {
           Decoration d = iterator2.next();
           if(d.canRemove){
              iterator2.remove();
           }else{
              if(!d.beforePlayer){
                  d.display();

              }
           }
        }
        //draw enemies
        for(int i = 0; i < enemies.size(); i++){
            Enemy e = enemies.get(i);
            if(e.type == Type.ENEMY_FLY || e.type ==Type.ENEMY_KILLER){
               e.move(p.location);
            }else if (e.type == Type.ENEMY_GUNNER){
               e.move(p.location, this);
            }else{
               e.move();
            }
            e.display();
        }
        
    }
    
    public void drawGifBeforePlayer(){
        Iterator<Decoration> iterator2 = decorations.iterator();
        while(iterator2.hasNext()) {
           Decoration d = iterator2.next();
           if(d.canRemove){
              iterator2.remove();
           }else{
              if(d.beforePlayer){
                 d.display();
              }
           }
        }    
    }
    
    
    public Decoration findDecorationByPosAndType(int[] pos, int type){
        pos[1] -= 1;
        PVector target =  new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
        Iterator<Decoration> iterator2 = decorations.iterator();
        while(iterator2.hasNext()) {
           Decoration d = iterator2.next();
           if(d.location.x == target.x && d.location.y == target.y && d.type == type){
              return d;
           }
        }
        return null;
    }
    
    public void removeDecorationByPosAndType(int[] pos, int type){
      pos[1] -= 1;
        PVector target =  new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
        Iterator<Decoration> iterator2 = decorations.iterator();
        while(iterator2.hasNext()) {
           Decoration d = iterator2.next();
           if(d.location.x == target.x && d.location.y == target.y && d.type == type){
              iterator2.remove();
           }
        }  
    }
    
    
    //public Decoration findDecorationByPos(int[] pos){
    //    PVector target =  new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
    //    Iterator<Decoration> iterator2 = decorations.iterator();
    //    while(iterator2.hasNext()) {
    //       Decoration d = iterator2.next();
    //       if(d.location.x == target.x && d.location.y == target.y){
    //          return d;
    //       }
    //    }  
    //    return null;
    //}
    
    //public void removeDecorationByPos(int[] pos){
    //    PVector target =  new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
    //    Iterator<Decoration> iterator2 = decorations.iterator();
    //    while(iterator2.hasNext()) {
    //       Decoration d = iterator2.next();
    //       if(d.location.x == target.x && d.location.y == target.y){
    //          iterator2.remove();
    //       }
    //    }  
    //}

}
