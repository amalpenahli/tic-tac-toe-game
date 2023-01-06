class GameRules{
  String number;
  String text;
  GameRules({required this.number, required this.text});
  
}

class GameRulesList{
 static List gameRulesList = [
  GameRules(number: "1. ", text: "Oyuna başlamaq üçün player name düyməsini basaraq, oyunçuların adlarını qeyd edin"),
  GameRules(number: "2. ", text: "Vaxt bitdikdə, xanalar avtomatik olaraq bloklanır"),
  GameRules(number: "3. ", text: "Oyunun qalibi bəlli olduqdan sonra xanalar avtomatik olaraq  bloklanır"),
  GameRules(number: "4. ", text: "Oyuna  yenidən başlamaq  üçün restart düyməsinə  basın ve adları yenidən  daxil edin"),
 
];
}