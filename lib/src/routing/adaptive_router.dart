import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import '../features/authentication/presentation/custom_sign_in_screen.dart';
import '../features/authentication/repositories/auth_repository.dart';
import '../features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import '../features/jobs/presentation/edit_job_screen/update_job_screen.dart';
import '../features/jobs/presentation/jobs_screen/jobs_screen.dart';
import 'not_found_screen.dart';

part 'adaptive_router.g.dart';

final rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: '_rootNavigatorKey');

final shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: '_shellNavigatorKey');

@riverpod
GoRouter goRoute(GoRouteRef ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: $appRoutes,
    errorBuilder: (context, state) =>
        const ErrorPageRoute().build(context, state),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final User? currentUser = ref.watch(authRepositoryProvider).currentUser;
      if (!state.matchedLocation.startsWith('/forgot-password')) {
        if (currentUser == null) {
          return SignInPageRoute.path;
        }
        if (!currentUser.emailVerified && currentUser.email != null) {
          return VerifyEmailPageRoute.path;
        }
      }
      return null;
    },
  );
}

@TypedShellRoute<RootPageRoute>(
  routes: [
    TypedGoRoute<SignInPageRoute>(
      path: SignInPageRoute.path,
    ),
    TypedGoRoute<ProfilePageRoute>(
      path: ProfilePageRoute.path,
    ),
    TypedGoRoute<ErrorPageRoute>(
      path: ErrorPageRoute.path,
    ),
    TypedGoRoute<ForgotPasswordPageRoute>(
      path: ForgotPasswordPageRoute.path,
    ),
    TypedGoRoute<VerifyEmailPageRoute>(
      path: VerifyEmailPageRoute.path,
    ),
    TypedGoRoute<JobsPageRoute>(
      path: JobsPageRoute.path,
      routes: [
        TypedGoRoute<AddJobPageRoute>(
          path: AddJobPageRoute.path,
        ),
        TypedGoRoute<JobPageRoute>(
          path: JobPageRoute.path,
        ),
      ],
    ),
  ],
)
class RootPageRoute extends ShellRouteData {
  const RootPageRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    final child = (((navigator as HeroControllerScope).child as Navigator)
            .pages
            .last as MaterialPage)
        .child;

    return AdaptiveScaffold(
      key: const GlobalObjectKey('AdaptiveScaffold'),
      selectedIndex: locationToIndex(state.location),
      useDrawer: false,
      internalAnimations: false,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.work_outlined),
          selectedIcon: Icon(Icons.work),
          label: 'Jobs',
        ),
      ],
      onSelectedIndexChange: (p0) {
        indexToGo(p0, context);
      },
      body: (context) {
        return child;
      },
      smallBody: (context) {
        return child;
      },
    );
  }

  int locationToIndex(String location) {
    if (location.startsWith(ProfilePageRoute.path)) {
      return 0;
    }

    if (location.startsWith(JobsPageRoute.path)) {
      return 1;
    }

    return 0;
  }

  void indexToGo(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(ProfilePageRoute.path);
        break;
      case 1:
        context.go(JobsPageRoute.path);
        break;
    }
  }
}

class SignInPageRoute extends GoRouteData {
  const SignInPageRoute();

  static const path = '/signIn';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomSignInScreen();
  }
}

class VerifyEmailPageRoute extends GoRouteData {
  const VerifyEmailPageRoute();

  static const path = '/verify-email';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmailVerificationScreen(
      actions: [
        EmailVerifiedAction(
          () => context.pushReplacement(JobsPageRoute.path),
        ),
        AuthCancelledAction(
          (context) {
            FirebaseUIAuth.signOut(context: context);
            context.pushReplacement(SignInPageRoute.path);
          },
        ),
      ],
    );
  }
}

class ForgotPasswordPageRoute extends GoRouteData {
  final String email;

  const ForgotPasswordPageRoute({
    required this.email,
  });

  static const path = '/forgot-password/:email';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ForgotPasswordScreen(
        email: email.toString(),
      );
}

class ProfilePageRoute extends GoRouteData {
  const ProfilePageRoute();

  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) => ProfileScreen(
        providers: [EmailAuthProvider()],
        actions: [
          SignedOutAction((context) {
            context.pushReplacement(SignInPageRoute.path);
          }),
        ],
      );
}

class JobsPageRoute extends GoRouteData {
  const JobsPageRoute();

  static const path = '/jobs';

  @override
  Widget build(BuildContext context, GoRouterState state) => const JobsScreen();
}

class ErrorPageRoute extends GoRouteData {
  const ErrorPageRoute();

  static const path = '/error';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}

class AddJobPageRoute extends GoRouteData {
  const AddJobPageRoute();

  static const path = 'add';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UpdateJobScreen();
}

class JobPageRoute extends GoRouteData {
  final String id;

  const JobPageRoute({
    required this.id,
  });

  static const path = 'job/:id';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EditJobScreen(id: id.toString());
}
