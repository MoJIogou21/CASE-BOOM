import 'package:flutter/material.dart';
import '../state/game_state.dart';
import 'home_screen.dart';
import 'inventory_screen.dart';
import 'shop_screen.dart';
import 'profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final game = GameState();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(game: game),
      InventoryScreen(game: game),
      ShopScreen(game: game),
      ProfileScreen(game: game),
    ];
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Кейсы'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Инвентарь'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Магазин'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Профиль'),
        ],
      ),
    );
  }
}
