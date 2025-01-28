import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SkincareController extends GetxController {
  var isLoading = false.obs; // Loader state
  // Observable skincare routine
  var skincareRoutine = {
    'cleanser': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'toner': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'moisturizer': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'sunscreen': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'lipBalm': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
  }.obs;

  // Pick and store image path for a specific step
  Future<void> pickImage(String step) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final now = DateTime.now();
        final formattedTime = DateFormat('hh:mm a').format(now);
        skincareRoutine[step]!['time'] = formattedTime;
        final localPath = await saveImageLocally(File(pickedFile.path), step);
        (skincareRoutine[step]!['imagePath'] as RxString).value = localPath;
        (skincareRoutine[step]!['completed'] as RxBool).value =
            true; // Mark as completed

        Get.snackbar('Success', '$step image selected and stored locally.');
      } else {
        Get.snackbar('Error', 'No image selected for $step.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Save the image locally to the app's documents directory
  Future<String> saveImageLocally(File file, String step) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$step.jpg';

    // Save the file to the local directory
    await file.copy(filePath);
    return filePath;
  }

  // Save skincare routine with local image paths to Firestore
  Future<void> logSkincareRoutineWithImages() async {
    final today = DateTime.now().toIso8601String().split('T').first;
    final user = FirebaseAuth.instance.currentUser;

    // Construct routine data with local paths
    Map<String, dynamic> routineData = {};
    skincareRoutine.forEach((step, data) {
      routineData[step] = {
        'time': data['time'],
        'imagePath': (data['imagePath'] as RxString).value,
      };
    });
    print(routineData);
    print(user!.uid);
    isLoading.value = true; // Start loading
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'skincareRoutine': {today: routineData},
      }, SetOptions(merge: true));

      Get.snackbar('Success', 'Routine logged successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload data: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
