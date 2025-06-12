class Movement {
  final int? id;
  final int pokemonId;
  final String pokemonName;
  final String pokemonImageAsset;
  final String movedTo;
  final DateTime timestamp;

  Movement({
    this.id,
    required this.pokemonId,
    required this.pokemonName,
    required this.pokemonImageAsset,
    required this.movedTo,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pokemonId': pokemonId,
      'pokemonName': pokemonName,
      'pokemonImageAsset': pokemonImageAsset,
      'movedTo': movedTo,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id'],
      pokemonId: map['pokemonId'],
      pokemonName: map['pokemonName'],
      pokemonImageAsset: map['pokemonImageAsset'],
      movedTo: map['movedTo'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}