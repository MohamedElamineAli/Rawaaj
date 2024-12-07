abstract class Outfit {
  final int id;
  final String outfitImage;
  final int numOfLikes;
  final bool isLiked;
  final String description;
  final List<int> outfitComponents; // Product IDs

  Outfit({
    required this.id,
    required this.outfitImage,
    required this.numOfLikes,
    required this.isLiked,
    required this.description,
    required this.outfitComponents,
  });
}