import 'package:flutter/material.dart';
import '../repository/device_repository.dart';

class DeviceDetailsPage extends StatefulWidget {
  final String deviceId;

  const DeviceDetailsPage({super.key, required this.deviceId});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  final DeviceRepository _repo = DeviceRepository();

  late TextEditingController nameController;
  late TextEditingController currentLevelController;
  late TextEditingController reorderLevelController;
  late TextEditingController reorderQtyController;
  late TextEditingController medicineController;
  late TextEditingController pincodeController;
  late TextEditingController zoneController;
  late TextEditingController addressController;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadDevice();
  }

  void _initControllers() {
    nameController = TextEditingController();
    currentLevelController = TextEditingController();
    reorderLevelController = TextEditingController();
    reorderQtyController = TextEditingController();
    medicineController = TextEditingController();
    pincodeController = TextEditingController();
    zoneController = TextEditingController();
    addressController = TextEditingController();
  }

  Future<void> _loadDevice() async {
    try {
      final device = await _repo.getDeviceById(widget.deviceId);

      nameController.text = device['device_name'] ?? '';
      currentLevelController.text = (device['level_percent'] ?? 0).toString();
      reorderLevelController.text = (device['reorder_level'] ?? 30).toString();
      reorderQtyController.text = (device['reorder_quantity'] ?? 50).toString();
      medicineController.text = device['medicine_name'] ?? '';
      pincodeController.text = device['delivery_pincode'] ?? '';
      zoneController.text = device['delivery_zone'] ?? '';
      addressController.text = device['delivery_address'] ?? '';
    } catch (e) {
      _showError(e.toString());
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    final currentLevel = int.tryParse(currentLevelController.text);
    final reorderLevel = int.tryParse(reorderLevelController.text);
    final reorderQty = int.tryParse(reorderQtyController.text);

    if (currentLevel == null || currentLevel < 0 || currentLevel > 100) {
      _showError('Current level must be between 0 and 100');
      return;
    }

    if (reorderLevel == null || reorderLevel < 0 || reorderLevel > 100) {
      _showError('Reorder level must be between 0 and 100');
      return;
    }

    if (reorderQty == null || reorderQty <= 0) {
      _showError('Reorder quantity must be greater than 0');
      return;
    }

    setState(() => _loading = true);

    try {
      // Update device configuration
      await _repo.updateDevice(
        deviceId: widget.deviceId,
        deviceName: nameController.text.trim(),
        reorderLevel: reorderLevel,
        reorderQuantity: reorderQty,
        medicineName: medicineController.text.trim(),
        pincode: pincodeController.text.trim(),
        zone: zoneController.text.trim(),
        address: addressController.text.trim(),
      );

      // Update current level (moves tile bar)
      await _repo.updateLevel(
        deviceId: widget.deviceId,
        levelPercent: currentLevel,
      );

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Device'),
          content: const Text(
            'Are you sure you want to delete this device? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _delete();
    }
  }

  Future<void> _delete() async {
    setState(() => _loading = true);
    try {
      await _repo.deleteDevice(widget.deviceId);
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
    nameController.dispose();
    currentLevelController.dispose();
    reorderLevelController.dispose();
    reorderQtyController.dispose();
    medicineController.dispose();
    pincodeController.dispose();
    zoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Configuration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Device Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _inputField(label: 'Device Name', controller: nameController),
              const SizedBox(height: 16),
              _inputField(
                label: 'Current Level (%)',
                controller: currentLevelController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _inputField(
                label: 'Reorder Level (%)',
                controller: reorderLevelController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _inputField(
                label: 'Reorder Quantity',
                controller: reorderQtyController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              const Text(
                'Device Replenishment Configuration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _inputField(
                label: 'Medicine Name',
                controller: medicineController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _inputField(
                      label: 'Pincode',
                      controller: pincodeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _inputField(
                      label: 'Zone',
                      controller: zoneController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _inputField(
                label: 'Delivery Address',
                controller: addressController,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
