/**
* @author imyuanxiao
* Class for handling enemies
*/
public class HandleEnemies{
  
   protected ArrayList<Enemy> enemies;
   
   public void addEnemy(Enemy enemy){
       this.enemies.add(enemy);
   }
   
   public Enemy getEnemeyById(int id){
       for(int i = 0; i < enemies.size(); i++){
           Enemy enemy = enemies.get(i);
           if(enemy.id == id) return enemy;
       }
       return null;
   }
   
   public void removeEnemyById(int id){
       for(int i = 0; i < enemies.size(); i++){
           if(enemies.get(i).id == id){
              enemies.remove(i);
              //println("remove" + id);
              return;
           }
       }
   }
   
}
