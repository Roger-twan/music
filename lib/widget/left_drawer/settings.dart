import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/preferences.dart';
import '../_common/toast.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FocusNode cacheFieldFocus = FocusNode();
  final TextEditingController cacheFieldController = TextEditingController();
  final SharedPreferences? preferences = Preferences().get();
  late String originalCacheAmount;

  setOriginalCacheAmount(String value) {
    setState(() {
      originalCacheAmount = value;
    });
  }

  @override
  void initState() {
    super.initState();

    double? cacheAmount = preferences?.getDouble('cacheAmount');
    setOriginalCacheAmount(cacheAmount.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), ''));
    cacheFieldController.text = originalCacheAmount;

    cacheFieldFocus.addListener(() async => {
      if (!cacheFieldFocus.hasFocus) {
        await setCacheAmount(cacheFieldController.text)
      }
    });
  }

  Future<void> setCacheAmount(String value) async {
    if (value.isEmpty) {
      cacheFieldController.text = originalCacheAmount;
      return;
    }

    double amount = double.parse(value);

    if (amount != preferences?.getDouble('cacheAmount')) {
      await preferences?.setDouble('cacheAmount', amount);
      setOriginalCacheAmount(value);
      if (mounted) {
        showToast(context, 'Successfully Saved');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Max Cache:'),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: TextField(
                      focusNode: cacheFieldFocus,
                      controller: cacheFieldController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      maxLength: 3,
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                      ],
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        filled: true,
                      ),
                      // onSubmitted: (value) async => {
                      //   await setCacheAmount(value)
                      // },
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('GB'),
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => {_showMyDialog(context)},
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
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Clear all cache?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('There are 523 MB in cache.'),
              Text('Once deleted, they would not be retrieved!'),
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
              Navigator.of(context).pop();
              showToast(context, 'Successfully Cleared');
            },
          ),
        ],
      );
    },
  );
}
