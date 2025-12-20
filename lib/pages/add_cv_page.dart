import 'package:cv_shift/repo/cv_ai_service.dart';
import 'package:cv_shift/repo/models/cv_data.dart';
import 'package:cv_shift/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/cv_data_repo.dart';
import '../repo/state_providers.dart';
import '../widgets/custom_padding.dart';
import '../widgets/cv_page.dart';
import '../widgets/liquid_button.dart';
import '../widgets/liquid_container.dart';

class AddCvPage extends StatefulWidget {
  const AddCvPage({super.key});
  static const String routeName = 'add-cv';

  @override
  State<AddCvPage> createState() => _AddCvPageState();
}

class _AddCvPageState extends State<AddCvPage> {
  String? _jobDescription, _additionalInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: CustomPadding(
        maxWidth: 500,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                [
                      LiquidContainer(
                        width: double.maxFinite,
                        height: 510,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create New CV',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Job Description',
                              ),
                              maxLines: 8,
                              onSaved: (value) {
                                _jobDescription = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a job description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Additional Info',
                              ),
                              onSaved: (value) {
                                _additionalInfo = value;
                              },
                              maxLines: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Consumer(
                              builder: (context, ref, _) {
                                return LiquidButton(
                                  width: double.maxFinite,
                                  height: 50,
                                  buttonText: 'Create CV',
                                  buttonIcon: CupertinoIcons.plus,
                                  onTap: () => _submit(ref),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: LiquidButton(
                              width: double.maxFinite,
                              height: 50,
                              buttonText: "Close",
                              buttonIcon: Icons.close,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ]
                    .animate(interval: 50.ms)
                    .scaleXY(
                      begin: 0.8,
                      end: 1.0,
                      duration: 150.ms,
                      curve: Curves.easeInOut,
                    )
                    .fadeIn(duration: 150.ms, curve: Curves.easeInOut),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final account = ref.read(accountProvider).value;

        if (account == null) {
          throw Exception('No account found');
        }

        showLoadingDialog(context, 'Creating CV...');

        final result = await CvAiService.generateCv(
          userInfo: account.toJson(),
          jobDescription: _jobDescription!,
          additionalInfo: _additionalInfo,
        );

        await CvDataRepo().addCvData(
          CvData(
            id: '',
            title: result['header']['company'] ?? 'Untitled CV',
            userId: account.id,
            content: result,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        if (mounted) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (ctx) => Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CvPage(data: result),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LiquidButton(
                    width: 150,
                    height: 50,
                    buttonText: 'Close',
                    onTap: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // Close loading dialog
          showErrorDialog(context, 'Opps! Something went wrong.');
        }
      }
    }
  }
}
