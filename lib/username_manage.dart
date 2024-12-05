import 'package:flutter/material.dart';
import 'package:flutter_application_sf/user_name_notifier.dart';
import 'package:provider/provider.dart';


class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameNotifier = context.watch<UsernameNotifier>();
    final usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Usernames'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Add a Username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final username = usernameController.text;
              if (username.isNotEmpty) {
                usernameNotifier.addUsername(username);
                usernameController.clear();
              }
            },
            child: const Text('Add Username'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: usernameNotifier.usernames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usernameNotifier.usernames[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          usernameController.text =
                              usernameNotifier.usernames[index];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Edit Username'),
                                content: TextField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Username'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      usernameNotifier.editUsername(
                                          index, usernameController.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => usernameNotifier.deleteUsername(index),
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
