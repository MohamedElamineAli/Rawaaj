class Review {
  final String username;
  final double rating; // Rating out of 5
  final String comment;
  // you should add the product id in the database

  Review({
    required this.username,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      username: json['username'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'rating': rating,
      'comment': comment,
    };
  }

  Review copyWith({
    String? username,
    double? rating,
    String? comment,
  }) {
    return Review(
      username: username ?? this.username,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }
}
