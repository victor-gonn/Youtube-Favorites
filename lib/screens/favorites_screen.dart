import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/bloc/FavoriteBloc.dart';
import 'package:youtube_favoritos/models/video-model.dart';

class FavScreen extends StatelessWidget {
   FavScreen({super.key});

  @override

  final bloc = BlocProvider.getBloc<FavoritesBloc>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
       builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView(
          children: 
            snapshot.data!.values.map((v) {
              
                return InkWell(
                  
                  onLongPress: () {
                    bloc.toggleFav(v);
                  },
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text(v.title,
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,))
                  ],
                ),
              );
              
              
            }).toList(),
          
        );
        } else { 
          return Container();

        }
        
       }),
    );
  }
}