import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/widgets/app_button.dart';
import 'package:insurance_mobile/shared/widgets/app_feedback_card.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    this.actionLabel,
    this.onActionPressed,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: AppFeedbackCard(
          tone: AppFeedbackTone.error,
          message: message,
          centerAligned: true,
          action: actionLabel != null && onActionPressed != null
              ? AppButton(
                  label: actionLabel!,
                  onPressed: onActionPressed,
                  isExpanded: false,
                )
              : null,
        ),
      ),
    );
  }
}
