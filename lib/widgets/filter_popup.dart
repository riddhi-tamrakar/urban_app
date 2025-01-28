import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/training_controller.dart';
import '../utils/colors.dart';
import '../utils/dynamic_height.dart';

class FilterPopup extends StatefulWidget {
  final Function(String activeFilter, List<String> selectedLocations) onApplyFilters;

  const FilterPopup({required this.onApplyFilters, Key? key}) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  final TrainingController controller = Get.find();

  String activeFilter = "Location";
  List<String> selectedLocations = [];
  List<String> selectedTrainings = [];
  List<String> selectedTrainers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DynamicSize.allPadding(context, 0.04),
      height: DynamicSize.height(context, 0.5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DynamicSize.height(context, 0.02)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: DynamicSize.height(context, 0.02)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  filterOptions("Location", context),
                  filterOptions("Training Name", context),
                  filterOptions("Trainer", context),
                ],
              ),
              Expanded(
                child: Obx(() {
                  if (activeFilter == "Location") {
                    return buildFilterList(controller.locations, selectedLocations);
                  } else if (activeFilter == "Training Name") {
                    return buildFilterList(controller.trainingName, selectedTrainings);
                  } else if (activeFilter == "Trainer") {
                    return buildFilterList(controller.trainers, selectedTrainers);
                  } else {
                    return Container();
                  }
                }),
              ),
            ],
          ),
          SizedBox(height: DynamicSize.height(context, 0.01)),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (activeFilter == "Location" && selectedLocations.isNotEmpty) {
                    widget.onApplyFilters(activeFilter, selectedLocations);
                  } else if (activeFilter == "Training Name" && selectedTrainings.isNotEmpty) {
                    widget.onApplyFilters(activeFilter, selectedTrainings);
                  } else if (activeFilter == "Trainer" && selectedTrainers.isNotEmpty) {
                    widget.onApplyFilters(activeFilter, selectedTrainers);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Apply Filters",
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: AppColors.white,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  padding: DynamicSize.symmetricPadding(
                    context,
                    verticalPercentage: 0.015,
                    horizontalPercentage: 0.04,
                  ),
                  textStyle: TextStyle(fontSize: DynamicSize.height(context, 0.02)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterOptions(String option, BuildContext context) => Container(
        color: activeFilter == option ? AppColors.white : AppColors.lightGray,
        width: DynamicSize.width(context, 0.25),
        padding: DynamicSize.symmetricPadding(
          context,
          verticalPercentage: 0.02,
          horizontalPercentage: 0.03,
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              activeFilter = option;
            });
          },
          child: Text(
            option,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: activeFilter == option ? FontWeight.bold : FontWeight.w400,
                  color: AppColors.black,
                ),
          ),
        ),
      );

  Widget buildFilterList(List<String> items, List<String> selectedItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CheckboxListTile(
          title: Text(
            item,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          value: selectedItems.contains(item),
          activeColor: AppColors.primaryRed,
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
            });
          },
        );
      },
    );
  }
}
