class Review {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String productId;
  final double rating;
  final String comment;
  final List<String> images;
  final DateTime createdAt;
  final int likes;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.images,
    required this.createdAt,
    required this.likes,
  });
}
