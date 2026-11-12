import 'package:hive_flutter/hive_flutter.dart';
import '../models/produk_favorit.dart';

late final Box<ProdukFavorit> boxFavorit;

Future<void> bukaBoxFavorit() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProdukFavoritAdapter());
  boxFavorit = await Hive.openBox<ProdukFavorit>('favoritBox');
}
