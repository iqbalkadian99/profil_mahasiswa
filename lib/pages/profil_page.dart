import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';
import '../models/profile.dart';
import '../widgets/hobby_item.dart';
import '../widgets/info_card.dart';
import '../widgets/skill_item.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final Profile profile = Profile(
    nama: 'Iqbal Kadian',
    nim: '25552012024',
    jurusan: 'Teknik Informatika',
    email: 'iqbalkadian@gmail.com',
    telepon: '082258679330',
    hobi: ['Coding', 'Musik', 'Game', 'Membaca', 'Fotografi', 'Traveling'],
    skill: ['Flutter', 'Dart', 'UI/UX Design', 'Git & GitHub'],
  );

  void _salin(String teks, String label) {
    Clipboard.setData(ClipboardData(text: teks));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$label disalin')));
  }

  Future<void> _tambahSkill() async {
    final controller = TextEditingController();
    final hasil = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Skill'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nama skill'),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (hasil != null) setState(() => profile.tambahSkill(hasil));
  }

  Future<void> _tambahHobi() async {
    final controller = TextEditingController();
    final hasil = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Hobi'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nama hobi'),
          onSubmitted: (v) => Navigator.pop(context, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    final nama = hasil?.trim() ?? '';
    if (nama.isNotEmpty && !profile.hobi.contains(nama)) {
      setState(() => profile.hobi.add(nama));
    }
  }

  Future<void> _aksiHobi(int index) async {
    final nama = profile.hobi[index];
    final hapus = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(nama, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Hapus hobi'),
            ),
          ],
        ),
      ),
    );
    if (hapus == true) setState(() => profile.hobi.removeAt(index));
  }

  Future<void> _editProfil() async {
    final namaC = TextEditingController(text: profile.nama);
    final nimC = TextEditingController(text: profile.nim);
    final jurusanC = TextEditingController(text: profile.jurusan);
    final emailC = TextEditingController(text: profile.email);
    final teleponC = TextEditingController(text: profile.telepon);

    final simpan = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaC,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: nimC,
                decoration: const InputDecoration(labelText: 'NIM'),
              ),
              TextField(
                controller: jurusanC,
                decoration: const InputDecoration(labelText: 'Jurusan'),
              ),
              TextField(
                controller: emailC,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: teleponC,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (simpan == true) {
      setState(() {
        if (namaC.text.trim().isNotEmpty) profile.nama = namaC.text.trim();
        if (nimC.text.trim().isNotEmpty) profile.nim = nimC.text.trim();
        if (jurusanC.text.trim().isNotEmpty) {
          profile.jurusan = jurusanC.text.trim();
        }
        if (emailC.text.trim().isNotEmpty) profile.email = emailC.text.trim();
        if (teleponC.text.trim().isNotEmpty) {
          profile.telepon = teleponC.text.trim();
        }
      });
    }

    namaC.dispose();
    nimC.dispose();
    jurusanC.dispose();
    emailC.dispose();
    teleponC.dispose();
  }

  Widget _foto(double size) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: cs.surface, width: 5),
        boxShadow: const [BoxShadow(blurRadius: 12, color: Colors.black26)],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/foto.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: cs.primaryContainer,
            alignment: Alignment.center,
            child: Text(
              profile.inisial,
              style: TextStyle(
                fontSize: size / 3,
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final cs = Theme.of(context).colorScheme;
    const double tinggiBanner = 170;
    const double ukuranFoto = 120;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: tinggiBanner,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primary, cs.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
        ),
        Positioned(
          bottom: -ukuranFoto / 2,
          child: _foto(ukuranFoto),
        ),
      ],
    );
  }

  Widget _judul(String teks) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(
          teks,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        actions: [
          IconButton(
            tooltip: 'Edit profil',
            icon: const Icon(Icons.edit),
            onPressed: _editProfil,
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => IconButton(
              tooltip: 'Ganti tema',
              icon: Icon(mode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () => context.read<ThemeCubit>().toggle(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahSkill,
        icon: const Icon(Icons.add),
        label: const Text('Skill'),
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          // Responsif: batasi lebar konten & atur jumlah kolom grid.
          final lebar = c.maxWidth;
          final kolom = lebar >= 900 ? 4 : (lebar >= 600 ? 3 : 2);
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 96),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    _header(),
                    const SizedBox(height: 68),
                    Text(
                      profile.nama,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text('NIM ${profile.nim}'),
                    const SizedBox(height: 8),
                    ActionChip(
                      avatar: Icon(Icons.verified_user,
                          size: 18, color: cs.onSecondaryContainer),
                      label: Text('Status: ${profile.status.label}'),
                      backgroundColor: cs.secondaryContainer,
                      onPressed: () => setState(profile.gantiStatus),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _judul('Informasi'),
                            InfoCard(
                              icon: Icons.school,
                              title: 'Jurusan',
                              value: profile.jurusan,
                            ),
                            InfoCard(
                              icon: Icons.email,
                              title: 'Email',
                              value: profile.email,
                              onTap: () => _salin(profile.email, 'Email'),
                            ),
                            InfoCard(
                              icon: Icons.phone,
                              title: 'Telepon',
                              value: profile.telepon,
                              onTap: () => _salin(profile.telepon, 'Telepon'),
                            ),
                            Row(
                              children: [
                                Expanded(child: _judul('Hobi')),
                                IconButton(
                                  tooltip: 'Tambah hobi',
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: _tambahHobi,
                                ),
                              ],
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profile.hobi.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: kolom,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.4,
                              ),
                              itemBuilder: (_, i) => HobbyItem(
                                hobi: profile.hobi[i],
                                onTap: () => _aksiHobi(i),
                              ),
                            ),
                            _judul('Skill'),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profile.skill.length,
                              itemBuilder: (_, i) => SkillItem(
                                skill: profile.skill[i],
                                index: i,
                                onDelete: () =>
                                    setState(() => profile.hapusSkill(i)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}