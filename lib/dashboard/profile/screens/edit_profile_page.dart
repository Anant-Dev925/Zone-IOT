import 'package:flutter/material.dart';
import '../repository/profile_repository.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile['name'] ?? '');
    surnameController = TextEditingController(
      text: widget.profile['surname'] ?? '',
    );
    addressController = TextEditingController(
      text: widget.profile['address'] ?? '',
    );
    phoneController = TextEditingController(
      text: widget.profile['phone'] ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field("Name", nameController),
            _field("Surname", surnameController),
            _field("Address", addressController),
            _field("Phone", phoneController),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : _save,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => loading = true);
    try {
      final repo = ProfileRepository();
      await repo.updateProfile(
        name: nameController.text.trim(),
        surname: surnameController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
      );

      Navigator.pop(context, true); // success
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => loading = false);
    }
  }
}
