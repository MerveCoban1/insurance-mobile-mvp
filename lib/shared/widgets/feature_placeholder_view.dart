import 'package:flutter/material.dart';
import 'package:insurance_mobile/shared/extensions/build_context_extensions.dart';

class FeaturePlaceholderView extends StatelessWidget {
  const FeaturePlaceholderView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.comingSoon,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
