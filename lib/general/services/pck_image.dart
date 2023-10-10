import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:filesize/filesize.dart';

import 'custom_toast.dart';
import 'upload_firestore_image_services.dart';

Future<ImageModel?> customPickImg(double imagepx) async {
  Uint8List? bytesimage;
  try {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: imagepx, maxWidth: imagepx);

    if (pickedFile == null) return null;

    String? _selectedImageName = pickedFile.name;
    final imageBytes = await pickedFile.readAsBytes();
    bytesimage = Uint8List.fromList(imageBytes);

    final fileSizeInKB = bytesimage.lengthInBytes / 1024;
    if (fileSizeInKB.round() <= 200) {
      final getimgLink = await uploadFirestoreImageServices(bytesimage);
      return ImageModel(
        path: _selectedImageName.replaceFirst(RegExp(r'scaled_'), ''),
        image: getimgLink,
      );
    } else {
      CustomToast.errorToast(
          message:
              "this image size: ${filesize(bytesimage.lengthInBytes.toString())} / Max file size allowed is 200kb");
      return null;
    }
  } catch (e) {
    log("$e pick image error");
  }

  return null;
}

class ImageModel {
  String? path;
  String? image;

  ImageModel({this.path, this.image});
}
