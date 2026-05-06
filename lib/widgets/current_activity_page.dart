import 'package:flutter/material.dart';
import 'package:mystudynestflutter/dashboard_elementary.dart';
class LearningMaterialsPage extends StatelessWidget {
  LearningMaterialsPage({super.key});

  final List<Map<String, String>> materials = [
    {'title': 'Math Guide', 'type': 'PDF'},
    {'title': 'Science Slides', 'type': 'PPT'},
    {'title': 'English Notes', 'type': 'PDF'},
    {'title': 'Geometry', 'type': 'Image'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FB),

      // ✅ UPDATED APPBAR WITH BACK BUTTON
      appBar: AppBar(
        title: const Text('Learning Materials'),
        backgroundColor: Colors.blue,
        foregroundColor: const Color(0xFF1E2A44),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardElementary(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
          itemCount: materials.length,
          itemBuilder: (context, index) {
            final material = materials[index];
            return Card(
              child: InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening ${material['title']}'))),
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, size: 50, color: Color(0xFF3B82F6)),
                      const SizedBox(height: 12),
                      Text(material['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(material['type']!, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}