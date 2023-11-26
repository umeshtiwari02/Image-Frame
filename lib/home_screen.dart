import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_mask/widget_mask.dart';

File? _selectedImage;
int index = 0;
int newIndex = 2;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black38,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 30,
            color: Colors.black54,
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Image / Icon",
          style: TextStyle(
              color: Colors.black87,
              fontFamily: 'AppBar',
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black26)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Upload Image",
                        style: TextStyle(fontFamily: 'UploadB', fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _pickImageFromGallery();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const CustomDialogWidget();
                            });
                      },
                      child: Container(
                        height: 38,
                        width: 155,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 10, 125, 138),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          "Choose from Device",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ButtonText',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        )),
                      ),
                    )
                  ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                    height: 300,
                    width: 500,
                    child: _selectedImage != null
                        ? WidgetMask(
                            blendMode: BlendMode.srcATop,
                            childSaveLayer: true,
                            mask: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                            child: (newIndex == 0)
                                ? Image.file(_selectedImage!, fit: BoxFit.fill)
                                : (newIndex == 1)
                                    ? Image.asset('assets/love.png')
                                    : (newIndex == 2)
                                        ? Image.asset('assets/square.png')
                                        : (newIndex == 3)
                                            ? Image.asset('assets/circle.png')
                                            : (newIndex == 4)
                                                ? Image.asset(
                                                    'assets/rectangle.png')
                                                : Container(),
                          )
                        : Container()))
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: returnedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 10, ratioY: 10),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            cropFrameColor: Colors.white70,
            cropFrameStrokeWidth: 5,
            showCropGrid: true,
            toolbarTitle: '',
            toolbarColor: Colors.black87,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black54,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });
      }
    }
  }
}

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(25),
      actions: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(0)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImage == null;
                      index = -1;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Uploaded Image",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontFamily: 'UploadB',
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              SizedBox(
                child: SizedBox(
                    height: 200, width: 220, child: Center(child: frame())),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 72,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                          "Orignal",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'OrignalB',
                              fontWeight: FontWeight.w900),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: Container(
                          height: 45,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/love.png'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/square.png'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 3;
                        });
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/circle.png'),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 4;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/rectangle.png'),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    newIndex = index;
                    index = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  width: 270,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 10, 125, 138),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: Text(
                    "Use this image",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OrignalB',
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

frame() {
  return WidgetMask(
    blendMode: BlendMode.srcATop,
    childSaveLayer: true,
    mask: Image.file(
      _selectedImage!,
      fit: BoxFit.cover,
    ),
    child: (index == 0)
        ? Image.file(
            _selectedImage!,
            fit: BoxFit.fill,
          )
        : (index == 1)
            ? Image.asset('assets/love.png')
            : (index == 2)
                ? Image.asset('assets/square.png')
                : (index == 3)
                    ? Image.asset('assets/circle.png')
                    : (index == 4)
                        ? Image.asset('assets/rectangle.png')
                        : Container(),
  );
}
