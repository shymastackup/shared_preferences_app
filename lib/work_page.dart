import 'package:flutter/material.dart';
import 'package:pro_shered_preference/pro_shered_preference.dart';


class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  List<String> _workItems = [];
  final TextEditingController _workController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWorkItems();
  }

  Future<void> _loadWorkItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _workItems = prefs.getStringList('workItems') ?? [];
    });
  }

  Future<void> _saveWorkItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('workItems', _workItems);
  }

  void _addWork() {
    if (_workController.text.isNotEmpty) {
      setState(() {
        _workItems.add(_workController.text);
      });
      _workController.clear();
      _saveWorkItems();
    }
  }

  void _editWork(int index) {
    _workController.text = _workItems[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Work Item'),
          content: TextField(
            controller: _workController,
            decoration: const InputDecoration(labelText: 'Work Item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _workItems[index] = _workController.text;
                });
                _workController.clear();
                _saveWorkItems();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteWork(int index) {
    setState(() {
      _workItems.removeAt(index);
    });
    _saveWorkItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Work')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _workController,
              decoration: const InputDecoration(
                labelText: 'Add a Work Item',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addWork,
            child: const Text('Add Work'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _workItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_workItems[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editWork(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteWork(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
