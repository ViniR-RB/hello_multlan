class Tokens {
  final String acessToken;
  final String refreshToken;
  Tokens({
    required this.acessToken,
    required this.refreshToken,
  });

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "acess_token": final String acessToken,
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
