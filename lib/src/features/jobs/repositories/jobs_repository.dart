import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/keys.dart';

import '../domain/job.dart';
part 'jobs_repository.g.dart';

class JobsRepository {
  JobsRepository(this._firestore);

  final FirebaseFirestore _firestore;
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection(Keys.jobsPath);

  static String jobPath(String id) => '${Keys.jobsPath}/$id';

  // create
  Future<void> addJob({required Job job}) async => await _ref
      .add(job.toJson())
      .then((DocumentReference doc) async => await _firestore
          .doc(jobPath(doc.id))
          .set({Keys.id: doc.id}, SetOptions(merge: true)));

// update
  Future<void> updateJob({
    required Job job,
  }) async =>
      await _firestore.doc(jobPath(job.id)).update(job.toJson());

  // delete
  Future<void> deleteJob({
    required ID id,
  }) async =>
      await _firestore.doc(jobPath(id)).delete();

  // read
  Future<Job?> readJob({required ID id}) async {
    final response = await _firestore.doc(jobPath(id)).get();
    return Job.fromJson(response.data()!);
  }

  Query<Job> queryJobs() => _ref.withConverter(
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
