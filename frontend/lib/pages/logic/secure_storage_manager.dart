import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  SecureStorageManager._privateConstructor();

  static final SecureStorageManager _instance = SecureStorageManager._privateConstructor();

  static SecureStorageManager get instance => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}