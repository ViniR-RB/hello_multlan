sealed class Configuration {
  static const String _baseUrl = String.fromEnvironment("API_URL");
  static const String _publicStorage = String.fromEnvironment("PUBLIC_STORAGE");
  static String get baseUrl => _baseUrl;
  static String get publicStorage => _publicStorage;

  static void validate() {
    if (_baseUrl.isEmpty) {
      throw AssertionError('A variável de ambiente API_URL não está definida');
    }
    if (_publicStorage.isEmpty) {
      throw AssertionError(
          'A variável de ambiente PUBLIC_STORAGE não está definida');
    }
  }
}
