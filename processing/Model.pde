/**
* @author imyuanxiao, participants
* Contains all data
*/
public class Model{
   protected Map map;
   protected Player player;
   protected ItemFactory itemFactory;
   protected EnemyFactory enemyFactory;
   protected RoomFactory roomFactory;
   protected BlockFactory blockFactory;
   protected DecorationFactory decorationFactory;
   protected Tutorial tutorial;
   
   protected boolean isMusicPlaying = true;
   protected boolean menuHomePage = true;
   protected boolean helpPage = false;
   protected boolean menuControl = false;
   protected boolean gameStart = false;
   protected boolean gamePause = false;
   protected boolean gameOver = false;
   protected boolean isTutorial = false;
   protected boolean globalList = false;
   protected Integer difficulty = 1;
   protected boolean inGame = false;
   protected boolean addBoss = false;

   public Model(){
       this.blockFactory = new BlockFactory();
       this.roomFactory = new RoomFactory(blockFactory);
       this.tutorial = new Tutorial(blockFactory);
       map = new Map();
       if(isTutorial){
         map.addRoom(tutorial.initialise());
       }else { map.addRoom(roomFactory.newRoom(Type.ROOM_START)); //<>// //<>// //<>// //<>// //<>// //<>// //<>//
       }
   }
   
   public void addPlayer(Player p){
      Room r = this.map.rooms.get(0);
      if(!isTutorial){
        for(int i = 6; i < Type.BOARD_MAX_HEIGHT - 6; i++){
           for(int j = 10; j < Type.BOARD_MAX_WIDTH - 10; j++){
              if(r.blockType[i][j] == Type.BLOCK_WALL
               && r.blockType[i - 1][j] == Type.BLOCK_EMPTY
               && r.blockType[i - 2][j] == Type.BLOCK_EMPTY
              ){
                 p.location = new PVector(j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
              }
           }
         }
      }else{
        p.location = Type.tutorialStart;
      }
     
      this.player = p;
   }
   
   public void addBossToMap(){
       if(roomFactory.id >=2 && this.addBoss == false){
           enemyFactory.addBossToMap(map);
           this.addBoss = true;
       }
   }
   
   public Item newItem(int[] pos){
      return itemFactory.newItem(pos, isTutorial);
   }
      
   public void addRoom(int type){
      map.addRoom(roomFactory.newRoom(type));
   }
   
   public Room getNewRoom(){
      return map.getNewRoom(roomFactory.id - 1);
   }
   
   public Room getCurrentRoom(){
      return map.getCurrentRoom();
   }
   
   public int getIndexByDirection(int type){
      return map.getIndexByDirection(type);
   }
   
   public void setCurrentRoomIndex(int index){
       map.setCurrentRoomIndex(index);
   }
   
   public void useItemByPlayer(){
      itemFactory.useItemByPlayer(player);
   }
  
   
}
