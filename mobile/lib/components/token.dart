import 'package:mobile/components/storage.dart';

bool writeToken(String token) {
    try {
      writeSecureData('token', token);
    } catch (e) {
      return false;
    }
    return true;
}

bool deleteToken() {
    try {
      deleteSecureData('token');
    } catch (e) {
      return false;
    }
    return true;
}

Future<String?> getToken() async {
    return await readSecureData('token');
}