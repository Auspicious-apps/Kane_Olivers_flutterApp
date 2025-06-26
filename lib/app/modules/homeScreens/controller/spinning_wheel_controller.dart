import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class SpinningWheelController extends BaseController {
  final StreamController<int> _dividerController = StreamController<int>.broadcast();
  Stream<int> get dividerStream => _dividerController.stream;
  RxInt freeSpin=10.obs;

  // AudioPlayer instance for playing spin audio
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    // Optional: Preload audio to reduce latency
    _audioPlayer.setSource(AssetSource('audio/spinSound.wav'));
  }

  @override
  void onClose() {
    _dividerController.close();
    _audioPlayer.dispose(); // Clean up AudioPlayer
    super.onClose();
  }

  double generateRandomAngle() => Random().nextDouble() * pi * 2;

  void addDivider(int divider) {
    _dividerController.add(divider);
  }

  Future<void> stopSpinAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  // Play spin audio
  Future<void> playSpinAudio() async {
    try {
      await _audioPlayer.play(AssetSource('audio/spinSound.wav'));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}