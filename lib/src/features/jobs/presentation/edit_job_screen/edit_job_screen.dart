import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/empty_placeholder_widget.dart';
import '../../controllers/jobs_read_controller.dart';
import '../../domain/job.dart';
import 'update_job_screen.dart';

class EditJobScreen extends ConsumerWidget {
  const EditJobScreen({super.key, this.id});
  final ID? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJob = ref.watch(JobsReadControllerProvider(id as ID));

    return AsyncValueWidget<Job?>(
      value: asyncJob,
      data: (job) => job != null
          ? UpdateJobScreen(job: job)
          : const EmptyPlaceholderWidget(message: 'Not found'),
    );
  }
}
