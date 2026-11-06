import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../state/game_state.dart';
import 'opening_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.game});
  final GameState game;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: game,
      builder: (_, __) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Row(children: [
                const Expanded(child: Text('CASE BOOM', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, letterSpacing: 1.4))),
                _CoinPill(coins: game.coins),
              ]),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: _HeroBanner(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text('ВЫБЕРИ КЕЙС', style: TextStyle(fontSize: 13, letterSpacing: 2, color: Color(0xFF9CA3B8), fontWeight: FontWeight.bold)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            sliver: SliverList.builder(
              itemCount: demoCases.length,
              itemBuilder: (context, i) {
                final c = demoCases[i];
                final colors = (c['gradient'] as List<int>).map((v) => Color(v)).toList();
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white.withOpacity(.08)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(children: [
                      Container(
                        width: 78, height: 78,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(.07), borderRadius: BorderRadius.circular(18)),
                        child: const Icon(Icons.inventory_2_rounded, size: 42, color: Color(0xFFB7A8FF)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(c['tag'] as String, style: const TextStyle(color: Color(0xFFB8A9FF), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                        const SizedBox(height: 5),
                        Text(c['name'] as String, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                        Text('${c['price']} BOOM COINS', style: const TextStyle(color: Color(0xFFB5B9C9), fontSize: 11)),
                      ])),
                      FilledButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => OpeningScreen(game: game, caseName: c['name'] as String, price: c['price'] as int),
                        )),
                        child: const Text('ОТКРЫТЬ'),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinPill extends StatelessWidget {
  const _CoinPill({required this.coins});
  final int coins;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(color: const Color(0xFF1B2033), borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0xFF6654C8))),
    child: Row(children: [const Icon(Icons.bolt, color: Color(0xFFFFC857), size: 17), const SizedBox(width: 5), Text('$coins', style: const TextStyle(fontWeight: FontWeight.bold))]),
  );
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();
  @override
  Widget build(BuildContext context) => Container(
    height: 145, padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF654BDF), Color(0xFF1D2E63)]),
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('ТВОЙ СЛЕДУЮЩИЙ ДРОП', style: TextStyle(fontSize: 11, letterSpacing: 1.7, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('ОТКРЫВАЙ. СОБИРАЙ.\nПОПАДАЙ В ТОП.', style: TextStyle(fontSize: 21, height: 1.1, fontWeight: FontWeight.w900)),
      SizedBox(height: 7),
      Text('Только виртуальные предметы', style: TextStyle(color: Colors.white70, fontSize: 11)),
    ]),
  );
}
