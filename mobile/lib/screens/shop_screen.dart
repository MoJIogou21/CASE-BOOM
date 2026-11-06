import 'package:flutter/material.dart';
import '../state/game_state.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key, required this.game});
  final GameState game;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: game,
    builder: (_, __) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('МАГАЗИН', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text('Баланс: ${game.coins} BOOM COINS', style: const TextStyle(color: Color(0xFFFFC857))),
        const SizedBox(height: 22),
        const Text('НАБОРЫ МОНЕТ', style: TextStyle(letterSpacing: 1.5, color: Colors.white60, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        for (final pack in [(500, 'STARTER'), (1500, 'BOOST'), (5000, 'MEGA')])
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(color: const Color(0xFF171C2D), borderRadius: BorderRadius.circular(18)),
            child: Row(children: [
              const Icon(Icons.bolt, color: Color(0xFFFFC857), size: 30),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(pack.$2, style: const TextStyle(fontWeight: FontWeight.w900)),
                Text('${pack.$1} BOOM COINS', style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ])),
              FilledButton(onPressed: () {
                game.purchaseCoins(pack.$1);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Демо: монеты начислены')));
              }, child: const Text('ЗАБРАТЬ')),
            ]),
          ),
        const Spacer(),
        const Text('Сейчас магазин работает в демо-режиме. Платёжная интеграция будет добавлена отдельно.', style: TextStyle(color: Colors.white38, fontSize: 11)),
      ]),
    ),
  );
}
