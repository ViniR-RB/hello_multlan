class Tokens {
  final String acessToken;
  final String refreshToken;
  Tokens({
    required this.acessToken,
    required this.refreshToken,
  });

  factory Tokens.toMap(Map map) {
    return switch (map) {
      {
        "access_token": final String acessToken,
        "refresh_token": final String refreshToken
      } =>
        Tokens(
          acessToken: acessToken,
          refreshToken: refreshToken,
        ),
      _ => throw ArgumentError("Invalid map $map")
    };
  }
}
