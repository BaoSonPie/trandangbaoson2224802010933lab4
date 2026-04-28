import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class UpdateContact extends StatelessWidget {
  UpdateContact({super.key});
  final crud = CrudService();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as dynamic;

    TextEditingController name = TextEditingController(text: data['name']);
    TextEditingController phone = TextEditingController(text: data['phone']);
    TextEditingController email = TextEditingController(text: data['email']);

    return Scaffold(
      backgroundColor: const Color(0xfff6efea),
      appBar: AppBar(
        title: const Text("Update Contact"),
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

            // UPDATE
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
                  await crud.updateContact(
                    name.text,
                    phone.text,
                    email.text,
                    data.id,
                  );
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ),

            const SizedBox(height: 10),

            // DELETE
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  await crud.deleteContact(data.id);
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
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
