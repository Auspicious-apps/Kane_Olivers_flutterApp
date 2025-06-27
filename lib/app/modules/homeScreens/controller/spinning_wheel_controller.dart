import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../../../core/base/base_controller.dart';
import '../../../export.dart';
import '../views/spinning_wheel.dart';

class SpinningWheelController extends BaseController {
  final StreamController<int> _dividerController = StreamController<int>.broadcast();
  final StreamController<int> selectedController = StreamController<int>.broadcast();
  Stream<int> get dividerStream => _dividerController.stream;
  RxInt freeSpin = 20.obs;
  final isSpinning = false.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.setSource(AssetSource('audio/spinSound.wav'));
    selectedController.add(0); // Set initial wheel position to "Best of Luck"
    addDivider(RouletteScore.getIndex('Best of Luck')); // Set initial result
  }

  @override
  void onClose() {
    _dividerController.close();
    selectedController.close();
    _audioPlayer.dispose();
    super.onClose();
  }

  double generateRandomAngle() => Random().nextDouble() * pi * 2;

  void addDivider(int divider) {
    if (!_dividerController.isClosed) {
      _dividerController.add(divider);
    }
  }

  Future<void> stopSpinAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  Future<void> playSpinAudio() async {
    try {
      await _audioPlayer.play(AssetSource('audio/spinSound.wav'));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void spinToBestOfLuck() async {
    if (freeSpin.value <= 0) {
      Get.dialog(
        AlertDialog(
          title: const Text('No Free Spins'),
          content: const Text('You have no free spins left!'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      return;
    }

    isSpinning.value = true;
    await playSpinAudio();
    freeSpin.value--;

    // Weighted random selection:
    // 57.7% for index 0 ("Best of Luck")
    // 3.8% for index 3 ("2000 Points")
    // 3.8% for index 4 ("400 Points")
    // 34.7% for index 5 ("100 Points")
    final random = Random().nextDouble();
    int selectedIndex;
    if (random < 0.577) {
      selectedIndex = 0; // 57.7% chance for "Best of Luck"
    } else if (random < 0.615) {
      selectedIndex = 3; // 3.8% chance for "2000 Points"
    } else if (random < 0.653) {
      selectedIndex = 4; // 3.8% chance for "400 Points"
    } else {
      selectedIndex = 5; // 34.7% chance for "100 Points"
    }
    selectedController.add(selectedIndex);

    // Map selected index to label
    String resultLabel = _getLabelForIndex(selectedIndex);
    showWinningPopup(resultLabel);
  }

  String _getLabelForIndex(int index) {
    // Map FortuneWheel index to label
    switch (index) {
      case 0:
        return 'Best of Luck';
      case 3:
        return '2000 Points';
      case 4:
        return '400 Points';
      case 5:
        return '100 Points';
      default:
        return 'Best of Luck';
    }
  }

  void showWinningPopup(String result) {
    Future.delayed(const Duration(seconds: 4), () {
      if (Get.isDialogOpen == false) {
        Get.dialog(
          AlertDialog(
            title: const Text('Yehhh !!!!'),
            content: Text('You Got $result'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      }
    });
  }
}