import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/custom_padding.dart';
import '../widgets/liquid_button.dart';
import '../widgets/liquid_container.dart';

class AddCvPage extends StatelessWidget {
  const AddCvPage({super.key});
  static const String routeName = 'add-cv';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: CustomPadding(
        maxWidth: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
              [
                    LiquidContainer(
                      width: double.maxFinite,
                      height: 500,
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
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Additional Info',
                            ),
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
                          child: LiquidButton(
                            width: double.maxFinite,
                            height: 50,
                            buttonText: 'Create CV',
                            buttonIcon: CupertinoIcons.plus,
                            onTap: () {},
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
    );
  }
}
