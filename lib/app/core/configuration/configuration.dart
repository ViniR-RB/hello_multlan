sealed class Configuration {
  static const String _baseUrl = String.fromEnvironment("API_URL");
  static String get baseUrl => _baseUrl;
}
