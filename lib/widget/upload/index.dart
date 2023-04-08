import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../_common/input_decoration.dart';

class UploadDrawer extends StatefulWidget {
  const UploadDrawer({super.key});

  @override
  State<UploadDrawer> createState() => _UploadDrawerState();
}

class _UploadDrawerState extends State<UploadDrawer> {
  PlatformFile? pickedFile;
  bool isPickingFile = false;
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController artistFieldController = TextEditingController();

  void setPickedFile(PlatformFile file) {
    setState(() {
      pickedFile = file;
    });
  }

  void setIsPickingFile(bool value) {
    setState(() {
      isPickingFile = value;
    });
  }

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
              const Text('Upload',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  )),
              const SizedBox(height: 20),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: MouseRegion(
                            cursor: MaterialStateMouseCursor.clickable,
                            child: GestureDetector(
                              onTap: () {
                                if (isPickingFile == false) {
                                  setIsPickingFile(true);
                                  _pickFile();
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 0)),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 10),
                                    child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          pickedFile == null
                                              ? const Text(
                                                  'Tap here to pick file')
                                              : Text(pickedFile!.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  )),
                                        ]),
                                  ),
                                  isPickingFile
                                      ? Positioned(
                                          top: 0,
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                CircularProgressIndicator(
                                                    color: Colors.grey),
                                              ],
                                            ),
                                          ))
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameFieldController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              cursorColor: Colors.white,
                              decoration: commonInputDecoration('Name'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: artistFieldController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              cursorColor: Colors.white,
                              decoration: commonInputDecoration('Artist'),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {},
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
                          child: const Text('Upload'),
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ));
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp3']);

    if (result != null) {
      PlatformFile file = result.files.single;
      setPickedFile(file);
      final fileNames = file.name.replaceAll('.mp3', '').split('-');

      if (fileNames.length == 2) {
        artistFieldController.text = fileNames[0].trim();
        nameFieldController.text = fileNames[1].trim();
      } else {
        nameFieldController.text = fileNames[0].trim();
      }

      // print(file.size);
      // print(file.path);
    }

    setIsPickingFile(false);
  }
}
