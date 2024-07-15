class Tokens {
  final String acessToken;
  final String refreshToken;
  Tokens({
    required this.acessToken,
    required this.refreshToken,
  });

  factory Tokens.fromMap(Map map) {
    return switch (map) {
      {
        "accessToken": final String acessToken,
        "refreshToken": final String refreshToken
      } =>
        Tokens(
          acessToken: acessToken,
          refreshToken: refreshToken,
        ),
      _ => throw ArgumentError("Invalid map $map")
    };
  }
}
