import 'package:flutter/material.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanNama extends StatelessWidget {
  const HalamanNama({super.key});

  @override
  Widget build(BuildContext context) {
    final String nama = PengaturanHelper.muatNama();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',
      home: Scaffold(
        appBar: AppBar(title: const Text('Pengaturan')),
        body: Column(
          children: [
            TextField(
              controller: TextEditingController(text: nama),
              decoration: const InputDecoration(labelText: 'Nama pelanggan'),
            ),
          ],
        ),
      ),
    );
  }
}