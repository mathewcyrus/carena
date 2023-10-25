class RatingAndReview {
  final String username;
  final String useruid;
  final String profileImage;
  final String driveruid;
  final String review;
  final double rating;
  final String uid;
  final DateTime reviewdate;

  const RatingAndReview({
    required this.username,
    required this.useruid,
    required this.profileImage,
    required this.review,
    required this.driveruid,
    required this.rating,
    required this.uid,
    required this.reviewdate,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "useruid": useruid,
        "profileImage": profileImage,
        "review": review,
        "driveruid": driveruid,
        "rating": rating,
        "uid": uid,
        "reviewdate": reviewdate,
      };

  factory RatingAndReview.fromJson(Map<String, dynamic> json) {
    return RatingAndReview(
      username: json['username'],
      useruid: json['useruid'],
      profileImage: json['profileImage'],
      review: json['review'],
      rating: json['rating'],
      driveruid: json['driveruid'],
      uid: json['uid'],
      reviewdate: json['reviewdate'].toDate(),
    );
  }
}
