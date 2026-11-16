class BrowserSessionStorage {
  BrowserSessionStorage._();

  static final instance = BrowserSessionStorage._();

  final Map<String, String> _values = {};

  Future<String?> read({required String key}) async => _values[key];

  Future<void> write({required String key, required String value}) async {
    _values[key] = value;
  }

  Future<void> delete({required String key}) async {
    _values.remove(key);
  }
}
