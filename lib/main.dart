import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:player/Player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: AudioPlayerWidget(),
    //   // Scaffold(
    //   //   appBar: AppBar(title: Text('Audio Player')),
    //   //   body: Center(
    //   //     child: Player(),
    //   //   ),
    //   // ),
    // );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AudioPlayerWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class AudioPlayerWidget extends StatefulWidget {
//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }
//
// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   late AudioPlayer _audioPlayer;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   void _playAudio() async {
//     int result = await _audioPlayer.play('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
//     if (result == 1) {
//       setState(() {
//         _isPlaying = true;
//       });
//     }
//   }
//
//   void _pauseAudio() async {
//     int result = await _audioPlayer.pause();
//     if (result == 1) {
//       setState(() {
//         _isPlaying = false;
//       });
//     }
//   }
//
//   void _stopAudio() async {
//     int result = await _audioPlayer.stop();
//     if (result == 1) {
//       setState(() {
//         _isPlaying = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         IconButton(
//           icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//           iconSize: 64.0,
//           onPressed: () {
//             if (_isPlaying) {
//               _pauseAudio();
//             } else {
//               _playAudio();
//             }
//           },
//         ),
//         SizedBox(height: 20),
//         IconButton(
//           icon: Icon(Icons.stop),
//           onPressed: _stopAudio,
//         ),
//       ],
//     );
//   }
// }
