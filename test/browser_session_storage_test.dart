import 'package:flutter_test/flutter_test.dart';
import 'package:owner_web/services/browser_session_storage.dart';

void main() {
  test('keeps values in the current app session and deletes them', () async {
    final storage = BrowserSessionStorage.instance;
    await storage.delete(key: 'test-token');

    expect(await storage.read(key: 'test-token'), isNull);
    await storage.write(key: 'test-token', value: 'session-value');
    expect(await storage.read(key: 'test-token'), 'session-value');

    await storage.delete(key: 'test-token');
    expect(await storage.read(key: 'test-token'), isNull);
  });
}
