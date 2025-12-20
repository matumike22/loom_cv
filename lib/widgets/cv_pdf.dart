import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CvPdfPage {
  Future<void> printCvPdf(Map<String, dynamic>? data) async {
    final header = data?['header'] ?? {};
    final experience = data?['experience'] as List? ?? [];
    final projects = data?['projects'] as List? ?? [];
    final education = data?['education'] as List? ?? [];
    final skills = data?['skills'] as List? ?? [];

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.interRegular();
    final boldFont = await PdfGoogleFonts.interSemiBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(
            fontSize: 10,
            lineSpacing: 1.15,
            font: font,
            fontBold: boldFont,
          ),
        ),
        build: (_) => [
          _header(header),
          pw.Divider(thickness: 2),
          pw.SizedBox(height: 12),

          _sectionTitle('Experience'),
          ..._experience(experience),

          _sectionTitle('Projects'),
          ..._projects(projects),

          _sectionTitle('Education'),
          ..._education(education),

          _sectionTitle('Skills'),
          ..._skills(skills),
        ],
      ),
    );

    await Printing.layoutPdf(name: 'CV.pdf', onLayout: (_) async => pdf.save());
  }

  // ================= HEADER =================

  static pw.Widget _header(Map<String, dynamic> h) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          h['full_name'] ?? '',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          h['role'] ?? '',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          children: [
            _info(h['location']),
            _dot(),
            _info(h['email']),
            _dot(),
            _info(h['phone']),
          ],
        ),
      ],
    );
  }

  static pw.Widget _info(String? text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(right: 8),
      child: pw.Text(text ?? '', style: const pw.TextStyle(fontSize: 10)),
    );
  }

  static pw.Widget _dot() {
    return pw.Container(
      width: 2,
      height: 2,
      margin: const pw.EdgeInsets.symmetric(horizontal: 6),
      decoration: const pw.BoxDecoration(
        color: PdfColors.black,
        shape: pw.BoxShape.circle,
      ),
    );
  }

  // ================= SECTION TITLE =================

  static pw.Widget _sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 16, bottom: 6),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title.toUpperCase(),
            style: pw.TextStyle(fontSize: 12.5, fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(thickness: 0.5),
        ],
      ),
    );
  }

  // ================= EXPERIENCE =================

  static List<pw.Widget> _experience(List items) {
    return items.map<pw.Widget>((e) {
      final responsibilities = e['responsibilities'] as List? ?? [];

      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '${e['role'] ?? ''} - ${e['company'] ?? ''}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${e['start_year'] ?? ''} - ${e['end_year'] ?? ''}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 6),
            ..._bulletItems(responsibilities),
          ],
        ),
      );
    }).toList();
  }

  // ================= PROJECTS =================

  static List<pw.Widget> _projects(List items) {
    return items.map<pw.Widget>((p) {
      final highlights = p['highlights'] as List? ?? [];

      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  p['name'] ?? '',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${p['year'] ?? ''}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 4),
            pw.Text(p['context'] ?? ''),
            pw.SizedBox(height: 6),
            ..._bulletItems(highlights),
          ],
        ),
      );
    }).toList();
  }

  // ================= EDUCATION =================

  static List<pw.Widget> _education(List items) {
    return items.map<pw.Widget>((e) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 16),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              e['degree'] ?? '',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text(e['institution'] ?? ''),
            pw.SizedBox(height: 6),
            ..._bulletItems([e['achievement'] ?? '']),
          ],
        ),
      );
    }).toList();
  }

  // ================= SKILLS =================

  static List<pw.Widget> _skills(List items) {
    return items.map<pw.Widget>((s) {
      final list = List<String>.from(s['items'] as List? ?? []);

      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              s['category'] ?? '',
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(': '),
            pw.Expanded(
              child: pw.Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(
                  list.length,
                  (i) => pw.Text(
                    i == list.length - 1 ? '${list[i]}.' : '${list[i]},',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // ================= BULLET ITEMS (INLINE SAFE) =================

  static List<pw.Widget> _bulletItems(List items) {
    return items.map<pw.Widget>((t) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(left: 16, bottom: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 4,
              height: 4,
              margin: const pw.EdgeInsets.only(top: 6, right: 8),
              decoration: const pw.BoxDecoration(
                color: PdfColors.black,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Expanded(child: pw.Text(t?.toString() ?? '')),
          ],
        ),
      );
    }).toList();
  }
}
