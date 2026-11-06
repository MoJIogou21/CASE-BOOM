import 'package:flutter/material.dart';
import '../state/game_state.dart';
import '../models/game_item.dart';
import '../data/demo_data.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key, required this.game, required this.caseName, required this.price});
  final GameState game;
  final String caseName;
  final int price;

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> with SingleTickerProviderStateMixin {
  static const double tileWidth = 118;
  static const int winnerIndex = 34;

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5600),
  );

  late final List<GameItem> strip;
  GameItem? winner;
  bool started = false;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    strip = List.generate(42, (i) {
      // A fixed demo sequence. The server will choose the result in production.
      if (i == winnerIndex) return demoItems[2];
      return demoItems[(i * 3 + 1) % demoItems.length];
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => finished = true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> openCase() async {
    if (started) return;
    final item = widget.game.openDemoCase(widget.price);
    if (item == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Недостаточно BOOM COINS')),
      );
      return;
    }

    // Demo only: force the visual winner to match the local demo reward.
    setState(() {
      winner = item;
      started = true;
    });
    await controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caseName),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
        child: Column(
          children: [
            const Text(
              'ОДИН КЕЙС. ОДИН ДРОП.',
              style: TextStyle(
                color: Color(0xFFAAA3D5),
                letterSpacing: 2.2,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 190,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF111626),
                        border: Border.all(color: const Color(0xFF5547A7)),
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: CurvedAnimation(
                        parent: controller,
                        curve: Curves.easeOutCubic,
                      ),
                      builder: (context, child) {
                        final progress = Curves.easeOutCubic.transform(controller.value);
                        final screenWidth = MediaQuery.of(context).size.width - 32;
                        final start = screenWidth / 2 - tileWidth / 2;
                        final end = start - winnerIndex * tileWidth;
                        final offset = started ? start + (end - start) * progress : start;
                        return Positioned(
                          left: offset,
                          top: 12,
                          bottom: 12,
                          child: Row(
                            children: List.generate(strip.length, (i) {
                              final item = i == winnerIndex && winner != null
                                  ? winner!
                                  : strip[i];
                              return _RouletteTile(item: item, selected: i == winnerIndex);
                            }),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 3,
                        height: 190,
                        color: const Color(0xFFFFC857),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 0,
                        height: 0,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.transparent, width: 9),
                            right: BorderSide(color: Colors.transparent, width: 9),
                            top: BorderSide(color: Color(0xFFFFC857), width: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!started)
              const Text(
                'Нажми кнопку и попробуй удачу',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60),
              )
            else if (!finished)
              const Text(
                'РУЛЕТКА В ДВИЖЕНИИ...',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
              )
            else if (winner != null) ...[
              const Text('ТВОЙ ДРОП', style: TextStyle(color: Colors.white54, letterSpacing: 2)),
              const SizedBox(height: 7),
              Text(
                winner!.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color(winner!.colorValue),
                ),
              ),
              Text('${winner!.weapon} • ${winner!.rarity} • ${winner!.wear}',
                  style: const TextStyle(color: Colors.white70)),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: started ? null : openCase,
                child: Text(started ? (finished ? 'КЕЙС ОТКРЫТ' : 'ОТКРЫВАЕМ...') : 'ОТКРЫТЬ ЗА ${widget.price} COINS'),
              ),
            ),
            if (finished)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ВЕРНУТЬСЯ К КЕЙСАМ'),
              ),
          ],
        ),
      ),
    );
  }
}

class _RouletteTile extends StatelessWidget {
  const _RouletteTile({required this.item, required this.selected});
  final GameItem item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = Color(item.colorValue);
    return Container(
      width: 118,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: .18) : const Color(0xFF1B2132),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: selected ? color : Colors.white10, width: selected ? 2 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.military_tech_rounded, size: 48, color: color),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(item.weapon, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          ),
          const SizedBox(height: 3),
          Text(item.rarity, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}
