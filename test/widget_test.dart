import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  test('Project JSON uses snake_case and excludes read-only fields', () {
    final project = Project.fromJson({
      'id': '1cef0382-446f-4b41-9fee-7cfd10b867ef',
      'title': 'Beresin.Id',
      'role': 'UI/UX Designer',
      'description': 'Desc',
      'tech_stack': 'Figma',
      'image_url': null,
      'star_count': 3,
      'is_starred': true,
      'starred_by_names': 'Alice',
    });
    expect(project.id, '1cef0382-446f-4b41-9fee-7cfd10b867ef');
    expect(project.role, 'UI/UX Designer');
    expect(project.techStack, 'Figma');
    expect(project.imageUrl, '');
    expect(project.starCount, 3);
    final json = project.toJson();
    expect(json.containsKey('id'), isFalse);
    expect(json.containsKey('star_count'), isFalse);
    expect(json['tech_stack'], 'Figma');
    expect(json['image_url'], '');
  });

  test('Experience JSON uses snake_case and excludes read-only fields', () {
    final experience = Experience.fromJson({
      'id': 'exp-uuid-1',
      'title': 'Teaching Assistant',
      'description': 'Assisted students with labs and grading.',
      'category': 'part-time',
      'thumbnail': null,
      'started_at': '2026-08-01T00:00:00Z',
      'ended_at': null,
      'is_ongoing': true,
      'star_count': 2,
      'is_starred': false,
      'starred_by_names': 'Bob',
    });
    expect(experience.id, 'exp-uuid-1');
    expect(experience.category, 'part-time');
    expect(experience.categoryLabel, 'Part-Time');
    expect(experience.thumbnail, '');
    expect(experience.endedAt, isNull);
    expect(experience.isOngoing, isTrue);
    expect(experience.starCount, 2);

    final json = experience.toJson();
    expect(json.containsKey('id'), isFalse);
    expect(json.containsKey('started_at'), isFalse);
    expect(json.containsKey('is_ongoing'), isFalse);
    expect(json.containsKey('star_count'), isFalse);
    expect(json['category'], 'part-time');
    expect(json['ended_at'], isNull);
  });

  test('ApiClient.getProjects parses list', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/api/v1/projects/');
      return http.Response(
        jsonEncode([
          {
            'id': '1',
            'title': 'Portfolio',
            'role': 'Developer',
            'description': 'Desc',
            'tech_stack': 'Django',
            'image_url': 'https://example.com/img.jpg',
            'star_count': 0,
            'is_starred': false,
            'starred_by_names': '',
          },
        ]),
        200,
      );
    });
    final api = ApiClient(client: client, baseUrl: 'http://test');
    final projects = await api.getProjects();
    expect(projects.single.title, 'Portfolio');
    expect(projects.single.role, 'Developer');
  });

  test('ApiClient.getExperiences and createExperience work', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/api/v1/experiences/');
      if (request.method == 'GET') {
        return http.Response(
          jsonEncode([
            {
              'id': 'e1',
              'title': 'Intern',
              'description': 'Software engineering internship.',
              'category': 'internship',
              'thumbnail': '',
              'started_at': '2026-06-01T00:00:00Z',
              'ended_at': null,
              'is_ongoing': true,
              'star_count': 1,
              'is_starred': false,
              'starred_by_names': '',
            },
          ]),
          200,
        );
      }
      expect(request.method, 'POST');
      expect(request.headers['Authorization'], 'Token secret-token');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body.containsKey('id'), isFalse);
      return http.Response(
        jsonEncode({
          'id': 'e2',
          'title': body['title'],
          'description': body['description'],
          'category': body['category'],
          'thumbnail': body['thumbnail'],
          'started_at': '2026-09-01T00:00:00Z',
          'ended_at': body['ended_at'],
          'is_ongoing': body['ended_at'] == null,
          'star_count': 0,
          'is_starred': false,
          'starred_by_names': '',
        }),
        201,
      );
    });

    final api = ApiClient(client: client, baseUrl: 'http://test');
    final list = await api.getExperiences();
    expect(list.single.title, 'Intern');
    expect(list.single.categoryLabel, 'Internship');

    final created = await api.createExperience(
      const Experience(
        title: 'Researcher',
        description: 'Conducted ML experiments in lab.',
        category: 'research',
      ),
      token: 'secret-token',
    );
    expect(created.id, 'e2');
    expect(created.categoryLabel, 'Research');
  });

  test('ApiClient throws ApiException on error', () async {
    final client = MockClient((_) async => http.Response('nope', 401));
    final api = ApiClient(client: client, baseUrl: 'http://test');
    expect(
      () => api.obtainToken('u', 'p'),
      throwsA(isA<ApiException>().having((e) => e.statusCode, 'code', 401)),
    );
  });

  testWidgets('Home page renders project and experience actions', (
    tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient(baseUrl: 'http://x')));
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Lihat Pengalaman'), findsOneWidget);
    expect(find.text('Tambah Pengalaman'), findsOneWidget);
  });
}
