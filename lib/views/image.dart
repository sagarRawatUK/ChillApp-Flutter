import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:ChillApp/views/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_admob/firebase_admob.dart';

// const String testDevice = "903E479CD6FCD1AC0B72CE2432EFDE75";

class ImagePath extends StatefulWidget {
  final String imgPath;
  ImagePath(this.imgPath);
  @override
  _ImagePathState createState() => _ImagePathState();
}

class _ImagePathState extends State<ImagePath> {
  String localPath;

  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   nonPersonalizedAds: true,
  //   keywords: ["website", "games"],
  // );

  // BannerAd bannerAd;
  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       adUnitId: "ca-app-pub-2177513958013552/3475621719",
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd $event");
  //       });
  // }

  @override
  void initState() {
    // FirebaseAdMob.instance
    //     .initialize(appId: "ca-app-pub-2177513958013552~9937605202");
    // bannerAd = createBannerAd()
    //   ..load()
    //   ..show(anchorType: AnchorType.bottom);
    super.initState();
  }

  // @override
  // void dispose() {
  //   bannerAd?.dispose();
  //   super.dispose();
  // }

  Future<String> get localpath async {
    final result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      final localPath =
          (await findLocalPath()) + Platform.pathSeparator + 'Download';
      final savedDir = Directory(localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      return localPath;
    } else
      return null;
  }

  Future<String> findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
        actions: [
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.file_download),
              onPressed: () async => DownloadTask(
                  taskId: await FlutterDownloader.enqueue(
                      url: widget.imgPath,
                      savedDir: await localpath,
                      showNotification: true,
                      openFileFromNotification: true)))
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Hero(
                    tag: widget.imgPath, child: Image.network(widget.imgPath)),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: bgColor,
    );
  }
}
