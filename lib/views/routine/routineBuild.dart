import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class RoutineBuildPage extends StatefulWidget {
  const RoutineBuildPage({Key? key}) : super(key: key);

  @override
  State<RoutineBuildPage> createState() => _RoutineBuildPageState();
}

class _RoutineBuildPageState extends State<RoutineBuildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('루틴 설계'),
      ),
      body: SafeArea(
        child: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                
                decoration: InputDecoration(
                  hintText: '루틴 이름 입력(최대 20자)',
                  labelText: '루틴 이름'),
                onChanged: (text) {
                  // do something with text
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
