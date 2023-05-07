import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/action_text_button.dart';
import '../../controllers/edit_job_controller.dart';
import '../../domain/job.dart';

class UpdateJobScreen extends ConsumerStatefulWidget {
  const UpdateJobScreen({super.key, this.job});
  final Job? job;

  @override
  ConsumerState<UpdateJobScreen> createState() => _UpdateJobPageState();
}

class _UpdateJobPageState extends ConsumerState<UpdateJobScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  ID? _id;
  int? _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _id = widget.job?.id;
      _name = widget.job?.name;
      _ratePerHour = widget.job?.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final asyncJob = ref.watch(editJobControllerProvider);
      return asyncJob.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Text("Error: $err"),
        data: (data) async {
          final job = Job(
              id: _id ?? '',
              name: _name as String,
              ratePerHour: _ratePerHour as int);
          final success = await ref
              .read(editJobControllerProvider.notifier)
              .submit(oldJob: widget.job, newJob: job);
          if (context.mounted && success) {
            context.pop();
          }
        },
      );
    }
  }

  Future<void> _delete() async {
    final asyncJob = ref.watch(editJobControllerProvider);
    return asyncJob.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text("Error: $err"),
      data: (data) async {
        final success =
            await ref.read(editJobControllerProvider.notifier).deleteJob(
                  id: _id,
                );
        if (context.mounted && success) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editJobControllerProvider);
    if (widget.job != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Job'),
          actions: <Widget>[
            ActionTextButton(
              text: 'Save',
              onPressed: state.isLoading ? null : _submit,
            ),
            ActionTextButton(
              text: 'Delete',
              onPressed: state.isLoading ? null : _delete,
            ),
          ],
        ),
        body: _buildContents(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('New Job'),
          actions: <Widget>[
            ActionTextButton(
              text: 'Save',
              onPressed: state.isLoading ? null : _submit,
            ),
          ],
        ),
        body: _buildContents(),
      );
    }
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Job name'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Rate per hour'),
        keyboardAppearance: Brightness.light,
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value ?? '') ?? 0,
      ),
    ];
  }
}
