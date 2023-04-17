// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_read_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobsReadControllerHash() =>
    r'b1e8cabb80d013cee2106d6a3492e0638a4abe5a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$JobsReadController
    extends BuildlessAutoDisposeAsyncNotifier<Job?> {
  late final String id;

  FutureOr<Job?> build(
    String id,
  );
}

/// See also [JobsReadController].
@ProviderFor(JobsReadController)
const jobsReadControllerProvider = JobsReadControllerFamily();

/// See also [JobsReadController].
class JobsReadControllerFamily extends Family<AsyncValue<Job?>> {
  /// See also [JobsReadController].
  const JobsReadControllerFamily();

  /// See also [JobsReadController].
  JobsReadControllerProvider call(
    String id,
  ) {
    return JobsReadControllerProvider(
      id,
    );
  }

  @override
  JobsReadControllerProvider getProviderOverride(
    covariant JobsReadControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jobsReadControllerProvider';
}

/// See also [JobsReadController].
class JobsReadControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<JobsReadController, Job?> {
  /// See also [JobsReadController].
  JobsReadControllerProvider(
    this.id,
  ) : super.internal(
          () => JobsReadController()..id = id,
          from: jobsReadControllerProvider,
          name: r'jobsReadControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jobsReadControllerHash,
          dependencies: JobsReadControllerFamily._dependencies,
          allTransitiveDependencies:
              JobsReadControllerFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is JobsReadControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Job?> runNotifierBuild(
    covariant JobsReadController notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
