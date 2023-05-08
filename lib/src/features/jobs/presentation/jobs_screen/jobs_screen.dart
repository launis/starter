import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../common_widgets/action_text_button.dart';
import '../../../../common_widgets/error_message_widget.dart';
import '../../../../routing/adaptive_router.dart';
import '/src/constants/strings.dart';
import '/src/features/jobs/repositories/jobs_repository.dart';
import '/src/features/jobs/domain/job.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(jobsQueryProvider).orderBy('name');
    const String addroute = '${JobsPageRoute.path}/${AddJobPageRoute.path}';
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          ActionTextButton(
            text: 'Add',
            onPressed: () => context.push(addroute),
          ),
        ],
      ),
      body: FirestoreListView<Job>(
        emptyBuilder: (context) => const ErrorMessageWidget('No data'),
        errorBuilder: (context, error, stackTrace) =>
            ErrorMessageWidget(error.toString()),
        loadingBuilder: (context) => const CircularProgressIndicator(),
        query: query,
        itemBuilder: (context, snapshot) {
          Job job = snapshot.data();
          return JobListTile(
              job: job,
              onTap: () =>
                  JobPageRoute(id: snapshot.id.toString()).push(context));
        },
      ),
    );
  }
}

class JobListTile extends StatelessWidget {
  const JobListTile({Key? key, required this.job, this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
