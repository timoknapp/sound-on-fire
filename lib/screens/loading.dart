import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sound_on_fire/screens/home.dart';
import 'package:sound_on_fire/util/constants.dart';
import 'package:sound_on_fire/services/soundcloud.dart' as soundcloudService;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String clientId;

  @override
  void initState() {
    _getClientId();
    super.initState();
  }

  void _getClientId() async {
    String id = await soundcloudService.getClientId();
    setState(() {
      clientId = id;
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        clientId: clientId,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: primaryOrange,
            size: 100.0,
          ),
        ));
  }
}