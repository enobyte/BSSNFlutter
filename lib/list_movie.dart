import 'package:flutter/material.dart';
import 'package:flutter_apps/detail_movie.dart';

class ListMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListMovieState();
  }
}

class ListMovieState extends State<ListMovie> {
  List<String> title = [
    'Movie1',
    'Movie2',
    'Movie3',
    'Movie4',
  ];

  List<String> description = [
    'Description Movie 1',
    'Description Movie 2',
    'Description Movie 3',
    'Description Movie 4',
  ];

  List<String> imagePhoto = [
    'https://upload.wikimedia.org/wikipedia/en/6/6f/War_official_poster.jpg',
    'https://m.media-amazon.com/images/M/MV5BNjQzZTNkN2YtNjRlYS00NjhjLTg5MGYtNzdkNWNmYWI5NmI3XkEyXkFqcGdeQXVyNjMzNjY2NjQ@._V1_UY1200_CR285,0,630,1200_AL_.jpg',
    'https://upload.wikimedia.org/wikipedia/en/thumb/0/00/Us_%282019%29_theatrical_poster.png/220px-Us_%282019%29_theatrical_poster.png',
    'https://m.media-amazon.com/images/M/MV5BMGQyZWNmMTAtNWE2OS00YmE0LWE4OTEtY2Y0MTk3MGQwMzczXkEyXkFqcGdeQXVyNTk3MjE0MDE@._V1_.jpg',
  ];

  List<String> synopsis = [
    'Synoposis Movie 1',
    'Synoposis Movie 2',
    'Synoposis Movie 3',
    'Synoposis Movie 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Movie'),
      ),
      body: GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: GestureDetector(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          imagePhoto[index],
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        width: double.infinity,
                      ),
                      Text(title[index]),
                      Text(description[index])
                    ],
                  ),
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetailMovie(
                          imageMovie: imagePhoto[index],
                          titleMovie: title[index],
                          descMovie: description[index],
                          synopsisMovie: synopsis[index],
                        );
                      }),
                    ) //Navigation ke Detail Movie,
                ),
          );
        },
        itemCount: title.length,
      ),
    );
  }
}
