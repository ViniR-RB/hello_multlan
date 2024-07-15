sealed class Configuration {
  static const String _baseUrl = String.fromEnvironment("API_URL");
  static String get baseUrl => _baseUrl;

  static void validate() {
    if (_baseUrl.isEmpty) {
      throw AssertionError('A variável de ambiente API_URL não está definida');
    }
  }
}
