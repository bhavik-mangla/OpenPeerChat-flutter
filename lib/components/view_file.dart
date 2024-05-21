import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';


//ignore: must_be_immutable
class FilePreview {

  static Future<void> openFile(String path) async {
    if (Platform.isIOS) {
      _openIOSFile(path);
    } else if (Platform.isAndroid) {
      if (path.contains("Android/data")) {
        _openAndroidPrivateFile(path);
      } else if (path.contains("DCIM")) {
        if (path.contains(".jpg")) {
          _openAndroidExternalImage(path);
        } else if (path.contains(".mp4")) {
          _openAndroidExternalVideo(path);
        } else if (path.contains(".mp3")) {
          _openAndroidExternalAudio(path);
        } else {
          _openAndroidExternalFile(path);
        }
      } else {
        _openAndroidOtherAppFile(path);
      }
    }
  }

  // ignore: unused_element
  static _openIOSFile(String path) async {
   await OpenFilex.open( path);

  }

  // ignore: unused_element
  static _openAndroidPrivateFile( String path) async {
    //open an app private storage file
    await OpenFilex.open( path);


  }
  static _openAndroidOtherAppFile(String path) async {
    //open an external storage image file on android 13
    if (await Permission.manageExternalStorage.request().isGranted) {
       await OpenFilex.open(path);

    }
  }

  // ignore: unused_element
  static  _openAndroidExternalImage(String path) async {
    //open an external storage image file on android 13
    if (await Permission.photos.request().isGranted) {
       await OpenFilex.open(path);

    }
  }

  // ignore: unused_element
  static  _openAndroidExternalVideo(String path) async {
    //open an external storage video file on android 13
    if (await Permission.videos.request().isGranted) {
      await OpenFilex.open(path);

    }
  }

  // ignore: unused_element
  static   _openAndroidExternalAudio(String path) async {
    //open an external storage audio file on android 13
    if (await Permission.audio.request().isGranted) {
await OpenFilex.open(path);

    }
  }

  // ignore: unused_element
  static _openAndroidExternalFile(String path) async {
    //open an external storage file
    if (await Permission.manageExternalStorage.request().isGranted) {
      await OpenFilex.open(path);

    }
  }
}