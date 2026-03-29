abstract class LocalStorageService {
  Future<void> init();

  Future<void> saveData({
    required String boxName,
    required String key,
    required dynamic value,
  });

  Future<T?> getData<T>({required String boxName, required String key});

  Future<void> removeData({required String boxName, required String key});

  Future<void> clearBox(String boxName);
}
