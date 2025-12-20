import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../repo/state_providers.dart';
import '../widgets/cv_page.dart';
import '../widgets/cv_pdf.dart';
import '../widgets/gradient_container.dart';
import '../widgets/liquid_button.dart';
import '../widgets/liquid_container.dart';
import '../widgets/user_pop_over.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentCVData = ref.watch(recentCVsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text('CV Shift'),
        ),

        actions: [
          LiquidButton(
            width: 120,
            height: 50,
            buttonText: "Create",
            buttonIcon: CupertinoIcons.plus,
            onTap: () {
              context.go('/add-cv');
            },
          ),
          const SizedBox(width: 20),
          UserPopOver(),
          const SizedBox(width: 20),
        ],
      ),
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Builder(
              builder: (context) {
                if (recentCVData.isLoading) {
                  return LoadingAnimationWidget.beat(
                    color: Colors.purple.shade200,
                    size: 48,
                  );
                }

                if (recentCVData.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Something went wrong',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            // force refresh
                            ref.invalidate(recentCVsProvider);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final recentCVs = recentCVData.value ?? [];

                return GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    ...recentCVs.map(
                      (cvData) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: CvPage(data: cvData.content),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LiquidButton(
                                        width: 150,
                                        height: 50,
                                        buttonText: 'Print',
                                        buttonIcon: CupertinoIcons.printer,
                                        onTap: () async {
                                          await CvPdfPage().printCvPdf(
                                            cvData.content,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      LiquidButton(
                                        width: 100,
                                        height: 50,
                                        buttonText: 'Close',
                                        onTap: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: LiquidContainer(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          opacity: 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.doc_circle,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Tooltip(
                                      message: cvData.title,
                                      child: Text(
                                        cvData.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    child: Icon(
                                      CupertinoIcons.ellipsis_vertical,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Last updated: ${cvData.updatedAt.toLocal()}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LiquidButton(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      buttonText: 'New CV',
                      buttonIcon: CupertinoIcons.plus,
                      borderRadius: 30,
                      onTap: () {
                        context.go('/add-cv');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
