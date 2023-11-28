class GameRules {
  String number;
  String text;
  GameRules({required this.number, required this.text});
}

class GameRulesList {
  static List gameRulesList = [
    GameRules(
        number: "1. ",
        text:
            "Oyuna başlamaq üçün player name düyməsini basaraq, rəqibin adını qeyd edin"),
    GameRules(
        number: "2. ",
        text: "Vaxt bitdikdə, xanalar avtomatik olaraq bloklanır"),
    GameRules(
        number: "3. ",
        text:
            "Oyunun qalibi bəlli olduqdan sonra xanalar avtomatik olaraq  bloklanır"),
    GameRules(
        number: "4. ",
        text:
            "Oyuna  yenidən başlamaq  üçün restart düyməsinə  basın ve adları yenidən  daxil edin"),
    GameRules(
        number: "5. ",
        text:
            "Play this player düyməsini sıxdığınız zaman, ən sonuncu oyunçu ilə oyuna davam edirsiniz"),
    GameRules(
        number: "6. ",
        text:
            "Yeni oyunçu ilə oynamaq istədiyiniz zaman, hazırki xalınız sıfırlanır"),
  ];
}
