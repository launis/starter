import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/keys.dart';

import '../domain/job.dart';
part 'jobs_repository.g.dart';

class JobsRepository {
  JobsRepository(this._firestore);

  final FirebaseFirestore _firestore;
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection(Keys.jobsPath);

  static String jobPath(String jobID) => '${Keys.jobsPath}/$jobID';

  // create

  Future<void> addJob({
    required Job job,
  }) async =>
      await _collection.add(job.toJson());

  // update
  Future<void> updateJob({
    required Job job,
    required JobID id,
  }) async =>
      await _firestore.doc(jobPath(id)).update(job.toJson());

  // delete
  Future<void> deleteJob({
    required JobID id,
  }) async =>
      await _firestore.doc(jobPath(id)).delete();

  // read
  Future<Job?> readJob({required JobID id}) async {
    final response = await _firestore.doc(jobPath(id)).get();
    return Job.fromJson(response.data()!);
  }

  Query<Job> queryJobs() => _collection.withConverter(
        fromFirestore: (snapshot, _) => Job.fromJson(snapshot.data()!),
        toFirestore: (job, _) => job.toJson(),
      );
}

@Riverpod(keepAlive: true)
JobsRepository jobsRepository(JobsRepositoryRef ref) {
  return JobsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Job> jobsQuery(JobsQueryRef ref) {
  final repository = ref.watch(jobsRepositoryProvider);
  return repository.queryJobs();
}
