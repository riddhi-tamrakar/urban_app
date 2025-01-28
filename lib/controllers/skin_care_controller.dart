import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SkincareController extends GetxController {
  var isLoading = false.obs;
  var streakCount = 0.obs;
  var lastLoggedDate = ''.obs;
  var streakHistoryList = <String>[].obs; // List to track streak history

  var skincareRoutine = {
    'cleanser': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'toner': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'moisturizer': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'sunscreen': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
    'lipBalm': {'time': '', 'imagePath': ''.obs, 'completed': false.obs},
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStreakData();
  }

  // Fetch streak data from Firestore
  Future<void> fetchStreakData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data();
      streakCount.value = data?['streak'] ?? 0;
      lastLoggedDate.value = data?['lastLoggedDate'] ?? '';

      if (data?['streakHistory'] != null) {
        streakHistoryList.value = List<String>.from(data?['streakHistory']);
      }
    }
  }

  // Pick and store image path
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
        (skincareRoutine[step]!['completed'] as RxBool).value = true;

        Get.snackbar('Success', '$step image selected and stored locally.');
      } else {
        Get.snackbar('Error', 'No image selected for $step.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Save the image locally
  Future<String> saveImageLocally(File file, String step) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$step.jpg';

    await file.copy(filePath);
    return filePath;
  }

  // Save skincare routine with streak tracking
  Future<void> logSkincareRoutineWithImages() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Map<String, dynamic> routineData = {};
    skincareRoutine.forEach((step, data) {
      routineData[step] = {
        'time': data['time'],
        'imagePath': (data['imagePath'] as RxString).value,
      };
    });

    isLoading.value = true;

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await docRef.get();

      int newStreak = streakCount.value;
      List<String> streakHistory = [];

      if (doc.exists) {
        final lastDate = doc['lastLoggedDate'] ?? '';
        streakHistory = List<String>.from(doc['streakHistory'] ?? []);

        if (lastDate != today) {
          final yesterday = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 1)));

          if (lastDate == yesterday) {
            newStreak += 1;
          } else {
            newStreak = 1;
            streakHistory.clear(); // Reset streak history
          }
        }
      } else {
        newStreak = 1;
      }

      // Update streak history list
      if (!streakHistory.contains(today)) {
        streakHistory.add(today);
      }

      await docRef.set({
        'skincareRoutine': {today: routineData},
        'lastLoggedDate': today,
        'streak': newStreak,
        'streakHistory': streakHistory, // Save streak history
      }, SetOptions(merge: true));

      streakCount.value = newStreak;
      lastLoggedDate.value = today;
      streakHistoryList.value = streakHistory;

      Get.snackbar('Success', 'Routine logged successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
