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
}