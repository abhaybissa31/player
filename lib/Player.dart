import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Audio Player')),
        body: Center(
          child: AudioPlayerWidget(),
        ),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final audioPlayer=AudioPlayer();
  bool _isPlaying = false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state){
      setState(() {
        _isPlaying=state==PlayerState.playing;
      });
      audioPlayer.onDurationChanged.listen((newDuration){
        setState(() {
          duration=newDuration;
          log(newDuration as String);
        });
      });
      // audioPlayer.onDurationChanged.listen((Duration d) {
      //   print('max duration: ${d.inSeconds}');
      // });
      audioPlayer.onPositionChanged.listen((newPosition){
        setState(() {
          position=newPosition;
        });
      });
    });
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  // void _playAudio() async {
  //   int result = await audioPlayer.play('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
  //   if (result == 1) {
  //     setState(() {
  //       _isPlaying = true;
  //     });
  //   }
  // }
  //
  // void _pauseAudio() async {
  //   int result = await _audioPlayer.pause();
  //   if (result == 1) {
  //     setState(() {
  //       _isPlaying = false;
  //     });
  //   }
  // }
  //
  // void _stopAudio() async {
  //   int result = await _audioPlayer.stop();
  //   if (result == 1) {
  //     setState(() {
  //       _isPlaying = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20),
                child: Image.network("https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96",width: double.infinity,height: 350,fit: BoxFit.cover,),
              ),
              // Slider(
              //     min:0,
              //     max: duration.inSeconds.toDouble(),
              //     value: position.inSeconds.toDouble(),
              //     onChanged: (value) async{}
              //   // onChanged: (value)async{
              //   //   final position=Duration(seconds: value.toInt());
              //   //   audioPlayer.seek(position);
              //   //   audioPlayer.resume();
              //   // },
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position.inSeconds)),
                    Text(formatTime(duration.inSeconds)),
                  ],
                ),
              ),
              CircleAvatar(radius: 35,
              child: IconButton(
                icon:Icon(_isPlaying?Icons.pause:Icons.play_arrow),
                onPressed: () async{
                  if(_isPlaying){
                    await audioPlayer.pause();
                  }
                  else{
                    await audioPlayer.play(AssetSource('audio/song.mp3'));
                  }
                },
              ),)
              // <Widget>[
              // IconButton(
              //   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              //   iconSize: 64.0,
              //   onPressed: () {
              //     if (_isPlaying) {
              //       _pauseAudio();
              //     } else {
              //       _playAudio();
              //     }
              //   },
              // ),
              // SizedBox(height: 20),
              // IconButton(
              //   icon: Icon(Icons.stop),
              //   onPressed: _stopAudio,
              // ),
            ],
          ),
        ),
    );

  }
}
