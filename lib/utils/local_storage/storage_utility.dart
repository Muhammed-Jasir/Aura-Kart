import 'package:get_storage/get_storage.dart';

class ALocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static ALocalStorage? _instance;
  static bool _isInitialized = false;

  ALocalStorage._internal();

  static bool get isInitialized => _isInitialized;

  factory ALocalStorage.instance() {
    if (!_isInitialized || _instance == null) {
      throw StateError('ALocalStorage is not initialized. Call init() first.');
    }
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = ALocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
    _isInitialized = true;
  }

  // Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
