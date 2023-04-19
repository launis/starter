import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/src/constants/keys.dart';

import '../features/authentication/repositories/auth_repository.dart';
import '../features/jobs/presentation/edit_job_screen/update_job_screen.dart';
import '/src/features/authentication/presentation/custom_profile_screen.dart';
import '/src/features/authentication/presentation/custom_sign_in_screen.dart';
import '/src/features/jobs/domain/job.dart';
import '/src/features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import '/src/features/jobs/presentation/jobs_screen/jobs_screen.dart';

import '/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'go_router_refresh_stream.dart';
part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  signIn,
  jobs,
  job,
  addJob,
  editJob,
  profile,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final signedIn = authRepository.currentUser != null;
      final bool signingIn = state.subloc == '/signin';

      // Go to /signin if the user is not signed in
      if (!signedIn && !signingIn) {
        return '/signin';
      }
      // Go to /books if the user is signed in and tries to go to /signin.
      else if (signedIn && signingIn) {
        return '/jobs';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CustomSignInScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/jobs',
            name: AppRoute.jobs.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const JobsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addJob.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: const UpdateJobScreen());
                },
              ),
              GoRoute(
                path: 'job/:${Keys.id}',
                name: AppRoute.job.name,
                pageBuilder: (context, state) {
                  final ID id = state.params[Keys.id]!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: EditJobScreen(id: id),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.profile.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CustomProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
