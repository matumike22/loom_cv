import 'package:flutter/material.dart';
import 'package:loom_cv/repo/cv_ai_service.dart';
import 'package:loom_cv/widgets/gradient_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Home Page')),
      body: GradientContainer(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final result = await CvAiService.generateCv(
                userInfo: {
                  "name": "Daniel Okoye",
                  "email": "daniel.okoye@gmail.com",
                  "telephone": "+2348012345678",
                },
                cvInfo:
                    "Software engineer with 5 years of experience in Flutter and Firebase...",
                jobDescription:
                    "Senior Flutter Engineer with Firebase, CI/CD, fintech experience",
                additionalInfo:
                    "Built expense tracking app. Mentored juniors. Stripe & Paystack.",
              );

              debugPrint(result.toString());
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}
