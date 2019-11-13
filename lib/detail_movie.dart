import 'package:flutter/material.dart';

class DetailMovie extends StatefulWidget {
  final String imageMovie;
  final String titleMovie;
  final String descMovie;
  final String synopsisMovie;

  @override
  State<StatefulWidget> createState() {
    return DetailMovieState();
  }

  DetailMovie(
      {this.imageMovie, this.titleMovie, this.descMovie, this.synopsisMovie});
}

class DetailMovieState extends State<DetailMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleMovie),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.network(
              widget.imageMovie,
              height: 200,
              fit: BoxFit.fill,
            ),
            width: double.infinity,
          ),
          Text(widget.titleMovie),
          Text(widget.descMovie),
          Text(widget.synopsisMovie)
        ],
      ),
    );
  }
}
