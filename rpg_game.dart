import 'dart:math';
import 'game_characters.dart';

class RpgGame {
  static int roundNumber = 0;
  static final Random random = Random(); 

  static void startGame() {
    Boss boss = Boss(1500, 50, 'Imoogi');           
    Warrior warrior1 = Warrior(280, 10, 'Hwarang1'); 
    Warrior warrior2 = Warrior(270, 15, 'Hwarang2'); 
    
 
    Medic doc = Medic(250, 5, 'DaeJangGeum', 15);    
    Medic assistant = Medic(300, 5, 'Kumiho', 5);    
    
    Berserk berserk = Berserk(260, 10, 'Dokkaebi');  
    Magic magic = Magic(290, 10, 'JeonWooChi');     
    Golem golem = Golem(450, 5, 'Hareubang');        
    Lucky lucky = Lucky(240, 12, 'Magpie');          
    Witcher witcher = Witcher(250, 0, 'Gildong');   
    Thor thor = Thor(260, 15, 'Hwanung');            
    Ludoman ludoman = Ludoman(260, 10, 'Nolbu');      
    List<Hero> heroes = [
      warrior1, doc, berserk, assistant, magic, warrior2, 
      golem, lucky, witcher, thor, ludoman
    ];
    
    printStatistics(boss, heroes);

    while (!isGameOver(boss, heroes)) {
      playRound(boss, heroes);
    }
  }

  static void printStatistics(Boss boss, List<Hero> heroes) {
    print('ROUND $roundNumber ----------------');
    print(boss);
    for (Hero h in heroes) {
      print(h);
    }
  }

  static void playRound(Boss boss, List<Hero> heroes) {
    roundNumber++;
    boss.chooseDefence();
    
    if (boss.isStunned) {
      print('The Boss is STUNNED and skips this round!');
      boss.isStunned = false; 
    } else {
      boss.attack(heroes);
    }

    for (Hero h in heroes) {
      if (h.isAlive() && boss.isAlive() && h.ability != boss.defence) {
        h.attack(boss);
        h.applySuperPower(boss, heroes);
      }
    }
    printStatistics(boss, heroes);
  }

  static bool isGameOver(Boss boss, List<Hero> heroes) {
    if (!boss.isAlive()) {
      print('Heroes won!!!');
      return true;
    }
    bool allHeroesDead = true;
    for (Hero h in heroes) {
      if (h.isAlive()) {
        allHeroesDead = false;
        break;
      }
    }
    if (allHeroesDead) {
      print('Boss won! Game Over.');
      return true;
    }
    return false;
  }
}