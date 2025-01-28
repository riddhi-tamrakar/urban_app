import 'package:get/get.dart';
import '../models/training_model.dart';

class TrainingController extends GetxController {
  var trainings =
      <Training>[].obs; // Observable list for the filtered trainings
  var allTrainings = <Training>[]; // Original list of all trainings
  var locations = <String>[].obs; // Observable list of unique locations
  var trainingName = <String>[].obs; // Observable list of unique locations
  var trainers = <String>[].obs; // Observable list of unique locations

  @override
  void onInit() {
    super.onInit();
    // Add initial data
    trainings.addAll([
      Training(
        title: "Flutter Basics",
        description:
            "Learn the fundamentals of Flutter for building beautiful apps.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        location: "Online",
        startDate: DateTime(2025, 1, 15),
        endDate: DateTime(2025, 1, 16),
        startTime: "10:00 am",
        endTime: "2:00 pm",
        authorName: "John Doe",
        trainingPoster: "assets/images/training1.jpg",
        profilePicture:
            "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250",
        company: "Tech Academy",
      ),
      Training(
        title: "Advanced Dart",
        description: "Master Dart programming for robust app development.",
        location: "New Jersy",
        startDate: DateTime(2025, 2, 10),
        endDate: DateTime(2025, 2, 12),
        startTime: "9:00 am",
        endTime: "1:00 pm",
        authorName: "Jane Smith",
        profilePicture:
            "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250",
        company: "Code Innovators",
        trainingPoster: "assets/images/training2.jpg",
      ),
      Training(
        title: "GetX State Management",
        description: "Simplify your Flutter apps with GetX state management.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        location: "San Francisco",
        startDate: DateTime(2025, 3, 5),
        endDate: DateTime(2025, 3, 6),
        startTime: "11:00 am",
        endTime: "4:00 pm",
        authorName: "Emily Brown",
        profilePicture:
            "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250",
        company: "Dev Bootcamp",
        trainingPoster: "assets/images/training1.jpg",
      ),
    ]);
    // Copy all trainings into allTrainings for filtering purposes
    allTrainings.addAll(trainings);
    // Extract unique locations from the training list
    locations.addAll(allTrainings.map((t) => t.location).toSet().toList());
    trainingName.addAll(allTrainings.map((t) => t.title).toSet().toList());
    trainers.addAll(allTrainings.map((t) => t.authorName).toSet().toList());
  }

  void filterTrainings({
    required String activeFilter,
    required List<String> selectedLocations,
    required List<String> selectedTrainings,
    required List<String> selectedTrainers,
  }) {
    // Reset to all trainings if no filters are applied
    if (selectedLocations.isEmpty &&
        selectedTrainings.isEmpty &&
        selectedTrainers.isEmpty) {
      trainings.assignAll(allTrainings);
      return;
    }
    // Filter based on the active filter
    var filtered = allTrainings.where((training) {
      if (activeFilter == "Location" && selectedLocations.isNotEmpty) {
        return selectedLocations.contains(training.location);
      } else if (activeFilter == "Training Name" &&
          selectedTrainings.isNotEmpty) {
        return selectedTrainings.contains(training.title);
      } else if (activeFilter == "Trainer" && selectedTrainers.isNotEmpty) {
        return selectedTrainers.contains(training.authorName);
      }
      return true; // Default case to include training
    }).toList();

    trainings.assignAll(filtered);
  }
}
