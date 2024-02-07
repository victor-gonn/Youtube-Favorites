    import 'package:bloc_pattern/bloc_pattern.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter/services.dart';
    import 'package:youtube_favoritos/models/video-model.dart';
    import 'package:youtube_player_flutter/youtube_player_flutter.dart';
     
    import 'package:youtube_favoritos/bloc/FavoriteBloc.dart';
    
     
    class VideoPlayer extends StatelessWidget {
      final Video video;
     
      const VideoPlayer({
        Key? key,
        required this.video,
      }) : super(key: key);
     
      @override
      Widget build(BuildContext context) {
        final bloc = BlocProvider.getBloc<FavoritesBloc>();
        final youtubeController = YoutubePlayerController(
          initialVideoId: video.id,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
            loop: false,
          ),
        );
     
        return YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen.
            // This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.white70,
            ),
            aspectRatio: 16.0 / 9.0,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  youtubeController.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          builder: (context, player) => Scaffold(
            appBar: AppBar(
              title: SizedBox(
                height: 25,
                child: Image.asset("images/image.png"),
              ),
              elevation: 0,
              backgroundColor: Colors.black87,
              actions: [
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data!.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.white,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          bloc.toggleFav(video);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            body: ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Título:",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        video.title,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                      const Divider(color: Colors.black87,height: 20),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 26,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            video.channel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }