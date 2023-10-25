class Post {
  final String username;
  final String uid;
  final String postcaption;
  final String postId;
  final String profileImage;

  final DateTime dateposted;
  final List<String> imagesurls;
  final List<Map<String, dynamic>> likes;
  final List<Map<String, dynamic>> shares;
  final List<Map<String, dynamic>> carspecifications;

  const Post({
    required this.username,
    required this.profileImage,
    required this.uid,
    required this.postId,
    required this.postcaption,
    required this.dateposted,
    required this.imagesurls,
    required this.likes,
    required this.shares,
    required this.carspecifications,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'] as String,
      profileImage: json['profileimage'] as String,
      postcaption: json['postcaption'] as String,
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      dateposted: (json['dateposted']).toDate(),
      imagesurls: (json['imagesurls'] as List).map((e) => e as String).toList(),
      likes: (json['likes'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      shares: (json['shares'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      carspecifications: (json['carSpecifications'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "profileimage": profileImage,
        "postcaption": postcaption,
        "uid": uid,
        "postId": postId,
        "dateposted": dateposted,
        "likes": likes,
        "shares": shares,
        "imagesurls": imagesurls,
        "carSpecifications": carspecifications
      };
}
