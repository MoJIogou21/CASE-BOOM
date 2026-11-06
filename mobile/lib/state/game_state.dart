import 'package:flutter/foundation.dart';
import '../models/game_item.dart';
import '../data/demo_data.dart';

class GameState extends ChangeNotifier {
  int coins = 2500;
  final List<GameItem> inventory = [];

  bool canAfford(int price) => coins >= price;

  void purchaseCoins(int amount) {
    coins += amount; // Demo only. Production purchases require store validation.
    notifyListeners();
  }

  GameItem? openDemoCase(int price) {
    if (!canAfford(price)) return null;
    coins -= price;
    // Demo outcome only. Replace with a server-authoritative API response.
    final item = demoItems[DateTime.now().microsecondsSinceEpoch % demoItems.length];
    inventory.insert(0, item);
    notifyListeners();
    return item;
  }
}
