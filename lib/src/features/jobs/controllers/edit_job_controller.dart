// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/job.dart';
import '../repositories/jobs_repository.dart';
part 'edit_job_controller.g.dart';

@riverpod
class EditJobController extends _$EditJobController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<bool> submit({
    Job? oldJob,
    JobID? jobId,
    required Job job,
  }) async {
    // set loading state

    state = const AsyncValue.loading();
    final repository = ref.read(jobsRepositoryProvider);

    if (oldJob != null) {
      state = await AsyncValue.guard(
        () => repository.updateJob(job: job, id: jobId as JobID),
      );
    } else {
      state = await AsyncValue.guard(
        () => repository.addJob(job: job),
      );
    }

    return state.hasError == false;
  }
}
