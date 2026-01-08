import 'package:flutter/material.dart';
import '../repository/device_repository.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final DeviceRepository _repo = DeviceRepository();

  final TextEditingController uidController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController(
    text: '100',
  );

  bool _loading = false;

  // FORM VALIDITY CHECK

  bool get _canSubmit {
    final uid = uidController.text.trim();
    final name = nameController.text.trim();
    final level = int.tryParse(levelController.text.trim());

    return uid.isNotEmpty &&
        name.isNotEmpty &&
        level != null &&
        level >= 0 &&
        level <= 100;
  }

  // SAVE DEVICE

  Future<void> _save() async {
    if (_loading) return; // hard guard

    final uid = uidController.text.trim();
    final name = nameController.text.trim();
    final levelText = levelController.text.trim();

    // HARD VALIDATION (NO DB CALL)
    if (uid.isEmpty) {
      _showError('Device UID is required');
      return;
    }

    if (name.isEmpty) {
      _showError('Device name is required');
      return;
    }

    final level = int.tryParse(levelText);
    if (level == null || level < 0 || level > 100) {
      _showError('Starting quantity must be between 0 and 100');
      return;
    }

    setState(() => _loading = true);

    try {
      await _repo.addDevice(
        deviceUid: uid,
        deviceName: name,
        levelPercent: level,
      );

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    uidController.dispose();
    nameController.dispose();
    levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Device')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: uidController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(labelText: 'Device UID'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(labelText: 'Device Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: levelController,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Starting Quantity (%)',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: (_loading || !_canSubmit) ? null : _save,
              child: _loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
