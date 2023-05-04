import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  late String appName;
  late String version;

  @override
  void initState() {
    super.initState();

    _getInfo();
  }

  void _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: const Image(
        image: AssetImage('lib/assets/logo.png'),
        width: 40,
        height: 40,
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appName),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Version: $version'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
