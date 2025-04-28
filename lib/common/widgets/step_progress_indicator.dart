// step_progress_indicator.dart
import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF2952D9) : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
