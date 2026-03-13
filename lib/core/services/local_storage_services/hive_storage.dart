import 'package:fruits_app/core/models/product_model.dart';
import 'package:fruits_app/core/models/review_model.dart';
import 'package:fruits_app/core/services/local_storage_services/local_storage_service.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../../features/cart/data/models/cart_item_model.dart';
import '../../../features/cart/data/models/cart_model.dart';

class HiveStorage extends LocalStorageService {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemModelAdapter());
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(ReviewModelAdapter());
  }

  @override
  Future<void> saveData({
    required String boxName,
    required String key,
    required value,
  }) async {
    var box = Hive.isBoxOpen(boxName)
        ? Hive.box(boxName)
        : await Hive.openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> getData<T>({required String boxName, required String key}) async {
    var box = Hive.isBoxOpen(boxName)
        ? Hive.box(boxName)
        : await Hive.openBox(boxName);
    if (!Hive.isBoxOpen(boxName)) {
      throw Exception('Box $boxName is not open. Open it in main() or init().');
    }
    return box.get(key);
  }

  @override
  Future<void> removeData({
    required String boxName,
    required String key,
  }) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
