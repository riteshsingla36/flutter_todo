import 'package:todo_app/app/app.locator.dart';
import 'package:todo_app/app/app.router.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends FutureViewModel<bool> {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _sharedPreferences = locator<SharedPreferencesService>();

  bool isLoading = false;

  @override
  Future<bool> futureToRun() async {
    return true;
  }

  @override
  void onData(bool? data) async {
    if(_sharedPreferences.token != null) {
      // await _navigationService.navigateTo(Routes.startUpView);
    }
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await _authService.signupWithEmailAndPassword(email, password);
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    catch(err) {
      _snackbarService.showSnackbar(message: err.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signupWithGoogle() async {
    isLoading = true;
    notifyListeners();
    try {
      UserCredential? user = await _authService.googleSignIn();
      _sharedPreferences.token = user?.credential?.token.toString();
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    catch(err) {
      _snackbarService.showSnackbar(message: err.toString());
    }
    isLoading = false;
    notifyListeners();
  }
  void navigateToLogin () {
    _navigationService.navigateTo(Routes.loginView);
  }

  void moveToPhoneAuth () {
    _navigationService.navigateTo(Routes.phoneAuthView);
  }
}