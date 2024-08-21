class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromMap(dynamic map) {
    return switch (map) {
      {
        "id": final String id,
        "name": final String name,
        "email": final String email,
      } =>
        UserModel(id: id, name: name, email: email),
      _ => throw ArgumentError("Erro eo Transformar o Usuário"),
    };
  }
}
