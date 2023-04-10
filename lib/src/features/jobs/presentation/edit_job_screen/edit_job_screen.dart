import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/jobs_read_controller.dart';
import '../../domain/job.dart';
import 'update_job_screen.dart';

class EditJobScreen extends ConsumerWidget {
  const EditJobScreen({super.key, this.jobId});
  final JobID? jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJob = ref.watch(JobsReadControllerProvider(jobId as JobID));
    return asyncJob.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text("Error: $err"),
      data: (data) => UpdateJobScreen(jobId: jobId, job: data),
    );
  }
}
