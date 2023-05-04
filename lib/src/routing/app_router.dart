import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/src/constants/keys.dart';
import 'package:starter/src/features/authentication/controllers/auth_providers.dart';
import 'package:starter/src/utils/decorations.dart';

import '../features/authentication/repositories/auth_repository.dart';
import '../features/jobs/presentation/edit_job_screen/update_job_screen.dart';
import '/src/features/authentication/presentation/custom_profile_screen.dart';
import '/src/features/authentication/presentation/custom_sign_in_screen.dart';
import '/src/features/jobs/domain/job.dart';
import '/src/features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import '/src/features/jobs/presentation/jobs_screen/jobs_screen.dart';

import '/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';
part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  signIn,
  forgotPassword,
  verifyEmail,
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
    initialLocation: init(authRepository),
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (authRepository.currentUser == null &&
          !state.subloc.startsWith('/forgot-password')) {
        return '/signin';
      }
      return state.subloc;
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
      GoRoute(
        path: '/forgot-password/:email',
        name: AppRoute.forgotPassword.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ForgotPasswordScreen(
            email: state.params['email'],
          ),
        ),
      ),
      GoRoute(
          path: '/verify-email',
          name: AppRoute.verifyEmail.name,
          pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: EmailVerificationScreen(actions: [
                  EmailVerifiedAction(
                    () => context.goNamed(AppRoute.jobs.name),
                  ),
                  AuthCancelledAction((context) {
                    FirebaseUIAuth.signOut(context: context);
                    context.pushNamed(AppRoute.signIn.name);
                  }),
                ]),
              )),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) =>
            ScaffoldWithBottomNavBar(child: child),
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
                pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const UpdateJobScreen()),
              ),
              GoRoute(
                path: 'job/:${Keys.id}',
                name: AppRoute.job.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: EditJobScreen(id: state.params[Keys.id]!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: AppRoute.profile.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CustomProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}

init(authRepository) {
  if (authRepository.currentUser == null) {
    return '/signin';
  }

  if (!authRepository.currentUser!.emailVerified &&
      authRepository.currentUser!.email != null) {
    return '/verify-email';
  }
  return '/jobs';
}
