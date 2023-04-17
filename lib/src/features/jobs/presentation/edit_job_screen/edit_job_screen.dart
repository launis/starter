import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/src/common_widgets/async_value_widget.dart';
import 'package:starter/src/common_widgets/empty_placeholder_widget.dart';
import 'package:starter/src/common_widgets/error_message_widget.dart';
import 'package:starter/src/features/jobs/controllers/jobs_read_controller.dart';
import 'package:starter/src/features/jobs/domain/job.dart';
import 'package:starter/src/features/jobs/presentation/edit_job_screen/update_job_screen.dart';
import 'package:starter/src/localization/string_hardcoded.dart';

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
