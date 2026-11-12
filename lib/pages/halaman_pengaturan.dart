import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});
  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  final _nama = TextEditingController(text: PengaturanHelper.muatNama());

  @override
  void dispose() {
    _nama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gelap = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final tema = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Mode gelap'),
            value: gelap,
            onChanged: tema.setGelap,
          ),
          TextField(
            controller: _nama,
            decoration: const InputDecoration(labelText: 'Nama pelanggan'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              await PengaturanHelper.simpanNama(_nama.text);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nama tersimpan')),
                );
              }
            },
            child: const Text('Simpan nama'),
          ),
          OutlinedButton(
            onPressed: () async {
              await tema.reset();
              if (mounted) _nama.clear();
            },
            child: const Text('Reset pengaturan'),
          ),
        ],
      ),
    );
  }
}
