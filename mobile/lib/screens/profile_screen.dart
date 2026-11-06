import 'package:flutter/material.dart';
import '../state/game_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.game});
  final GameState game;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: game,
    builder: (_, __) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ПРОФИЛЬ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 24),
        Container(
          width: double.infinity, padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF654BDF), Color(0xFF1D2E63)]), borderRadius: BorderRadius.circular(22)),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 28, child: Icon(Icons.person, size: 32)),
            SizedBox(height: 12),
            Text('PLAYER', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            Text('Уровень 1 • Новичок', style: TextStyle(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: 18),
        _Stat(label: 'Предметов в инвентаре', value: '${game.inventory.length}'),
        _Stat(label: 'BOOM COINS', value: '${game.coins}'),
        const _Stat(label: 'Открыто кейсов', value: 'Демо'),
      ]),
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(label, style: const TextStyle(color: Colors.white60)),
    trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
