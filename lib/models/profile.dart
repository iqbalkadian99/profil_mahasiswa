/// Enum status mahasiswa.
enum StatusMahasiswa { aktif, cuti, lulus }

extension StatusMahasiswaX on StatusMahasiswa {
  String get label {
    switch (this) {
      case StatusMahasiswa.aktif:
        return 'Aktif';
      case StatusMahasiswa.cuti:
        return 'Cuti';
      case StatusMahasiswa.lulus:
        return 'Lulus';
    }
  }

  /// Status berikutnya (dipakai untuk demo manipulasi data).
  StatusMahasiswa get berikutnya =>
      StatusMahasiswa.values[(index + 1) % StatusMahasiswa.values.length];
}

class Profile {
  String nama;
  String nim;
  String jurusan;
  String email;
  String telepon;
  List<String> hobi;
  List<String> skill;
  StatusMahasiswa status;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.hobi,
    required this.skill,
    this.status = StatusMahasiswa.aktif,
  });

  /// Inisial nama, contoh "Budi Santoso" -> "BS".
  String get inisial {
    final parts = nama.trim().split(RegExp(r'\s+'));
    return parts.take(2).map((e) => e.isEmpty ? '' : e[0].toUpperCase()).join();
  }

  String get ringkasan => '$nama • $nim • $jurusan';

  void tambahSkill(String nama) {
    final s = nama.trim();
    if (s.isNotEmpty && !skill.contains(s)) skill.add(s);
  }

  void hapusSkill(int index) => skill.removeAt(index);

  void gantiStatus() => status = status.berikutnya;
}
