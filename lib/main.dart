
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/theme_cubit.dart';
import 'helpers/hive_helper.dart';
import 'helpers/pengaturan_helper.dart';
import 'pages/halaman_produk.dart';
import 'pages/halaman_favorit.dart';
import 'pages/halaman_pengaturan.dart';
import 'pages/halaman_nama.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bukaBoxFavorit();
  await PengaturanHelper.init();
  runApp(
    BlocProvider(create: (_) => ThemeCubit(), child: const KantinKampusApp()),
  );
}

class KantinKampusApp extends StatelessWidget {
  const KantinKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kantin Kampus',
        theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.teal,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        themeMode: mode,
        home: const HalamanUtama(),
      ),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int index = 0;
  final halaman = const [
    HalamanProduk(),
    HalamanFavorit(),
    HalamanPengaturan(),
    HalamanNama(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (nilai) => setState(() => index = nilai),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produk',
          ),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorit'),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Nama'),
        ],
      ),
    );
  }
}