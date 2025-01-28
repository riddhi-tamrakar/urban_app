import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/utils/colors.dart';
import '../controllers/skin_care_controller.dart';
import '../utils/dynamic_height.dart';

class StreaksScreen extends StatelessWidget {
  final SkincareController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streaks'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Goal: 3 Streak Days",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.black)),
            SizedBox(height: DynamicSize.width(context, 0.01)),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DynamicSize.width(context, 0.01),
                    vertical: DynamicSize.width(context, 0.03)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Streak Days",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Theme.of(context).primaryColor)),
                      Obx(
                        () => Text("${controller.streakCount.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: AppColors.black)),
                      )
                    ]),
              ),
            ),
            Obx(() => Text("Current Streak: ${controller.streakCount.value}",
                style: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            SizedBox(
              height:  DynamicSize.width(context, 0.2),
              child: Obx(() {
                return LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.streakHistoryList
                            .asMap()
                            .entries
                            .map((entry) {
                          return FlSpot(
                              entry.key.toDouble(), entry.key.toDouble() + 1);
                        }).toList(),
                        isCurved: true,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
