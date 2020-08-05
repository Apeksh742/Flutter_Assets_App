import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';


var url = "https://www.desktopbackground.org/download/o/2010/06/06/28755_oem-nissan-skyline-gtr-fast-and-furious-6-ff6-paul-walker-wall_1000x1441_h.jpg";
int result;
int state =2 ;

AudioPlayer audioPlayer = AudioPlayer();
   play() async {
   result = await audioPlayer.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    if (result == 1) {
      state = 1;
    }

  }

   stop() async {
     result = await audioPlayer.stop();
     state=0;
   }


class VideoPlayerScreen extends StatefulWidget {


  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/video.mp4');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets App'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Padding(
        padding: const EdgeInsets.only(top:20),
        child: Column(
          children: <Widget>[
               FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
             SizedBox(height:15),
             Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 RaisedButton( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: () {
            // Wrap the play or pause in a call to `setState`. This ensures the
            // correct icon is shown

            setState(() {
                  // If the video is playing, pause it.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller.play();
                  }
            });
          },
          // Display the correct icon depending on the state of the player.
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ), 

        RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: (){
                   _controller.seekTo(Duration(seconds: 0));
                   _controller.pause();
        },
        child: Icon(Icons.stop),
        ),
               ],
             ),
         SizedBox(height:15),

        Container( height: 200,
             decoration: BoxDecoration( image: DecorationImage(image: NetworkImage(url),fit: BoxFit.contain ))
        ),
         SizedBox(height:10),


        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           FloatingActionButton(onPressed: (){

            setState(() {
              if (state==1) {
                audioPlayer.pause();
                state = 0;            
              }
              else if (state == 2) {
                play();
              }
              else {
                audioPlayer.resume();
                state = 1;
              }
              
            });
            },
            child: state == 1 ? Icon(Icons.pause) : Icon(Icons.play_arrow)
            ),

          SizedBox(width: 30,),

          FloatingActionButton(onPressed: stop,
          child: Icon(Icons.stop)
          ),

          ],
        )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
