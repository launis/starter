// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobsRepositoryHash() => r'99834710b25b2229bf6bd85bb1e522bfb2b61d5b';

/// See also [jobsRepository].
@ProviderFor(jobsRepository)
final jobsRepositoryProvider = Provider<JobsRepository>.internal(
  jobsRepository,
  name: r'jobsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jobsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobsRepositoryRef = ProviderRef<JobsRepository>;
String _$jobsQueryHash() => r'75ccabcb24c4c42d30d00be0a88fbda2d31864e1';

/// See also [jobsQuery].
@ProviderFor(jobsQuery)
final jobsQueryProvider = AutoDisposeProvider<Query<Job>>.internal(
  jobsQuery,
  name: r'jobsQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobsQueryRef = AutoDisposeProviderRef<Query<Job>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
