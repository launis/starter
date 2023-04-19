// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/src/routing/app_router.dart';
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
    required Job newJob,
  }) async {
    final repository = ref.read(jobsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => oldJob != null
          ? repository.updateJob(job: newJob)
          : repository.addJob(job: newJob),
    );
    return state.hasError == false;
  }

  Future<bool> deleteJob({required id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(jobsRepositoryProvider).deleteJob(id: id));
    return state.hasError == false;
  }
}
