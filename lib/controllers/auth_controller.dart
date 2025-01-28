import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs; // Observable variable to track loading state
  var errorMessage = ''.obs; // Observable variable for error messages
  var isLoggedIn = false.obs;
  var user = Rx<User?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if the user is already logged in
  void checkLoginStatus() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      user.value = currentUser;
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  // Login function
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading(true); // Show loading indicator
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading(false);
      // Hide loading indicator
      user.value = userCredential.user;
      isLoggedIn.value = true;
      Get.offAllNamed(
          '/bottomNavigation'); // Navigate to Home screen on successful login
    } catch (e) {
      print(e);
      isLoading(false); // Hide loading indicator
      errorMessage(e.toString()); // Set error message
    }
  }

  // Logout function
  Future<void> logoutUser() async {
    await _auth.signOut();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
