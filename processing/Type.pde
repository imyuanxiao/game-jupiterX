/**
* Avoid using magic number
*/
static abstract class Type {
  
  static final int SCREEN_WIDTH = 1160;
  static final int SCREEN_HEIGHT = 800;
  
  //board - baisc attributes
  static final int BOARD_MAX_HEIGHT = 20;
  static final int BOARD_MAX_WIDTH = 29;

  static final int BOARD_GRIDSIZE = 40;
  static final int BOARD_GRIDSIZE_ADD5 = BOARD_GRIDSIZE + 5;
  static final int BOARD_GRIDSIZE_SUB5 = BOARD_GRIDSIZE - 5;

  static final float GIF_PLAY_SPEED = 0.1;

  //player - baisc attributes
  static final int PLAYER = -1;
  static final int PLAYER_HEART = 10;
 
  static final int PLAYER_JUMP_SPEEDY = BOARD_GRIDSIZE * 3/13;
  static final int PLAYER_HIGH_JUMP_SPEEDY = BOARD_GRIDSIZE * 2/6;

  static final float PLAYER_SPEED_INCREMENT = 0.3;
  static final float PLAYER_SPEED_X = BOARD_GRIDSIZE / 9;
  static final float PLAYER_SPEED_Y = BOARD_GRIDSIZE / 4;
  static final float PLAYER_SPEEDINC = BOARD_GRIDSIZE / 18;
  
  static final int FALL_DAMAGE = 20;
  static final int FALL_DAMAGE_DIST = BOARD_GRIDSIZE * 2;
  
  static final int[] tutorialCrystalCoord = new int[]{5,15};
  static final int tutorialCrystalNum = 6;
  static final PVector tutorialStart = new PVector(800.0, 320.0);

  
  //enemy - baisc attributes
  static final float ENEMY_SPEED_X_SLOW = (float)BOARD_GRIDSIZE / 100;
  static final float ENEMY_SPEED_X_NORMAL = (float)BOARD_GRIDSIZE / 80;
  
  //bullet - baisc attributes
  static final int BULLET_SPEED_SLOW = BOARD_GRIDSIZE / 8;
  static final int BULLET_SPEED_NORMAL = BOARD_GRIDSIZE / 7;
  static final int BULLET_SPEED_FAST = BOARD_GRIDSIZE / 6;
  
  static final int BULLET_CD_LONG = 30;
  static final int BULLET_CD_NORMAL = 20;
  static final int BULLET_CD_SHORT = 10;
  
  static final int BULLET_TYPE_PISTOL = 0;
  static final int BULLET_TYPE_MINER = 1;
  static final int BULLET_TYPE_SHOT = 2;
  static final int BULLET_TYPE_LASER = 3;
  
  static final float BULLET_ANGLE = 50;


  // gif - animation type
  static final int GIF_RUN = 0;
  static final int GIF_DEATH = 1;

  //static final int GIF_KONCKBACK_L = 2;
  //static final int GIF_KONCKBACK_R = 3;
  
  static final int GIF_BOUNCE = 0;
  static final int GIF_PORTAL = 1;
  static final int GIF_BULLET_REMOVE = 2;
  static final int GIF_PRESSE = 3;
  static final int GIF_CRYSTAL = 4;
  static final int GIF_HP = 5;
  static final int GIF_LIGHT = 6;
  static final int GIF_ARROW_DOWN = 7;
  static final int GIF_ARROW_LEFT = 8;
  static final int GIF_ARROW_RIGHT = 9;
  static final int GIF_ARROW_UP = 10;

  //static final int GIF_BULLET_REMOVE = 2;


  
  
  //mouse
  static final int MOUSE_RIGHT = 10;
  static final int MOUSE_LEFT = 11;

  //keys - integer of keys
  static final int KEY_A = 97;
  static final int KEY_D = 100;
  static final int KEY_W = 119;
  static final int KEY_S = 115;
  static final int KEY_E = 101;
  static final int KEY_SPACE = 32;
  static final int KEY_RELEASED_AD = 1000;
  static final int KEY_RELEASED_WS = 1001;
  static final int KEY_RELEASED_SPACE = 1002;
  
  static final int KEY_Q = 113;
  static final int KEY_R = 114;
  //press S and SPACE together, can throught blocks
  static final int KEY_S_SPACE = 200;

  //temporarily for activate fly
  //static final int KEY_F = 102;

  //room - indices for room generation
  static final int TO_LEFT = 2;
  static final int TO_UP = 0;
  static final int TO_RIGHT = 3;
  static final int TO_DOWN = 1;
  static final int NO_ROOM = -1;
  static final int ROOM_START = 0;
  static final int ROOM_UP = 1;
  static final int ROOM_DOWN = 2;
  static final int ROOM_LR = 3;
  
  //gifs - get gifs of enemies or player from model by order
  static final int ENEMY_GUNNER = 0;
  static final int ENEMY_FLY = 1;
  static final int ENEMY_SPIDER = 2;
  static final int ENEMY_KILLER = 3;


  //block type
  static final int BLOCK_EMPTY = 0;
  static final int BLOCK_WALL = 1;
  static final int BLOCK_CRYSTAL = 2;
  static final int BLOCK_BOUNCE = 3;
  static final int BLOCK_PORTAL = 4;
  static final int BLOCK_BORDER = 5;
  static final int BLOCK_CRATE = 6;
  static final int BLOCK_CRATE_OPEN = 7;
  static final int BLOCK_SPIKE = 8;
  static final int BLOCK_PLATFORM = 9;
  
  // item type
  // Primary category
  static final int ITEM_WEAPON = 0;
  static final int ITEM_POTION = 1;
  static final int ITEM_CRYSTAL = 2;
  //static final int ITEM_OUTFIT = 3;
  // Secondary category
  // crystal
  static final int CRYSTAL = 0;
  // weapons
  static final int WEAPON_PISTOL= 0;
  static final int WEAPON_MINER = 3;
  static final int WEAPON_SHOTGUN = 1;
  static final int WEAPON_LASER = 2;

  // potions
  static final int POTION_HP = 0;
  static final int POTION_HP_EFFECT = 10;
  
  static final int POTION_SP = 1;

  static final int POTION_FLY = 2;
  
}
