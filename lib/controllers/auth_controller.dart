import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/api_service.dart';
import 'package:pas1_mobile_11pplg1_23/pages/home_page.dart';
import 'package:pas1_mobile_11pplg1_23/pages/login/login_page.dart';
import 'package:pas1_mobile_11pplg1_23/utils/snackbar_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static const String KEY_IS_LOGGED_IN = 'isLoggedIn';
  static const String KEY_USERNAME = 'username';
  static const String KEY_FULL_NAME = 'fullName';
  static const String KEY_EMAIL = 'email';

  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  var isLoggedIn = false.obs;

  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    initializeController();
  }

  Future<void> initializeController() async {
    _prefs = await SharedPreferences.getInstance();
    await loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      final token = ApiService.sessionToken;
      if (token == null) {
        isLoggedIn.value = false;
        return;
      }
      isLoggedIn.value = _prefs.getBool(KEY_IS_LOGGED_IN) ?? false;

      if (isLoggedIn.value) {
        username.value = _prefs.getString(KEY_USERNAME) ?? '';
        fullName.value = _prefs.getString(KEY_FULL_NAME) ?? '';
        email.value = _prefs.getString(KEY_EMAIL) ?? '';
        if (username.value.isEmpty ||
            fullName.value.isEmpty ||
            email.value.isEmpty) {
          isLoggedIn.value = false;
          await clearAllFields();
        }
      } else {
        await clearAllFields();
      }
    } catch (e) {
      print("Error loading user data: $e");
      isLoggedIn.value = false;
    }
  }

  Future<void> saveUserData() async {
    try {
      await _prefs.setBool(KEY_IS_LOGGED_IN, true);
      await _prefs.setString(KEY_USERNAME, username.value);
      await _prefs.setString(KEY_FULL_NAME, fullName.value);
      await _prefs.setString(KEY_EMAIL, email.value);

      if (ApiService.sessionToken != null) {
        await _prefs.setString('token', ApiService.sessionToken!);
      }

      isLoggedIn.value = true;
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  void updateUsername(String value) => username.value = value.trim();
  void updatePassword(String value) => password.value = value.trim();
  void updateFullName(String value) => fullName.value = value.trim();
  void updateEmail(String value) => email.value = value.trim();

  void clearFields() {
    password.value = '';
  }

  Future<void> clearAllFields() async {
    try {
      await _prefs.clear();
      username.value = '';
      password.value = '';
      fullName.value = '';
      email.value = '';
      isLoggedIn.value = false;
    } catch (e) {
      print("Error clearing data: $e");
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> login() async {
    try {
      if (username.isEmpty || password.isEmpty) {
        SnackbarHelper.showError('Username and password are required!');
        return;
      }

      isLoading.value = true;

      final response = await ApiService.login(
        username.value,
        password.value,
      );

      if (response['status'] == true) {
        if (response['data'] != null) {
          final data = response['data'];
          fullName.value = data['full_name'] ?? '';
          email.value = data['email'] ?? '';
        }

        await saveUserData();
        isLoggedIn.value = ApiService.sessionToken != null;
        SnackbarHelper.showSuccess('Login successful!');
        clearFields();
        Get.offAll(
          () => HomePage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        SnackbarHelper.showError(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      SnackbarHelper.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    ApiService.setSessionToken(null);
    await clearAllFields();
    isLoggedIn.value = false;
    Get.offAll(
      () => const LoginPage(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  void handleSessionExpiry() {
    isLoggedIn.value = false;
    Get.offAll(
      () => const LoginPage(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
    SnackbarHelper.showError('Session expired. Please login again.');
  }

  Future<void> register() async {
    try {
      if (!isValidEmail(email.value)) {
        SnackbarHelper.showError('Please enter a valid email address');
        return;
      }

      isLoading.value = true;

      final response = await ApiService.register(
        username: username.value,
        password: password.value,
        fullName: fullName.value,
        email: email.value,
      );

      if (response['status'] == true) {
        SnackbarHelper.showSuccess('Registration success');
        clearAllFields();
        Get.off(
          () => const LoginPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        SnackbarHelper.showError(response['message'] ?? 'Registration failed');
      }
    } catch (e) {
      SnackbarHelper.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
