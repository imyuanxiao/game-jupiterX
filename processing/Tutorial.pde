import java.util.*;

/**
* @author Edsat
* Generates tutorial
*/
public class Tutorial extends Factory{    
    
    //protected EnemyFactory enemyFactory;
    protected BlockFactory blockFactory;
    protected final int sectionSize=9;
    protected String[] level;
    protected List<Integer> sectionIndex = new ArrayList<>(14);
    protected boolean portal;
    protected int[] portalCoordinates = new int[4];
   
    public Tutorial(BlockFactory b){
      this.blockFactory = b;
    }
    
    
    public Room initialise(){
      Room r = new Room();
      r.setIsTutorial(true);
      fillRoom(r);
      return r;
    }
    
    
    protected void fillRoom(Room r) {
      setPortal(false);
      String[] lines = loadStrings("levels/tutorial.csv");
      for(int row=0; row<20; row++){
        String[] values=split(lines[row],",");
        for(int col=0; col<29; col++){
          switch(values[col].codePointAt(0)){
            case '1':
              r.blockType[row][col] = Type.BLOCK_BORDER;
              break;
            case '2':
              r.blockType[row][col] = Type.BLOCK_WALL;
              break;
            case '3':
              r.blockType[row][col] = Type.BLOCK_BOUNCE;
              break;
            case '4':
              r.blockType[row][col] = Type.BLOCK_PLATFORM;
              break;
            case '5':
              r.blockType[row][col] = Type.BLOCK_CRYSTAL;
              break;
            case '6':
              r.blockType[row][col] = Type.BLOCK_SPIKE;
              break;
            case '7':
              r.blockType[row][col] = Type.BLOCK_CRATE;
              break;
            //case '8':
            //  addDecoration(new int[]{row,col}, 5, r);
            //  break;  
            case 'p':
              setPortal(true);
              setPortalCoordinates(row,col,'p');
              r.blockType[row][col] = Type.BLOCK_PORTAL;
              break;
            case 'q':
              setPortalCoordinates(row,col,'q');
              r.blockType[row][col] = Type.BLOCK_PORTAL;
              break;
          }
        }
      }
      makePortal(r);
    }
    
    
    public void setPortal(boolean p){
      portal = p;
    }
    
    
    public void setPortalCoordinates(int row, int col, char portal){
      switch(portal){
        case 'p':
          portalCoordinates[0]=row;
          portalCoordinates[1]=col;
          break;
        case 'q':
          portalCoordinates[2]=row;
          portalCoordinates[3]=col;
          break;
      }
    }
    
    
    public void makePortal(Room r){
      if(!portal){
        return;
      }
      Block b1 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b1.setPos(portalCoordinates[0], portalCoordinates[1]);
      b1.setPortal(portalCoordinates[2], portalCoordinates[3]);
      r.blocks.add(b1);
      Block b2 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b2.setPos(portalCoordinates[2], portalCoordinates[3]);
      b2.setPortal(portalCoordinates[0], portalCoordinates[1]);
      r.blocks.add(b2);
    }

}
