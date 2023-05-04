import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter/src/routing/app_router.dart';
import 'package:starter/src/utils/decorations.dart';

import '../../../routing/adaptive_router.dart';
import '../controllers/auth_controller.dart';
import '../controllers/auth_providers.dart';
import '../repositories/auth_repository.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SignInScreen(
        providers: authProviders,
        actions: [
          ForgotPasswordAction(
            (context, email) =>
                ForgotPasswordPageRoute(email: email).push(context),
          ),
          AuthStateChangeAction<SignedIn>((context, state) =>
              state.user!.emailVerified
                  ? context.go(JobsPageRoute.path)
                  : context.go(VerifyEmailPageRoute.path)),
          AuthStateChangeAction<UserCreated>((context, state) =>
              state.credential.user!.emailVerified
                  ? context.go(JobsPageRoute.path)
                  : context.go(VerifyEmailPageRoute.path)),
          AuthStateChangeAction<CredentialLinked>((context, state) =>
              state.user.emailVerified
                  ? context.go(JobsPageRoute.path)
                  : context.go(VerifyEmailPageRoute.path)),
        ],
      ),
    );
  }
}

class SignInAnonymouslyFooter extends ConsumerWidget {
  const SignInAnonymouslyFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('or'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        TextButton(
          onPressed: () => ref.read(firebaseAuthProvider).signInAnonymously(),
          child: const Text('Sign in anonymously'),
        ),
      ],
    );
  }
}
