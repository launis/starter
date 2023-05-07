import 'package:flutter_test/flutter_test.dart';
import 'package:starter/src/features/jobs/domain/job.dart';

void main() {
  group('fromMap', () {
    test('job with all properties', () {
      final job = Job.fromJson(const {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
      expect(job, const Job(name: 'Blogging', ratePerHour: 10, id: ''));
    });

    test('missing name', () {
      expect(
          () => Job.fromJson(const {
                'ratePerHour': 10,
              }),
          throwsA(isInstanceOf<StateError>()));
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const job = Job(name: 'Blogging', ratePerHour: 10, id: '');
      expect(job.toJson(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: '');
      const job2 = Job(name: 'Blogging', ratePerHour: 5, id: '');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: '');
      const job2 = Job(name: 'Blogging', ratePerHour: 10, id: '');
      expect(job1 == job2, true);
    });
  });
}
