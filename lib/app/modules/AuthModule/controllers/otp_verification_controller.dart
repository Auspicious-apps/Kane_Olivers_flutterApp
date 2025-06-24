
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:otp_autofill/otp_autofill.dart';



import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '../models/responsemodels/userResponseModel.dart';


class OtpVerificationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isloading=false.obs;
  late OTPTextEditController otpController;
  late OTPInteractor _otpInteractor;
  UserResponseModel? userResponseModel;
  late FocusNode pinFocusNode;
  var timerSeconds = 60.obs;
  bool isEdit = false;
  bool isForEmail = false;

  RxBool forceErrorState = false.obs;

  String? phoneNumber;

  String? email;
  String? from;



  Timer? _timer;
  RxInt leftDuration = 30.obs;
  RxBool isTimerStarted = true.obs;
  RxBool isLoading = false.obs;
  RxBool isresend = false.obs;
  RxBool isResendingOtp = false.obs;
  final LocalStorage _localStorage = LocalStorage();
  @override
  void onInit() {
    _getArgs();
    _initOtpReader();
    startOtpTimer();
    _initControllers();
    super.onInit();
  }

  void _getArgs() {
    if(Get.arguments!=null){
      email=Get.arguments["email"];
      print("email>>>>>>>>>>>>$email");
    }

  }

  ResendOtpApi(var data) {
    try {
      repository.ResendOtpApi(dataBody: data).then((value) async {
        if (value != null) {
          isresend.value=false;
          isresend.refresh();
          userResponseModel = value;
          startOtpTimer();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isresend.value=false;
        isresend.refresh();
        Get.snackbar('Error', '${er}');
      });
    } catch (er) {
      isresend.value=false;
      isresend.refresh();
      print("$er");
    }
  }

  handleSubmit(var data) {
    isloading.value=true;
    isloading.refresh();
    try{
      repository.SignupOtpVerifyApi(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          if (userResponseModel?.data?.token != null) {
            _localStorage.saveAuthToken(userResponseModel?.data?.token);
          }
          isloading.value=false;
          isloading.refresh();
          Get.offAllNamed(AppRoutes.dashboard);
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value=false;
        isloading.refresh();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isloading.value=false;
      isloading.refresh();
      print("$er");
    }
  }


  handleForgetSubmit(var data) {
    isloading.value=true;
    isloading.refresh();
    try{
      repository.ForgetOtpVerifyApi(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value=false;
          isloading.refresh();
          Get.offNamed(AppRoutes.confirmPasswordRoute,arguments: {"otp":otpController.text});
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value=false;
        isloading.refresh();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isloading.value=false;
      isloading.refresh();
      print("$er");
    }
  }

  void startOtpTimer() {

    timerSeconds.value = 60; // Reset timer

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();

      }
    });
  }


  @override
  void onReady() {

    super.onReady();
  }

  void _initOtpReader() async {
    _initInteractor();
    _initOtpController();
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();
    // final appSignature = await _otpInteractor.getAppSignature();
  }

  void _initOtpController() {
    otpController = OTPTextEditController(
      codeLength: 6,
      // onCodeReceive: (code) => _autoValidate(),
      autoStop: true,
      otpInteractor: _otpInteractor,
    );

    // ..startListenUserConsent(
    //   (code) {
    //     final exp = RegExp(r'(\d{4})');
    //     return exp.stringMatch(code ?? '') ?? '';
    //   },
    // );
  }

















  void resendOtp() {
    otpController.clear();



  }





  @override
  void onClose() {
    otpController.dispose();
    pinFocusNode.dispose();


    super.onClose();
  }

  void _initControllers() {
    otpController.clear();
    pinFocusNode = FocusNode();
  }

  void _disposeControllers() {
    otpController.dispose();
    pinFocusNode.dispose();

  }
}
