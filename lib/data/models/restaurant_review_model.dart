class RestaurantReviewModel {
  final String id;
  final String name;
  final String review;

  RestaurantReviewModel({
    required this.id,
    required this.name,
    required this.review,
  });

  factory RestaurantReviewModel.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewModel(
        id: json['id'],
        name: json['name'],
        review: json['review'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'review': review,
      };
}