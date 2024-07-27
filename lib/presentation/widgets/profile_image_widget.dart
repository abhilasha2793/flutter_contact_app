import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Function(String) onImageUpdate;
  bool imageUpdate=false ;

  ProfileImageWidget({
    super.key,
    required this.imageUrl,
    required this.onImageUpdate,
    required this.imageUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _getImageProvider(),
          child: imageUrl == null
              ? const Icon(
                  Icons.person,
                  size: 50,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: ()=>_showImageSourceDialog(context),
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  (imageUpdate || imageUrl!=null) ? Icons.edit : Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                )),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      onImageUpdate(pickedFile.path);
    }
  }

  ImageProvider<Object> _getImageProvider() {
    if (imageUrl == null) {
      return const AssetImage('assets/default_avatar.png');
    } else if (Uri.parse(imageUrl!).isAbsolute) {
      return NetworkImage(imageUrl!);
    } else {
      return FileImage(File(imageUrl!));
    }
  }

}


