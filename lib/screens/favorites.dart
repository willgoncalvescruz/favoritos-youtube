import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/api.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        //foregroundColor: Color.fromARGB(99, 255, 255, 255),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(221, 192, 83, 83),
              Color.fromARGB(221, 192, 83, 83),
              Color.fromARGB(255, 0, 0, 0),
            ],
          )),
        ),
        title: const Text("Favoritos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 192, 83, 83),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border_rounded,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(221, 59, 59, 59),
      body: StreamBuilder<Map<String, Video>>(
          stream: bloc.outFav,
          initialData: const {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((v) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: api_key, videoId: v.id);
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 80,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
