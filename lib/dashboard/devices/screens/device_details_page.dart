import 'package:flutter/material.dart';

class DeviceDetailsPage extends StatefulWidget {
  final String deviceName;
  final int levelPercent;

  const DeviceDetailsPage({
    super.key,
    required this.deviceName,
    required this.levelPercent,
  });

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  late TextEditingController nameController;
  late TextEditingController reorderLevelController;
  late TextEditingController reorderQtyController;

  //  Replenishment controllers
  late TextEditingController medicineController;
  late TextEditingController pincodeController;
  late TextEditingController zoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.deviceName);
    reorderLevelController = TextEditingController(
      text: widget.levelPercent.toString(),
    );
    reorderQtyController = TextEditingController(text: "50");

    medicineController = TextEditingController(text: "Paracetamol");
    pincodeController = TextEditingController(text: "560001");
    zoneController = TextEditingController(text: "North Zone");
    addressController = TextEditingController(
      text: "123, Main Street, Near Medical Store",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
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
    return Scaffold(
      appBar: AppBar(title: const Text("Device Configuration")),

      ///  NO BOTTOM BAR HERE
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -------------------------
              /// DEVICE INFO SECTION
              /// -------------------------
              const Text(
                "Device Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              _inputField(label: "Device Name", controller: nameController),

              const SizedBox(height: 16),

              _inputField(
                label: "Reorder Level (%)",
                controller: reorderLevelController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              _inputField(
                label: "Reorder Quantity",
                controller: reorderQtyController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              /// -------------------------
              /// REPLENISHMENT SECTION
              /// -------------------------
              const Text(
                "Device Replenishment Configuration",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              _inputField(
                label: "Medicine Name",
                controller: medicineController,
              ),

              const SizedBox(height: 16),

              _inputField(
                label: "Quantity",
                controller: reorderQtyController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _inputField(
                      label: "Pincode",
                      controller: pincodeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _inputField(
                      label: "Zone",
                      controller: zoneController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _inputField(
                label: "Delivery Address",
                controller: addressController,
                maxLines: 3,
              ),

              const SizedBox(height: 32),

              /// -------------------------
              /// ACTION BUTTONS
              /// -------------------------
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        /// UI only – backend later
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
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

  /// Reusable input field
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
