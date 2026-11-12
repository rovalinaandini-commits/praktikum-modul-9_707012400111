import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/hive_helper.dart';
import '../models/produk_favorit.dart';

class HalamanFavorit extends StatelessWidget {
  const HalamanFavorit({super.key});

  Future<void> editCatatan(BuildContext context,
      ProdukFavorit favorit) async {
    var draf = favorit.catatan;
    final hasil = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah catatan'),
        content: TextFormField(
          initialValue: draf,
          onChanged: (nilai) => draf = nilai,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, draf.trim()),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (hasil == null || !favorit.isInBox) return;
    favorit.catatan = hasil;
    await favorit.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk Favorit')),
      body: ValueListenableBuilder<Box<ProdukFavorit>>(
        valueListenable: boxFavorit.listenable(),
        builder: (context, box, _) {
          final daftar = box.values.toList();
          if (daftar.isEmpty) {
            return const Center(child: Text('Belum ada favorit'));
          }
          return ListView.builder(
            itemCount: daftar.length,
            itemBuilder: (context, index) {
              final favorit = daftar[index];
              return ListTile(
                title: Text(favorit.nama),
                subtitle: Text('Rp${favorit.harga} | ${favorit.catatan}'),
                onTap: () => editCatatan(context, favorit),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => box.delete(favorit.idProduk),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
