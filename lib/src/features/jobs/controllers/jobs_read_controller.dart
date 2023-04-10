import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/job.dart';
import '../repositories/jobs_repository.dart';

part 'jobs_read_controller.g.dart';

@riverpod
class JobsReadController extends _$JobsReadController {
  @override
  FutureOr<Job?> build(JobID jobId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(jobsRepositoryProvider).readJob(id: jobId));
    return state.value;
  }
}
