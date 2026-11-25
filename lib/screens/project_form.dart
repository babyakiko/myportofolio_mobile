import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _role = '';
  String _description = '';
  String _techStack = '';
  String _imageUrl = '';
  bool _isSubmitting = false;

  static bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final auth = context.read<AuthState>();
    final token = auth.token;
    if (token == null) return;

    final newProject = Project(
      title: _title.trim(),
      role: _role.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      imageUrl: _imageUrl.trim(),
    );

    setState(() {
      _isSubmitting = true;
    });
    try {
      final created = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Title: ${created.title}'),
                Text('Role: ${created.role}'),
                Text('Description: ${created.description}'),
                Text('Tech Stack: ${created.techStack}'),
                if (created.imageUrl.isNotEmpty)
                  Text('Image URL: ${created.imageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      _formKey.currentState?.reset();
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await auth.logout();
        if (!mounted) return;
        _showSnackBar('Sesi berakhir. Silakan login kembali.');
        await ensureLoggedIn(context);
      } else {
        _showSnackBar('Gagal menyimpan proyek (status ${e.statusCode}).');
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Gagal menyimpan proyek: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      hintText: hint ?? label,
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: _decoration('Title'),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: _decoration(
                    'Role',
                    hint: 'Contoh: UI/UX Designer, Backend Developer',
                  ),
                  onChanged: (value) => _role = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Role tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: _decoration('Description'),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: _decoration(
                    'Tech Stack',
                    hint: 'Contoh: Flutter, Django, Figma',
                  ),
                  onChanged: (value) => _techStack = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tech stack tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'Image URL (Optional)',
                    hint: 'https://example.com/image.png',
                  ),
                  onChanged: (value) => _imageUrl = value,
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        !_isValidUrl(value)) {
                      return 'Masukkan URL gambar yang valid (http/https)!';
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
