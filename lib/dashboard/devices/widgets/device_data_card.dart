import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class DeviceDataCard extends StatelessWidget {
  final String deviceName;
  final String temperature;
  final String humidity;
  final String status;

  const DeviceDataCard({
    super.key,
    required this.deviceName,
    required this.temperature,
    required this.humidity,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                deviceName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text("Temp: $temperature"),
              Text("Humidity: $humidity"),
            ],
          ),

          Chip(
            label: Text(status),
            backgroundColor: status == "Online"
                ? AppTheme.accent.withOpacity(0.15)
                : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
