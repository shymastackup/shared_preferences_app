import 'package:flutter/material.dart';
import 'package:pro_shered_preference/pro_shered_preference.dart';


class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  List<String> _usernames = [];
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsernames();
  }

  Future<void> _loadUsernames() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernames = prefs.getStringList('usernames') ?? [];
    });
  }

  Future<void> _saveUsernames() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('usernames', _usernames);
  }

  void _addUsername() {
    if (_usernameController.text.isNotEmpty) {
      setState(() {
        _usernames.add(_usernameController.text);
      });
      _usernameController.clear();
      _saveUsernames();
    }
  }

  void _editUsername(int index) {
    _usernameController.text = _usernames[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
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
                  _usernames[index] = _usernameController.text;
                });
                _usernameController.clear();
                _saveUsernames();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUsername(int index) {
    setState(() {
      _usernames.removeAt(index);
    });
    _saveUsernames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Usernames')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Add a Username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addUsername,
            child: const Text('Add Username'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _usernames.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_usernames[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editUsername(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteUsername(index),
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
