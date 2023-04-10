import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/jobs_repository.dart';

part 'jobs_del_controller.g.dart';

@riverpod
class JobsDelController extends _$JobsDelController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> deleteJob({required jobId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(jobsRepositoryProvider).deleteJob(id: jobId));
    return state.hasError == false;
  }
}
