import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/simple_text.dart';

class DifficultyRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T> onChanged;

  const DifficultyRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0XFF3EB8D4) : null,
          border: Border.all(
            color: Theme.of(context).colorScheme.shadow,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        width: 300.w,
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: SimpleText(
            label,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
