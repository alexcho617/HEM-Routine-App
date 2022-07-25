import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompletedRoutinesPage extends StatefulWidget {
  const CompletedRoutinesPage({Key? key}) : super(key: key);

  @override
  State<CompletedRoutinesPage> createState() => _CompletedRoutinesPageState();
}

class _CompletedRoutinesPageState extends State<CompletedRoutinesPage> {
  List routineList = [];
  //List routineList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: routineList.length == 0 ?
      Column(
        children: [
          //
        ],
      )
      :
      Container()
      ,
    );
  }
}
