import 'package:flutter/material.dart';

class HobbyItem extends StatelessWidget {
  final String hobi;
  final VoidCallback? onTap;

  const HobbyItem({super.key, required this.hobi, this.onTap});

  IconData _icon() {
    final h = hobi.toLowerCase();
    if (h.contains('musik') || h.contains('gitar')) return Icons.music_note;
    if (h.contains('game')) return Icons.sports_esports;
    if (h.contains('baca') || h.contains('buku')) return Icons.menu_book;
    if (h.contains('olahraga') || h.contains('futsal')) return Icons.sports_soccer;
    if (h.contains('coding') || h.contains('program')) return Icons.code;
    if (h.contains('foto')) return Icons.camera_alt;
    if (h.contains('traveling') || h.contains('jalan')) return Icons.flight;
    return Icons.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(16);
    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cs.primaryContainer, cs.secondaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: radius,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_icon(), size: 28, color: cs.onPrimaryContainer),
                const SizedBox(height: 6),
                Text(
                  hobi,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}