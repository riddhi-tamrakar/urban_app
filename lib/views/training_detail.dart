import 'package:flutter/material.dart';
import '../models/training_model.dart';
import '../utils/colors.dart';
import '../utils/dynamic_height.dart';

class TrainingDetailScreen extends StatelessWidget {
  final Training training;

  const TrainingDetailScreen({required this.training, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Training Details',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Training Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(DynamicSize.height(context, 0.03)),
              ),
              child: Image.asset(
                training.trainingPoster,
                fit: BoxFit.cover,
                width: DynamicSize.width(context, 1),
                height: DynamicSize.height(context, 0.3),
              ),
            ),
            SizedBox(height: DynamicSize.height(context, 0.03)),

            // Training Name
            Padding(
              padding: DynamicSize.symmetricPadding(
                context,
                verticalPercentage: 0,
                horizontalPercentage: 0.05,
              ),
              child: Text(
                training.title,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
              ),
            ),
            SizedBox(height: DynamicSize.height(context, 0.02)),

            // Training Description
            Padding(
              padding: DynamicSize.symmetricPadding(
                context,
                verticalPercentage: 0,
                horizontalPercentage: 0.05,
              ),
              child: Text(
                training.description,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: DynamicSize.height(context, 0.02),
                      color: AppColors.darkGray,
                    ),
              ),
            ),
            SizedBox(height: DynamicSize.height(context, 0.03)),
          ],
        ),
      ),
    );
  }
}
