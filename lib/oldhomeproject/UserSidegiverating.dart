import 'package:flutter/material.dart';
import 'package:old/oldhomeproject/url.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class Rating extends StatefulWidget {
  int uid;
  int ohid;

  Rating({Key? key, required this.uid, required this.ohid}) : super(key: key);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating = 0;
  Future<void> giveRating() async {
    var res = await http.patch(
        Uri.parse(
            'http://${IpAdress.ip}/OldHome1/api/oldhome/rating?id=${widget.ohid}&rating=${rating}'),
        body: {
          //'Rating': rating.toString(),
        });
    if (res.statusCode == 200) {
      print(res.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Give Rating'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SmoothStarRating(
                  rating: 3,
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
                    giveRating();
                  },
                  child: Text('Rate')),
            ],
          ),
        ),
      ),
    );
  }
}
