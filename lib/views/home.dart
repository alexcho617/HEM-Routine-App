import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}






 // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     if (controller.uid.value == '') Text('uid empty'),
          //     if (controller.uid.value != '') Text(controller.uid.value),
          //     const SizedBox(height: 20.0),
          //     const SizedBox(height: 12.0),
          //     ElevatedButton(
          //       child: Text('Range Selection'),
          //       onPressed: () {
          //         Get.to(TableRangeExample());
          //       },
          //     ),
          //     const SizedBox(height: 12.0),
          //     ElevatedButton(
          //       child: Text('Complex'),
          //       onPressed: () {
          //         Get.to(TableComplexExample());
          //       },
          //     ),
          //     const SizedBox(height: 20.0),
          //   ],
          // ),