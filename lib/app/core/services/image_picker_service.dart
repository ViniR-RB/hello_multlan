import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hellomultlan/app/core/exceptions/image_picker_service_exception.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<File> getImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return File("");
    } on PlatformException catch (e, s) {
      const message = "Você deve conceder permissão para acessar a galeria";
      log("Erro de permissão do usuário", error: e, stackTrace: s);
      throw ImagePickerServiceException(message);
    }
  }
}
