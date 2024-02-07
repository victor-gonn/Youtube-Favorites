import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/bloc/FavoriteBloc.dart';

import '../models/video-model.dart';
import '../screens/video_player.dart';

class VideoTile extends StatelessWidget {
  VideoTile({super.key, required this.video});

  final Video video;

  final bloc = BlocProvider.getBloc<FavoritesBloc>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayer(video: video),
                        ),
                      );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.channel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: bloc.outFav,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return IconButton(
                          onPressed: () {
                            bloc.toggleFav(video);
                          },
                          icon: Icon(snapShot.data!.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border),
                          color: Colors.white,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
