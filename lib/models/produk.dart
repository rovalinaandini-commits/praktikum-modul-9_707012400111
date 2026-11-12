class Produk {
  final String id;
  final String nama;
  final int harga;
  const Produk({required this.id, required this.nama, required this.harga});
}

const daftarProduk = <Produk>[
  Produk(id: 'p1', nama: 'Nasi Goreng', harga: 15000),
  Produk(id: 'p2', nama: 'Es Teh Manis', harga: 5000),
  Produk(id: 'p3', nama: 'Ayam Geprek', harga: 18000),
];
