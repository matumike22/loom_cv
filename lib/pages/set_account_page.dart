import 'package:cv_shift/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/account_repo.dart';
import '../repo/models/account.dart';
import '../repo/state_providers.dart';
import '../widgets/custom_padding.dart';
import '../widgets/gradient_container.dart';
import '../widgets/liquid_button.dart';
import '../widgets/liquid_container.dart';

class SetAccountPage extends StatefulWidget {
  const SetAccountPage({super.key, this.account});

  final Account? account;

  static const String routeName = '/set_account';

  @override
  State<SetAccountPage> createState() => _SetAccountPageState();
}

class _SetAccountPageState extends State<SetAccountPage> {
  final _formKey = GlobalKey<FormState>();

  String? _fullName, _role, _location, _phone, _linkedIn;
  String? _github, _cvInfo;

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _fullName = widget.account!.name;
      _role = widget.account!.role;
      _location = widget.account!.location;
      _phone = widget.account!.phoneNumber;
      _linkedIn = widget.account!.linkedIn;
      _github = widget.account!.gitHub;
      _cvInfo = widget.account!.cvDetails;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: GradientContainer(
        child: SingleChildScrollView(
          child: CustomPadding(
            maxWidth: 420,
            child: Form(
              key: _formKey,
              child: LiquidContainer(
                width: double.infinity,
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.account != null
                          ? 'Edit your account'
                          : 'Set up your account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tell us a bit about yourself',
                      style: TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    _buildField(
                      label: 'Full name',
                      initialValue: _fullName,
                      onSaved: (v) => _fullName = v,
                      validator: _required,
                    ),

                    _buildField(
                      label: 'Role',
                      initialValue: _role,
                      onSaved: (v) => _role = v,
                      validator: _required,
                    ),

                    _buildField(
                      label: 'Location',
                      initialValue: _location,
                      onSaved: (v) => _location = v,
                    ),

                    _buildField(
                      label: 'Phone number',
                      initialValue: _phone,
                      keyboardType: TextInputType.phone,
                      onSaved: (v) => _phone = v,
                    ),

                    _buildField(
                      label: 'Professional summary / CV details',
                      initialValue: _cvInfo,
                      hint:
                          'Briefly describe your experience, roles, skills, and achievements',
                      maxLines: 5,
                      onSaved: (v) => _cvInfo = v,
                    ),

                    _buildField(
                      label: 'LinkedIn URL',
                      initialValue: _linkedIn,
                      keyboardType: TextInputType.url,
                      onSaved: (v) => _linkedIn = v,
                    ),

                    _buildField(
                      label: 'GitHub URL',
                      initialValue: _github,
                      keyboardType: TextInputType.url,
                      onSaved: (v) => _github = v,
                    ),

                    const SizedBox(height: 20),

                    Consumer(
                      builder: (context, ref, _) {
                        return LiquidButton(
                          width: double.infinity,
                          buttonText: 'Save',
                          onTap: () => _submit(ref),
                        );
                      },
                    ),
                  ],
                ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    String? hint,
    initialValue,
    int maxLines = 1,
    TextInputType? keyboardType,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: maxLines > 1,
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
        autocorrect: false,
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<void> _submit(WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    try {
      final authState = ref.read(authStateProvider).value;
      if (authState == null) throw Exception('User not authenticated');
      final account = Account(
        id: authState.uid,
        email: authState.email ?? '',
        name: _fullName!,
        role: _role!,
        location: _location,
        phoneNumber: _phone,
        cvDetails: _cvInfo,
        linkedIn: _linkedIn,
        gitHub: _github,
      );
      showLoadingDialog(context, 'Saving...');
      await AccountRepo().setAccount(account);
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        if (widget.account != null) Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        showErrorDialog(context, 'Failed to set up account. Please try again.');
      }
    }
  }
}
