import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:sound_on_fire/screens/home.dart';
import 'package:sound_on_fire/util/constants.dart';
import 'package:sound_on_fire/services/soundcloud.dart' as soundcloudService;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String clientId;
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  @override
  void initState() {
    _getPackageInfo();
    _getClientId();
    super.initState();
  }

  void _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  void _getClientId() async {
    String id = await soundcloudService.getClientId();
    setState(() {
      clientId = id;
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        clientId: clientId,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SpinKitDoubleBounce(
                  color: primaryOrange,
                  size: 100.0,
                ),
              ),
              Text("v${_packageInfo.version}+${_packageInfo.buildNumber}"),
            ],
          ),
        ));
  }
}