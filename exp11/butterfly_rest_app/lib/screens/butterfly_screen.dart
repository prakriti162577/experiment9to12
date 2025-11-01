import 'package:flutter/material.dart';
import '../services/butterfly_service.dart';
import '../models/butterfly.dart';

class ButterflyScreen extends StatefulWidget {
  const ButterflyScreen({super.key});

  @override
  State<ButterflyScreen> createState() => _ButterflyScreenState();
}

class _ButterflyScreenState extends State<ButterflyScreen> {
  late Future<List<Butterfly>> futureButterflies;
  List<Butterfly> allButterflies = [];
  List<Butterfly> filteredButterflies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureButterflies = ButterflyService().fetchButterflies();
    futureButterflies.then((data) {
      setState(() {
        allButterflies = data;
        filteredButterflies = data;
      });
    });
  }

  void refreshButterflies() async {
    final data = await ButterflyService().fetchButterflies();
    setState(() {
      allButterflies = data;
      filteredButterflies = applySearch(data, searchQuery);
    });
  }

  List<Butterfly> applySearch(List<Butterfly> list, String query) {
    return list
        .where((b) => b.scientificName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredButterflies = applySearch(allButterflies, query);
    });
  }

  void deleteButterfly(int index) {
    setState(() {
      filteredButterflies.removeAt(index);
    });
  }

  void updateButterfly(int index) {
    final butterfly = filteredButterflies[index];
    final controllerName = TextEditingController(text: butterfly.scientificName);
    final controllerRank = TextEditingController(text: butterfly.rank);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update the flower'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controllerName, decoration: const InputDecoration(labelText: 'Scientific Name')),
            TextField(controller: controllerRank, decoration: const InputDecoration(labelText: 'Rank')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filteredButterflies[index] = Butterfly(
                  scientificName: controllerName.text,
                  rank: controllerRank.text,
                  imageUrl: butterfly.imageUrl,
                );
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flower Species')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: updateSearch,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => refreshButterflies(),
              child: ListView.builder(
                itemCount: filteredButterflies.length,
                itemBuilder: (context, index) {
                  final butterfly = filteredButterflies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      leading: butterfly.imageUrl.isNotEmpty
                          ? Image.network(
                        butterfly.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                      )
                          : const Icon(Icons.image_not_supported),
                      title: Text(butterfly.scientificName),
                      subtitle: Text('Rank: ${butterfly.rank}'),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => updateButterfly(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteButterfly(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}