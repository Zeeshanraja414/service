import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingsWidget extends StatefulWidget {
  @override
  _RatingsWidgetState createState() => _RatingsWidgetState();
}

class _RatingsWidgetState extends State<RatingsWidget> {
  late double rating;
  @override
  void initState() {
    rating = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SmoothStarRating(
                  //rating: 5,
                  starCount: 5,
                  isReadOnly: false,
                  size: 50,
                  spacing: 3,
                  allowHalfRating: true,
                  onRated: (value) {
                    setState(() {
                      rating = value;
                    });
                  }),
              ElevatedButton(
                  onPressed: () {
                    print(rating);
                  },
                  child: Text('ok')),
              SmoothStarRating(
                  rating: rating,
                  starCount: 5,
                  isReadOnly: false,
                  size: 50,
                  spacing: 3,
                  allowHalfRating: true,
                  onRated: (val) {
                    setState(() {
                      rating = rating;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
