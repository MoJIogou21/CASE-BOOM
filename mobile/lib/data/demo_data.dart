import '../models/game_item.dart';

const demoItems = <GameItem>[
  GameItem(name: 'Neon Circuit', weapon: 'M4A1-S', rarity: 'Covert', colorValue: 0xFFEF4444),
  GameItem(name: 'Phantom Grid', weapon: 'AK-47', rarity: 'Classified', colorValue: 0xFFEC4899),
  GameItem(name: 'Arctic Pulse', weapon: 'AWP', rarity: 'Restricted', colorValue: 0xFF9B7BFF),
  GameItem(name: 'Carbon Rush', weapon: 'Glock-18', rarity: 'Mil-Spec', colorValue: 0xFF4D9EFF),
  GameItem(name: 'Gold Fang', weapon: 'Knife', rarity: 'Extraordinary', colorValue: 0xFFFFC857),
];

const demoCases = [
  {'name': 'NEON STRIKE', 'price': 250, 'tag': 'POPULAR', 'gradient': [0xFF25205B, 0xFF10182D]},
  {'name': 'CYBER FORCE', 'price': 450, 'tag': 'NEW', 'gradient': [0xFF123F52, 0xFF10182D]},
  {'name': 'GOLD RUSH', 'price': 900, 'tag': 'RARE', 'gradient': [0xFF5A3A16, 0xFF171521]},
];
