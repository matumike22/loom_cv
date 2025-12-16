import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';

class CvAiService {
  CvAiService._();

  static final GenerativeModel _model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  /// Main entry point
  /// Throws if AI returns unusable output
  static Future<Map<String, dynamic>> generateCv({
    required Map<String, dynamic> userInfo,
    required String cvInfo,
    required String jobDescription,
    String? additionalInfo,
  }) async {
    final prompt = _buildPrompt(
      userInfo: userInfo,
      cvInfo: cvInfo,
      jobDescription: jobDescription,
      additionalInfo: additionalInfo,
    );

    final response = await _model.generateContent([Content.text(prompt)]);

    final rawText = response.text ?? '';

    final sanitizedJson = _sanitizeJson(rawText);

    return sanitizedJson;
  }

  /// Prompt builder
  static String _buildPrompt({
    required Map<String, dynamic> userInfo,
    required String cvInfo,
    required String jobDescription,
    String? additionalInfo,
  }) {
    return '''
You are an expert technical recruiter and ATS optimization engine.

Task:
Generate a professional CV tailored specifically to the given job description.

INPUT:

Candidate information:
${jsonEncode({...userInfo, 'cv_data': cvInfo, if (additionalInfo != null) 'additional_info': additionalInfo})}

Target job description:
${jsonEncode({'job_description': jobDescription})}

RULES:
- Tailor the CV to the job description
- Optimize wording for ATS systems
- Use keywords ONLY if supported by the candidate data
- Do NOT invent experience
- Do NOT exaggerate seniority
- Keep content concise and professional
- Output ONLY valid JSON
- No markdown
- No explanations

OUTPUT FORMAT (must match exactly):

{
  "personal_info": {
    "name": "",
    "email": "",
    "telephone": ""
  },
  "summary": "",
  "skills": [],
  "experience": [
    {
      "title": "",
      "company": "",
      "start_date": "",
      "end_date": "",
      "description": ""
    }
  ],
  "projects": [
    {
      "name": "",
      "description": ""
    }
  ],
  "education": [
    {
      "degree": "",
      "institution": "",
      "year": ""
    }
  ]
}
''';
  }

  /// Hard JSON sanitizer
  /// - Strips junk text
  /// - Extracts first valid JSON object

  static Map<String, dynamic> _sanitizeJson(String input) {
    try {
      // Remove code blocks, markdown, etc.
      final cleaned = input
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final start = cleaned.indexOf('{');
      final end = cleaned.lastIndexOf('}');

      if (start == -1 || end == -1) {
        throw const FormatException('No JSON object found');
      }

      final jsonString = cleaned.substring(start, end + 1);

      final decoded = jsonDecode(jsonString);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Invalid JSON structure');
      }

      return decoded;
    } catch (e) {
      throw Exception('AI returned invalid JSON: $e');
    }
  }
}
