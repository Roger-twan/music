import 'dart:io';
import 'package:flutter/material.dart';
import '../../provider/search_history.dart';
import '../_common/toast.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SearchHistory searchHistory = SearchHistory();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Platform.isIOS)
                SizedBox(height: MediaQuery.of(context).padding.top),
              const Text('Settings',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  )),
              const SizedBox(height: 20),
              Expanded(
                  child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {_showDialog(context)},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                            foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey[400]!),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey[900]!),
                          ),
                          child: const Text('Clear Cache'),
                        ),
                      ),
                    ],
                  )
                ],
              )),
              if (Platform.isIOS)
                SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ));
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear all cache below?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('- Search history'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Clear',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                searchHistory.clear();
                Navigator.of(context).pop();
                showToast(context, 'Successfully Cleared');
              },
            ),
          ],
        );
      },
    );
  }
}
