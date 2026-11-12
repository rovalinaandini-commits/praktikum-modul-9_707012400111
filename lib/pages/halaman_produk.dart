import 'package:flutter/material.dart';
import '../helpers/hive_helper.dart';
import '../models/produk.dart';
import '../models/produk_favorit.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});

  Future<void> simpanFavorit(BuildContext context, Produk produk) async {
    if (boxFavorit.containsKey(produk.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk sudah ada di favorit')),
      );
      return;
    }
    await boxFavorit.put(
      produk.id,
      ProdukFavorit(idProduk: produk.id,
        nama: produk.nama, harga: produk.harga),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${produk.nama} disimpan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk Kantin')),
      body: ListView.builder(
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          final produk = daftarProduk[index];
          return Card(
            child: ListTile(
              title: Text(produk.nama),
              subtitle: Text('Rp${produk.harga}'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                tooltip: 'Tambah favorit',
                onPressed: () => simpanFavorit(context, produk),
              ),
            ),
          );
        },
      ),
    );
  }
}
