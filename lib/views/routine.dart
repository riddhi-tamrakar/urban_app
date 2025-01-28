import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/skin_care_controller.dart';

class RoutineScreen extends StatelessWidget {
  final SkincareController controller = Get.put(SkincareController());

  // Map to hold product names for each step
  final Map<String, String> productNames = {
    'cleanser': 'Cetaphil Gentle Skin Cleanser',
    'toner': 'Thayers Witch Hazel Toner',
    'moisturizer': 'Kiehl\'s Ultra Facial Cream',
    'sunscreen': 'Supergoop Unseen Sunscreen SPF 40',
    'lipBalm': 'Glossier Birthday Balm Dotcom',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daily Skincare Routine'),elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: controller.skincareRoutine.keys.map((step) {
            return Obx(() {
              final isCompleted =
                  (controller.skincareRoutine[step]!['completed'] as RxBool)
                      .value;
              final imagePath =
                  (controller.skincareRoutine[step]!['imagePath'] as RxString)
                      .value;
              final time =
                  (controller.skincareRoutine[step]!['time'] as String);

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isCompleted,
                        onChanged:
                            null, // Checkbox is auto-checked when an image is uploaded
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).cardColor,

                        fillColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .primaryColor; // Fill color when checked
                          }
                          return Colors.grey
                              .shade300; // Default fill color when unchecked
                        }),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.capitalizeFirst!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(height: 2),
                            Text(
                              productNames[step] ?? '',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            time,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 5),
                          imagePath.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(imagePath),
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => controller.pickImage(step),
                                  child: Icon(Icons.add_a_photo,
                                      size: 30, color: Colors.grey),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: controller.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white) // Show loader
          : const Icon(Icons.check),
      onPressed: controller.isLoading.value
          ? null // Disable button while loading
          : controller.logSkincareRoutineWithImages,
    )),
    );
  }
}
