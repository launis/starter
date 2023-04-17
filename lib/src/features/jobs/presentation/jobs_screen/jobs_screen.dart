import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter/src/constants/keys.dart';
import '../../../../common_widgets/action_text_button.dart';
import '/src/constants/strings.dart';
import '/src/features/jobs/repositories/jobs_repository.dart';
import '/src/features/jobs/domain/job.dart';
import '/src/routing/app_router.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          ActionTextButton(
            text: 'Add',
            onPressed: () => context.goNamed(AppRoute.addJob.name),
          ),
        ],
      ),
      body: FirestoreListView<Job>(
        query: ref.watch(jobsQueryProvider),
        itemBuilder: (context, snapshot) {
          Job job = snapshot.data();
          return JobListTile(
            job: job,
            onTap: () => context.goNamed(
              AppRoute.job.name,
              //params: {Keys.jobsId: snapshot.id},
              params: {Keys.id: snapshot.id},
            ),
          );
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
