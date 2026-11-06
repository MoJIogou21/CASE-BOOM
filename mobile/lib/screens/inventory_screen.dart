import 'package:flutter/material.dart';
import '../state/game_state.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key, required this.game});
  final GameState game;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: game,
    builder: (_, __) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ИНВЕНТАРЬ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text('${game.inventory.length} предметов', style: const TextStyle(color: Colors.white60)),
        const SizedBox(height: 18),
        Expanded(child: game.inventory.isEmpty
          ? const Center(child: Text('Здесь появятся твои первые предметы', style: TextStyle(color: Colors.white54)))
          : GridView.builder(
              itemCount: game.inventory.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.15, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (_, i) {
                final item = game.inventory[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFF171C2D), borderRadius: BorderRadius.circular(18), border: Border.all(color: Color(item.colorValue).withValues(alpha: .7))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Icon(Icons.military_tech, size: 38, color: Color(item.colorValue)),
                    Text(item.weapon, style: const TextStyle(fontWeight: FontWeight.w900)),
                    Text(item.name, style: TextStyle(color: Color(item.colorValue), fontSize: 12)),
                    Text(item.rarity, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                  ]),
                );
              },
            )),
      ]),
    ),
  );
}
