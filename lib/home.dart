import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mp3_player/player/PlayingControls.dart';
import 'package:mp3_player/player/PositionSeekWidget.dart';
import 'package:mp3_player/player/SongsSelector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final audios = <Audio>[
    Audio(
      "assets/audios/alal.mp3",
      metas: Metas(
        id: "Alal Musthofa",
        title: "Alal Musthofa",
        artist: "Nadia Hawasy",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/allahyamaulana.mp3",
      metas: Metas(
        id: "allah ya maulana",
        title: "allah ya maulana",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/birosulillah.mp3",
      metas: Metas(
        id: "birosulillah",
        title: "birosulillah",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/busyrolana.mp3",
      metas: Metas(
        id: "busyrolana",
        title: "busyrolana",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/dauni.mp3",
      metas: Metas(
        id: "dauni",
        title: "dauni",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/farhatun.mp3",
      metas: Metas(
        id: "farhatun",
        title: "farhatun",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/hasbunalloh.mp3",
      metas: Metas(
        id: "hasbunalloh",
        title: "hasbunalloh",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/malik khiliq.mp3",
      metas: Metas(
        id: "malik khiliq",
        title: "malik khiliq",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/roqot aina.mp3",
      metas: Metas(
        id: "roqot aina",
        title: "roqot aina",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/shollu ala khoiril anam.mp3",
      metas: Metas(
        id: "shollu ala khoiril anam",
        title: "shollu ala khoiril anam",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
    Audio(
      "assets/audios/ya nabi salam.mp3",
      metas: Metas(
        id: "ya nabi salam",
        title: "ya nabi salam",
        artist: "Nadia Hawasy ",
        album: "Arabic",
        image: MetasImage.asset("assets/images/atik.png"),
      ),
    ),
  ];

  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId("music");
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print("playlistAudioFinished : $data");
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print("audioSessionId : $sessionId");
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));

    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print("dispose");
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  _assetsAudioPlayer.builderCurrent(
                    builder: (BuildContext context, Playing playing) {
                      if (playing != null) {
                        final myAudio =
                            find(this.audios, playing.audio.assetAudioPath);

                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                depth: 8,
                                surfaceIntensity: 1,
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.circle(),
                              ),
                              child:
                                  myAudio.metas.image.type == ImageType.network
                                      ? Image.network(
                                          myAudio.metas.image.path,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.asset(
                                          myAudio.metas.image.path,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.contain,
                                        ),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              _assetsAudioPlayer.builderCurrent(builder: (context, playing) {
                if (playing == null) {
                  return SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      _assetsAudioPlayer.builderLoopMode(
                        builder: (context, loopMode) {
                          return PlayerBuilder.isPlaying(
                              player: _assetsAudioPlayer,
                              builder: (context, isPlaying) {
                                return PlayingControls(
                                  loopMode: loopMode,
                                  isPlaying: isPlaying,
                                  isPlaylist: true,
                                  onStop: () {
                                    _assetsAudioPlayer.stop();
                                  },
                                  toggleLoop: () {
                                    _assetsAudioPlayer.toggleLoop();
                                  },
                                  onPlay: () {
                                    _assetsAudioPlayer.playOrPause();
                                  },
                                  onNext: () {
                                    //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                    _assetsAudioPlayer.next(keepLoopMode: true
                                        /*keepLoopMode: false*/);
                                  },
                                  onPrevious: () {
                                    _assetsAudioPlayer.previous(
                                        /*keepLoopMode: false*/);
                                  },
                                );
                              });
                        },
                      ),
                      _assetsAudioPlayer.builderRealtimePlayingInfos(
                          builder: (context, infos) {
                        if (infos == null) {
                          return SizedBox();
                        }
                        return Column(
                          children: [
                            PositionSeekWidget(
                              currentPosition: infos.currentPosition,
                              duration: infos.duration,
                              seekTo: (to) {
                                _assetsAudioPlayer.seek(to);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeumorphicButton(
                                    child: Text("-10"),
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: -10));
                                    },
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  NeumorphicButton(
                                    child: Text("+10"),
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: 10));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 20,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: _assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing playing) {
                    return SongsSelector(
                      audios: this.audios,
                      onPlaylistSelected: (myAudios) {
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );
                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: NotificationSettings(),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
