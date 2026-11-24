import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final String skill;
  final int index;
  final VoidCallback onDelete;

  const SkillItem({
    super.key,
    required this.skill,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.secondaryContainer,
          foregroundColor: cs.onSecondaryContainer,
          child: Text('${index + 1}'),
        ),
        title: Text(skill, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: IconButton(
          tooltip: 'Hapus skill',
          icon: Icon(Icons.delete_outline, color: cs.error),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
