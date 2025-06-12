class Pokemon {
  final int? id;
  final String nome;
  final String tipo;
  final String imageAsset;
  final bool estaNaEquipe;

  Pokemon({
    this.id,
    required this.nome,
    required this.tipo,
    required this.imageAsset,
    required this.estaNaEquipe,
  });

  Pokemon copyWith({
    int? id,
    String? nome,
    String? tipo,
    String? imageAsset,
    bool? estaNaEquipe,
  }) {
    return Pokemon(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      imageAsset: imageAsset ?? this.imageAsset,
      estaNaEquipe: estaNaEquipe ?? this.estaNaEquipe,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'imageAsset': imageAsset,
      'estaNaEquipe': estaNaEquipe ? 1 : 0,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'],
      nome: map['nome'],
      tipo: map['tipo'],
      imageAsset: map['imageAsset'] ?? 'assets/images/placeholder.png',
      estaNaEquipe: map['estaNaEquipe'] == 1,
    );
  }
}