import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
  final audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listener for player state changes
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Listener for duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listener for position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    // Load the audio file to get its duration - Changed by Abhay
    audioPlayer.setSource(AssetSource('audio/song.mp3')); // Changed by Abhay
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  // Function to format time for display
  String formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96",
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            // Slider to seek through the song
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(), // Set max based on song duration - Changed by Abhay
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final seekPosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(seekPosition);
                await audioPlayer.resume(); // Changed by Abhay
              },
            ),
            // Display current position and total duration
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),
            // Play/Pause button
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () async {
                  if (_isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(AssetSource('audio/song.mp3'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
