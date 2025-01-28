import 'package:flutter/material.dart';

class StreaksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Skincare Streak',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'You have completed your routine for 5 days in a row!',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text('Claim Reward'),
          ),
        ],
      ),
    );
  }
}
