import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_mobile/features/claim/presentation/screens/screens.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/screens/policies_screen.dart';
import 'package:insurance_mobile/features/policy/presentation/screens/policy_detail_screen.dart';
import 'package:insurance_mobile/navigation/navigation.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.policiesPath,
    routes: [
      GoRoute(
        path: AppRoutes.policiesPath,
        name: AppRoutes.policiesName,
        builder: (context, state) => const PolicyListScreen(),
      ),
      GoRoute(
        path: AppRoutes.policyDetailPath,
        name: AppRoutes.policyDetailName,
        builder: (context, state) {
          final extra = state.extra;

          return PolicyDetailScreen(
            policyId: state.pathParameters['policyId']!,
            initialPolicy: extra is Policy ? extra : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.claimFormPath,
        name: AppRoutes.claimFormName,
        builder: (context, state) => ClaimFormScreen(
          initialPolicyId: state.uri.queryParameters['policyId'],
        ),
      ),
      GoRoute(
        path: AppRoutes.claimSuccessPath,
        name: AppRoutes.claimSuccessName,
        builder: (context, state) => const ClaimSubmissionSuccessScreen(),
      ),
    ],
    redirect: (context, state) {
      if (state.uri.path == '/') {
        return AppRoutes.policiesPath;
      }

      return null;
    },
  );
});
