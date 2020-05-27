import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

import 'package:radio_at_bus_stop/playing_status.dart';

class RadioStationPlay extends StatefulWidget {
  final String name;
  final String favicon;
  final String url;

  RadioStationPlay({this.name, this.favicon, this.url});

  @override
  _RadioStationPlayState createState() => _RadioStationPlayState();
}

class _RadioStationPlayState extends State<RadioStationPlay> {
  bool isPlay;
  PlayingStatus playingStatus = PlayingStatus();

  @override
  void initState() {
    super.initState();
    startRadio();
    isPlay = playingStatus.isPlaying;
    // playingStatus();
  }

  Future<void> startRadio() async {
    await FlutterRadio.audioStart();
    print('Start Radio OK');
  }

  @override
  Widget build(BuildContext context) {
    print("Status isPlay :" + isPlay.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 300,
              child: CachedNetworkImage(
                imageUrl: widget.favicon,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(
                  Icons.error,
                  size: 80,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                FlutterRadio.playOrPause(url: widget.url);
                setState(() {
                  isPlay
                      ? playingStatus.isPlaying = false
                      : playingStatus.isPlaying = true;

                  isPlay = playingStatus.isPlaying;
                });
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Icon(
                isPlay ? Icons.pause : Icons.play_arrow,
                size: 30,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            )
          ],
        ),
      ),
    );
  }

  // Future playingStatus() async {
  //   bool isP = await FlutterRadio.isPlaying();
  //   print("Status isP :" + isP.toString());
  //   setState(() {
  //     isPlay = isP;
  //   });
  // }
}
