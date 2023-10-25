import 'package:carena/models/reviewandratings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewAndRatingsCard extends StatelessWidget {
  final RatingAndReview ratingAndReview;
  const ReviewAndRatingsCard({super.key, required this.ratingAndReview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ratingAndReview.review,
              style: const TextStyle(fontSize: 16.0),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(ratingAndReview.profileImage),
              ),
              title: Text(
                ratingAndReview.username,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              trailing: RatingBarIndicator(
                rating: ratingAndReview.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
