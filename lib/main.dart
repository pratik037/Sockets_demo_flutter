import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketsapp/socketdemo.dart';
import 'package:socketsapp/utility.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<UtilityService>(
        create: (BuildContext context) {
          return UtilityService();
        },
        child: Consumer(
          builder: (BuildContext context, UtilityService utilService, _) {
            return SocketDemo(utilService: utilService,);
          },
        ),
      ),
      title: 'Chat Demo',
      debugShowCheckedModeBanner: false,
    );
  }
}
