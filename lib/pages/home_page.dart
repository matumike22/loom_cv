import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/gradient_container.dart';
import '../widgets/liquid_button.dart';
import 'add_cv_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('CV Shift'),

        actions: [
          LiquidButton(
            width: 120,
            height: 50,
            buttonText: "Create",
            buttonIcon: CupertinoIcons.plus,
            onTap: () {},
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
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
            ),
          ),
        ),
      ),
    );
  }
}
