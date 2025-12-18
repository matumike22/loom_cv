import 'package:flutter/material.dart';
import 'package:super_bullet_list/bullet_list.dart';

class CvPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const CvPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final header = data['header'];
    final experience = data['experience'] as List;
    final projects = data['projects'] as List;
    final education = data['education'] as List;
    final skills = data['skills'] as List;

    return Center(
      child: Container(
        color: Colors.white,
        width: 794,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.black, fontSize: 12, height: 1.15),
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
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final Map<String, dynamic> header;
  const _HeaderSection(this.header);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header['full_name'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          header['role'],
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _Info(header['location']),
            _Dot(),
            _Info(header['email']),
            _Dot(),
            _Info(header['phone']),
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${e['role']} — ${e['company']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    '${e['start_year']} – ${e['end_year']}',
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
                  items: (e['responsibilities'] as List)
                      .map<Widget>((r) => Text(r))
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    '${p['year']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(p['context']),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SuperBulletList(
                  iconSize: 6,
                  separator: SizedBox(height: 8),
                  iconColor: Colors.black,
                  isOrdered: false,
                  items: (p['highlights'] as List)
                      .map<Widget>((h) => Text(h))
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e['degree'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
              ),
              const SizedBox(height: 4),
              Text(e['institution']),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SuperBulletList(
                  iconSize: 6,
                  separator: SizedBox(height: 8),
                  iconColor: Colors.black,
                  isOrdered: false,
                  items: [Text(e['achievement'])],
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s['category'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(width: 4),
              const Text(':'),
              const SizedBox(width: 4),
              Builder(
                builder: (context) {
                  final items = List<String>.from(s['items']);
                  return Wrap(
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
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
