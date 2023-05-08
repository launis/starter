import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/adaptive_router.dart';

import '../repositories/auth_repository.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Sign in'),
        ),
        body: SignInScreen(
          providers: [EmailAuthProvider()],
          actions: [
            ForgotPasswordAction(
              (context, email) => ForgotPasswordPageRoute(
                      email: email == null
                          ? ''
                          : email == ''
                              ? 'email@email.com'
                              : email)
                  .push(context),
            ),
            AuthStateChangeAction<SignedIn>((context, state) =>
                state.user!.emailVerified
                    ? context.push(JobsPageRoute.path)
                    : context.pushReplacement(VerifyEmailPageRoute.path)),
            AuthStateChangeAction<UserCreated>((context, state) =>
                state.credential.user!.emailVerified
                    ? context.push(JobsPageRoute.path)
                    : context.pushReplacement(VerifyEmailPageRoute.path)),
            AuthStateChangeAction<CredentialLinked>((context, state) =>
                state.user.emailVerified
                    ? context.push(JobsPageRoute.path)
                    : context.pushReplacement(VerifyEmailPageRoute.path)),
          ],
        ),
      );
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
