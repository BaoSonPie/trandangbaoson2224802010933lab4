import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class AddContact extends StatelessWidget {
  AddContact({super.key});

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final crud = CrudService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6efea),
      appBar: AppBar(
        title: const Text("Add Contact"),
        backgroundColor: const Color(0xfff6efea),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(name, "Name"),
            const SizedBox(height: 10),
            _input(phone, "Phone"),
            const SizedBox(height: 10),
            _input(email, "Email"),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  await crud.addNewContacts(name.text, phone.text, email.text);
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
