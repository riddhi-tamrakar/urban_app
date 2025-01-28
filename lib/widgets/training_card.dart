import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/colors.dart';
import 'package:my_trainings_app/utils/vertical_dash_divider.dart';
import '../models/training_model.dart';
import '../utils/date_utils.dart';
import '../utils/dynamic_height.dart';
import '../views/training_detail.dart';

class TrainingCard extends StatelessWidget {
  final Training training;
  const TrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingDetailScreen(training: training),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: DynamicSize.height(context, 0.02)),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DynamicSize.height(context, 0.01)),
        ),
        elevation: 3,
        child: Padding(
          padding: DynamicSize.allPadding(context, 0.03),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatTrainingDate(training.startDate, training.endDate),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: DynamicSize.height(context, 0.02),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: DynamicSize.height(context, 0.01)),
                  Text(
                    '${training.startTime} - ${training.endTime}',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: DynamicSize.height(context, 0.015),
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: DynamicSize.height(context, 0.04)),
                  Text(
                    training.location,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: DynamicSize.height(context, 0.02),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              VerticalDashDivider(
                color: AppColors.iconGray,
                dashHeight: DynamicSize.height(context, 0.005),
                dashSpacing: DynamicSize.height(context, 0.002),
                height: DynamicSize.height(context, 0.1),
                width: DynamicSize.width(context, 0.002),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filling Fast!',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: DynamicSize.height(context, 0.015),
                            color: AppColors.primaryRed,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: DynamicSize.height(context, 0.005)),
                    Text(
                      training.title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: DynamicSize.height(context, 0.022),
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                    ),
                    SizedBox(height: DynamicSize.height(context, 0.01)),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(training.profilePicture),
                          radius: DynamicSize.height(context, 0.03),
                        ),
                        SizedBox(width: DynamicSize.width(context, 0.03)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              training.authorName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        DynamicSize.height(context, 0.018),
                                  ),
                            ),
                            Text(
                              training.company,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontSize:
                                        DynamicSize.height(context, 0.015),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: DynamicSize.height(context, 0.02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Enroll Now',
                            style: Theme.of(context).textTheme.button?.copyWith(
                                  fontSize: DynamicSize.height(context, 0.018),
                                  color: AppColors.white,
                                ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryRed,
                            padding: DynamicSize.symmetricPadding(
                              context,
                              verticalPercentage: 0.01,
                              horizontalPercentage: 0.04,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                DynamicSize.height(context, 0.01),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
