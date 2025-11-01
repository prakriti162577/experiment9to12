class Butterfly {
  final String scientificName;
  final String rank;
  final String imageUrl;

  const Butterfly({
    required this.scientificName,
    required this.rank,
    required this.imageUrl,
  });

  factory Butterfly.fromJson(Map<String, dynamic> json) {
    final media = json['media'] as List<dynamic>? ?? [];
    final imageUrl = media.isNotEmpty ? media.first['identifier'] ?? '' : '';

    return Butterfly(
      scientificName: json['scientificName'] ?? 'Unknown',
      rank: json['rank'] ?? 'Unknown',
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
    'scientificName': scientificName,
    'rank': rank,
    'imageUrl': imageUrl,
  };
}