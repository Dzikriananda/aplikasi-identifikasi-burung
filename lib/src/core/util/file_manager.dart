
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<void> deleteDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = Directory(pdfDirectory);
    await myDir.delete(recursive: true);
    // print('daftar isi : ${_folders[2]}');
    // _folders.forEach((FileSystemEntity entity) {
    //   if (entity is File) {
    //     entity.lengthSync();
    //   }
    // });
  }

  Future<void> getDirContent() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final myDir = Directory(dir);
    _folders = myDir.listSync(recursive: true, followLinks: false);
    var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
    _folders.forEach((element) {
      print('${element.path} : ${element.statSync().size * 0.000001}');
    });

    // print('daftar isi : ${_folders[2]}');
    // _folders.forEach((FileSystemEntity entity) {
    //   if (entity is File) {
    //     entity.lengthSync();
    //   }
    // });
  }

  Future<void> getDir() async {
    List<FileSystemEntity>? _folders;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    _folders = myDir.listSync(recursive: true, followLinks: false);
    var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
    print('isi folder $_folders');

    // print('daftar isi : ${_folders[2]}');
    // _folders.forEach((FileSystemEntity entity) {
    //   if (entity is File) {
    //     entity.lengthSync();
    //   }
    // });
  }

  // Future<void> getDir() async {
  //   List<FileSystemEntity>? _folders;
  //   final directory = await getApplicationDocumentsDirectory();
  //   final dir = directory.path;
  //   String pdfDirectory = '$dir';
  //   final myDir = new Directory(pdfDirectory);
  //   _folders = myDir.listSync(recursive: true, followLinks: false);
  //   var dirSize = _folders.fold(0, (int sum, file) => sum + file.statSync().size);
  //   print('isi folder $_folders');
  //
  //   // print('daftar isi : ${_folders[2]}');
  //   // _folders.forEach((FileSystemEntity entity) {
  //   //   if (entity is File) {
  //   //     entity.lengthSync();
  //   //   }
  //   // });
  // }

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
    print('daftar isi : $_folders');
  }

}