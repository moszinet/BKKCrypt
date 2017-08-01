import 'package:BKKCryptDart/BKKCryptDart.dart';
import 'package:test/test.dart';

void main() {
  test('encrypt', () {
    String password = "amazingPassword";
    expect(BKKCrypt.Encrypt(password), equals(password));
  });
}
