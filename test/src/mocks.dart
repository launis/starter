import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/src/features/authentication/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}
