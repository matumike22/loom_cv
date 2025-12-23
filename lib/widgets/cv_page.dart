import 'package:flutter/material.dart';
import 'package:super_bullet_list/bullet_list.dart';

class CvPage extends StatelessWidget {
  final Map<String, dynamic>? data;

  const CvPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final header = data?['header'] ?? {};
    final experience = data?['experience'] as List? ?? [];
    final projects = data?['projects'] as List? ?? [];
    final education = data?['education'] as List? ?? [];
    final skills = data?['skills'] as List? ?? [];

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        width: 794,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.black, fontSize: 12, height: 1.15),
              child: SelectionArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderSection(header),
                    const Divider(thickness: 2, color: Colors.black),
                    const SizedBox(height: 12),
                    _Section(
                      title: 'Experience',
                      child: _ExperienceSection(experience),
                    ),
                    _Section(
                      title: 'Projects',
                      child: _ProjectsSection(projects),
                    ),
                    _Section(
                      title: 'Education',
                      child: _EducationSection(education),
                    ),
                    _Section(title: 'Skills', child: _SkillsSection(skills)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final Map<String, dynamic> header;
  const _HeaderSection(this.header);

  @override
  Widget build(BuildContext context) {
    String fullName = header['full_name'] ?? '';
    String role = header['role'] ?? '';
    String location = header['location'] ?? '';
    String email = header['email'] ?? '';
    String phone = header['phone'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(role, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _Info(location),
            _Dot(),
            _Info(email),
            _Dot(),
            _Info(phone),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 2,
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );
  }
}

class _Info extends StatelessWidget {
  final String text;
  const _Info(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 10));
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 0.5, color: Colors.black),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  final List experience;
  const _ExperienceSection(this.experience);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experience.map((e) {
        String role = e['role'] ?? '';
        String company = e['company'] ?? '';
        String startYear = e['start_year']?.toString() ?? '';
        String endYear = e['end_year']?.toString() ?? '';
        List responsibilities = e['responsibilities'] as List? ?? [];

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$role — $company',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    '$startYear – $endYear',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SuperBulletList(
                  iconSize: 6,
                  separator: SizedBox(height: 8),
                  iconColor: Colors.black,
                  isOrdered: false,
                  items: responsibilities
                      .map<Widget>((r) => Text(r?.toString() ?? ''))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  final List projects;
  const _ProjectsSection(this.projects);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects.map((p) {
        String name = p['name'] ?? '';
        String year = p['year']?.toString() ?? '';
        String contextText = p['context'] ?? '';
        List highlights = p['highlights'] as List? ?? [];

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    year,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(contextText),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SuperBulletList(
                  iconSize: 6,
                  separator: SizedBox(height: 8),
                  iconColor: Colors.black,
                  isOrdered: false,
                  items: highlights
                      .map<Widget>((h) => Text(h?.toString() ?? ''))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EducationSection extends StatelessWidget {
  final List education;
  const _EducationSection(this.education);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: education.map((e) {
        String degree = e['degree'] ?? '';
        String institution = e['institution'] ?? '';
        String achievement = e['achievement'] ?? '';

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                degree,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
              ),
              const SizedBox(height: 4),
              Text(institution),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SuperBulletList(
                  iconSize: 6,
                  separator: SizedBox(height: 8),
                  iconColor: Colors.black,
                  isOrdered: false,
                  items: [Text(achievement)],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  final List skills;
  const _SkillsSection(this.skills);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: skills.map((s) {
        String category = s['category'] ?? '';
        final items = List<String>.from(s['items'] as List? ?? []);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(width: 4),
              const Text(':'),
              const SizedBox(width: 4),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,

                  children: List.generate(
                    items.length,
                    (index) => Text(
                      index == items.length - 1
                          ? '${items[index]}.'
                          : '${items[index]},',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
