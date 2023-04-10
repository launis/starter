import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/jobs_del_controller.dart';
import '/src/constants/strings.dart';
import '/src/features/jobs/data/jobs_repository.dart';
import '/src/features/jobs/domain/job.dart';
import '/src/routing/app_router.dart';
import '/src/utils/async_value_ui.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => context.goNamed(AppRoute.addJob.name),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            jobsDelControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );

          final jobsQuery = ref.watch(jobsQueryProvider);

          return FirestoreListView<Job>(
            query: jobsQuery,
            itemBuilder: (context, doc) {
              final _job = doc.data();
              return Dismissible(
                key: Key('job-${doc.id}'),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  final _success = await ref
                      .read(jobsDelControllerProvider.notifier)
                      .deleteJob(jobId: doc.id);
                },
                child: JobListTile(
                  job: _job,
                  onTap: () => context.goNamed(
                    AppRoute.job.name,
                    params: {'id': doc.id},
                    extra: _job,
                  ),
                ),
              );
            },
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
