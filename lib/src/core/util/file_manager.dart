
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class FileManager {
  Future<void> deleteDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/cache';
    try {
      final myDir = Directory(pdfDirectory);
      await myDir.delete(recursive: true);
    } on FileSystemException catch(e) {

    }
  }

  Future<Map<String,String>> readJson(String path) async {
    String data = await rootBundle.loadString(path);
    final jsonResult = jsonDecode(data);
    Map<String,String> idJson = Map<String,String>.from(jsonResult);
    return idJson;
  }

  Future<Uint8List> compressImage(Uint8List list,int imageCompressionLevel) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      quality: imageCompressionLevel,
    );
    return result;
  }

  //require higher ram
  Future<Uint8List> compressImageWithImageLib(Uint8List list) async {
    Im.Image? image = Im.decodeJpg(list);
    Im.Image smallerImage = Im.copyResize(image!,width: 500,height: 500);
    return Im.encodeJpg(smallerImage, quality: 90);
  }



  bool checkIfFileExist(String path) {
    final myDir = Directory(path);
    return myDir.existsSync();
  }

  Future<void> getDirContent() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final myDir = Directory(dir);
    _folders = myDir.listSync(recursive: true, followLinks: false);
    _folders.forEach((FileSystemEntity entity) {
      if (entity is File) {
        var size = entity.lengthSync();
        print('${entity.path} : ${size * 0.000001}');
      }
    });
  }

  Future<double> getImageCacheSize() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    try {
      final myDir = Directory(dir+'/cache');
      _folders = myDir.listSync(recursive: true, followLinks: false);
      _folders.forEach((FileSystemEntity entity) {
        if (entity is File) {
          var size = entity.lengthSync();
          // print('${entity.path} : ${size * 0.000001}');
        }
      });
      var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
      return dirSize * 0.000001;
    } on PathNotFoundException catch(e) {
      return 0;
    }

  }

  Future<String> saveImage(Uint8List imageBytes, String fileName, boxType type,int? imageCompressionLevel) async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String folderType = (type == boxType.speciesList) ? 'specieslist' : 'history';
    String folderDirectory = dir + '/cache/' + folderType;
    String imageDirectory = folderDirectory + '/$fileName.jpg';
    Directory(folderDirectory).createSync(recursive: true);
    // double imageSize = imageBytes.lengthInBytes * 0.000001;

    // if imagesize if larger than 4 Mb then its must be compressed in order to save space
    // if (imageSize > 4.0) {
    //   imageBytes = await compressImage(imageBytes,imageCompressionLevel);
    // }
    if(imageCompressionLevel != null && imageCompressionLevel > 0) {
      imageBytes = await compressImage(imageBytes,imageCompressionLevel);
    }


    File image = File(imageDirectory);
    await image.writeAsBytes(imageBytes);
    return image.path;
  }

  Future<void> getDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    _folders = myDir.listSync(recursive: true, followLinks: false);
    var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
  }

  Future<void> createDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }
    _folders = myDir.listSync(recursive: true, followLinks: false);
  }
}