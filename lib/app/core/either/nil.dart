class Nil {
  const Nil();

  @override
  String toString() {
    return "Nil";
  }
}

Nil get nil => const Nil();
