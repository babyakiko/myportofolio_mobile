import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

// Model data untuk tombol menu dengan tambahan atribut color
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// Widget kartu tombol interaktif
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  void _showSnackBar(ScaffoldMessengerState messenger, String message) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onTap(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    switch (item.name) {
      case 'Lihat Proyek':
        navigator.push(
          MaterialPageRoute(builder: (context) => const ProjectListScreen()),
        );
      case 'Tambah Proyek':
        if (!await ensureLoggedIn(context)) return;
        navigator.push(
          MaterialPageRoute(builder: (context) => const ProjectFormPage()),
        );
      case 'Lihat Pengalaman':
        navigator.push(
          MaterialPageRoute(builder: (context) => const ExperienceListScreen()),
        );
      case 'Tambah Pengalaman':
        if (!await ensureLoggedIn(context)) return;
        navigator.push(
          MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
        );
      case 'Logout':
        final auth = context.read<AuthState>();
        if (!auth.isLoggedIn) {
          _showSnackBar(messenger, 'Kamu belum login.');
          return;
        }
        await auth.logout();
        _showSnackBar(messenger, 'Berhasil logout.');
      default:
        _showSnackBar(messenger, 'Kamu telah menekan tombol ${item.name}!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
