import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.passingSelectedImage});

  final void Function(File pickedImage) passingSelectedImage;

  @override
  State<ImagePickerWidget> createState() {
    return _ImagePickerWidget();
  }
}

class _ImagePickerWidget extends State<ImagePickerWidget> {
  
  var _isImagePicked = false;
  File? _pickedImageFile;

  void _pickImage() async {
    
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        {
          _pickedImageFile = File(pickedImage.path);
          _isImagePicked = true;
        }
      });

      widget.passingSelectedImage(_pickedImageFile!);
    } 
    
    else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        const SizedBox(height: 10,),
        
        if(_isImagePicked)
        CircleAvatar(
          radius: 50,
          backgroundImage: _isImagePicked
              ? FileImage(_pickedImageFile!)
              : Image.asset('assets/addphoto.png').image,
        ),
                
        FilledButton.icon(
            onPressed: _pickImage,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 106, 18, 229), // Replace with your desired color
              ),
            ),
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text(
              'Add Image',
              style: TextStyle(color: Color.fromARGB(255, 254, 254, 255)),
            )),
      ],
    );
  }
}
