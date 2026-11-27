import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({this.popOnSuccess = false, super.key});

  final bool popOnSuccess;

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _category = 'full-time';
  String _thumbnail = '';
  DateTime? _endedAt;
  bool _isSubmitting = false;

  Future<void> _pickEndedDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endedAt = DateTime.utc(picked.year, picked.month, picked.day);
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Ongoing (belum dipilih)';
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String? _validateRequired(String? value, String label, {int minLength = 1}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (trimmed.length < minLength) {
      return '$label minimal $minLength karakter.';
    }
    return null;
  }

  String? _validateOptionalUrl(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final uri = Uri.tryParse(trimmed);
    final validScheme =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    if (!validScheme || uri.host.isEmpty || trimmed.contains(' ')) {
      return 'Masukkan URL valid (awali dengan http:// atau https://).';
    }
    return null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _title = '';
      _description = '';
      _category = 'full-time';
      _thumbnail = '';
      _endedAt = null;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final auth = context.read<AuthState>();
    final token = auth.token;
    if (token == null) return;

    final newExperience = Experience(
      title: _title.trim(),
      description: _description.trim(),
      category: _category,
      thumbnail: _thumbnail.trim(),
      endedAt: _endedAt,
    );

    setState(() {
      _isSubmitting = true;
    });
    try {
      final created = await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );
      if (!mounted) return;
      final goToList = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Experience berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Title: ${created.title}'),
                Text('Category: ${created.categoryLabel}'),
                Text('Description: ${created.description}'),
                Text(
                  'Thumbnail: '
                  '${created.thumbnail.isEmpty ? "-" : created.thumbnail}',
                ),
                Text('Ended at: ${_formatDate(created.endedAt)}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Tambah Lagi'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Lihat Daftar'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      if (goToList == true) {
        if (widget.popOnSuccess) {
          Navigator.pop(context, true);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ExperienceListScreen(),
            ),
          );
        }
      } else {
        _resetForm();
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await auth.logout();
        if (!mounted) return;
        _showSnackBar('Sesi berakhir. Silakan login kembali.');
        await ensureLoggedIn(context);
      } else {
        _showSnackBar('Gagal menyimpan experience (status ${e.statusCode}).');
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Gagal menyimpan experience: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Experience Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) =>
                      _validateRequired(value, 'Title', minLength: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) =>
                      _validateRequired(value, 'Description', minLength: 10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: Experience.categoryLabels.entries
                      .map(
                        (entry) => DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _category = newValue;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: 'URL Thumbnail (opsional)',
                    labelText: 'Thumbnail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _thumbnail = value,
                  validator: _validateOptionalUrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _pickEndedDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text('Ended at: ${_formatDate(_endedAt)}'),
                    ),
                    if (_endedAt != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _endedAt = null;
                          });
                        },
                        child: const Text('Clear'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
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
