import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/dynamic_height.dart';
import '../controllers/training_controller.dart';
import '../utils/date_utils.dart';
import '../utils/colors.dart';

class TrainingCarousel extends StatelessWidget {
  final TrainingController controller;

  TrainingCarousel({required this.controller});
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: controller.trainings.map((training) {
            return Builder(
              builder: (BuildContext context) {
                return Card(
                  
                  margin: DynamicSize.symmetricPadding(
                    context,
                    verticalPercentage: 0,
                    horizontalPercentage: 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DynamicSize.height(context, 0.015),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          DynamicSize.height(context, 0.015),
                        ),
                        child: Image.asset(
                          training.trainingPoster,
                          fit: BoxFit.fill,
                          width: DynamicSize.width(context, 1),
                        ),
                      ),
                      Positioned(
                        bottom: DynamicSize.height(context, 0.015),
                        left: DynamicSize.width(context, 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              training.title,
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: DynamicSize.height(context, 0.02),
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                            ),
                            Text(
                              '${training.location} - ${formateTrainingDate(training.startDate, training.endDate)}',
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: DynamicSize.height(context, 0.015),
                                    color: AppColors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: DynamicSize.height(context, 0.25),
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
          ),
        ),
        Positioned(
          left: -DynamicSize.width(context, 0.01),
          bottom: DynamicSize.height(context, 0.1),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(
                DynamicSize.height(context, 0.01),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              color: AppColors.white,
              onPressed: () {
                _carouselController.previousPage();
              },
            ),
          ),
        ),
        Positioned(
          right: -DynamicSize.width(context, 0.01),
          bottom: DynamicSize.height(context, 0.1),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(
                DynamicSize.height(context, 0.01),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 20),
              color: AppColors.white,
              onPressed: () {
                _carouselController.nextPage();
              },
            ),
          ),
        ),
      ],
    );
  }
}
