class GameItem {
  const GameItem({
    required this.name,
    required this.weapon,
    required this.rarity,
    required this.colorValue,
    this.wear = 'Factory New',
  });

  final String name;
  final String weapon;
  final String rarity;
  final int colorValue;
  final String wear;
}
