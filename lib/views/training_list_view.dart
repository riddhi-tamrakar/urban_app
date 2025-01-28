import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/training_controller.dart';
import '../utils/dynamic_height.dart';
import '../widgets/filter_popup.dart';
import '../widgets/training_card.dart';
import '../widgets/training_carousel.dart';
import '../utils/colors.dart';

class TrainingListView extends StatelessWidget {
  final TrainingController controller = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Trainings',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: DynamicSize.width(context, 1),
              child: Padding(
                padding: DynamicSize.allPadding(context, 0.04),
                child: Text(
                  'Highlights',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: DynamicSize.height(context, 0.1),
                  color: Theme.of(context).primaryColor,
                ),
                TrainingCarousel(
                  controller: controller,
                ),
              ],
            ),
            Padding(
              padding: DynamicSize.symmetricPadding(
                context,
                verticalPercentage: 0.02,
                horizontalPercentage: 0.04,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return FilterPopup(
                        onApplyFilters: (activeFilter, filters) {
                          controller.filterTrainings(
                            activeFilter: activeFilter,
                            selectedLocations:
                                activeFilter == "Location" ? filters : [],
                            selectedTrainings:
                                activeFilter == "Training Name" ? filters : [],
                            selectedTrainers:
                                activeFilter == "Trainer" ? filters : [],
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.filter_list, color: AppColors.iconGray),
                label: const Text(
                  'Filter',
                  style: TextStyle(color: AppColors.iconGray),
                ),
              ),
            ),
            Container(
              color: AppColors.lightGray,
              height: DynamicSize.height(context, 0.5),
              child: Padding(
                padding: DynamicSize.symmetricPadding(
                  context,
                  verticalPercentage: 0,
                  horizontalPercentage: 0.04,
                ),
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.trainings.length,
                    itemBuilder: (context, index) {
                      return TrainingCard(
                        training: controller.trainings[index],
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
