import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/api.dart';
import 'package:youtube_favoritos/bloc/VideoBloc.dart';
import 'package:youtube_favoritos/bloc/FavoriteBloc.dart';
import 'package:youtube_favoritos/screens/home.dart';

void main() {
  Api api = Api();
  api.search("car");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => VideosBloc()), Bloc((i) => FavoritesBloc())],
      dependencies: [],
      child: MaterialApp(
        title: 'FlutterTube',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
