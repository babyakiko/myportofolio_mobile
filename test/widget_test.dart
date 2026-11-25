import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
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

  test('ApiClient throws ApiException on error', () async {
    final client = MockClient((_) async => http.Response('nope', 401));
    final api = ApiClient(client: client, baseUrl: 'http://test');
    expect(
      () => api.obtainToken('u', 'p'),
      throwsA(isA<ApiException>().having((e) => e.statusCode, 'code', 401)),
    );
  });

  testWidgets('Home page renders', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient(baseUrl: 'http://x')));
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
  });
}
