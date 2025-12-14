import 'package:flutter/material.dart';
import '../widgets/device_container_tile.dart';
import 'device_details_page.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  final devices = const [
    ("Device 1", 60),
    ("Device 2", 40),
    ("Device 3", 75),
    ("Device 4", 20),
    ("Device 5", 55),
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController deviceIdController = TextEditingController();

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Your Devices",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: devices.length + 1,
              itemBuilder: (context, index) {
                /// -------------------------
                /// ADD NEW DEVICE TILE
                /// -------------------------
                if (index == devices.length) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Add New Device",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  TextField(
                                    controller: deviceIdController,
                                    decoration: const InputDecoration(
                                      labelText: "Enter Device ID",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            deviceIdController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            final deviceId = deviceIdController
                                                .text
                                                .trim();

                                            deviceIdController.clear();
                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Device ID $deviceId added (mock)",
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black26, width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black12,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_circle_outline,
                            size: 56,
                            color: Colors.black54,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Add New Device",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                /// -------------------------
                /// NORMAL DEVICE TILE
                /// -------------------------
                final device = devices[index];
                return DeviceContainerTile(
                  deviceName: device.$1,
                  levelPercent: device.$2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeviceDetailsPage(
                          deviceName: device.$1,
                          levelPercent: device.$2,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
