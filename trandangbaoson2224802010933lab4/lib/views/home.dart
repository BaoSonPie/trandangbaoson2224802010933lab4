import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final crud = CrudService();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6efea),
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: const Color(0xfff6efea),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() => search = value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📋 LIST
          Expanded(
            child: StreamBuilder(
              stream: crud.getContacts(searchQuery: search),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    var d = docs[i];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade200,
                        child: Text(
                          d['name'][0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(d['name']),
                      subtitle: Text(d['phone']),
                      trailing: const Icon(Icons.call),
                      onTap: () {
                        Navigator.pushNamed(context, "/update", arguments: d);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ➕ ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade200,
        onPressed: () => Navigator.pushNamed(context, "/add"),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
