import 'package:audioplayers/audioplayers.dart';

void buttonSound(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/water_drop.mp3'));
}

void buttonSoundError(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/errorsound.mp3'));
}

void buttonSoundRestart(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/restart_sound.mp3'));
}

void buttonTimesUp(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/timesup.mp3'));
}

void buttonStart(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/start.mp3'));
}

void buttonWin(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/win.mp3'));
}

void buttonSave(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/save_data.mp3'));
}

void buttonStop(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/stop.mp3'));
}


void buttonPlay(){
   final player = AudioPlayer();
         player.play(AssetSource('sounds/play.mp3'));
}