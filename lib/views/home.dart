import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/controller/navigationController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    NavigationController nav = Get.find();

    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text("Home Page")),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '캘린더',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: '루틴 도전',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: '리포트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정',
            ),
          ],
          currentIndex: nav.selectedIndex.value,
          selectedItemColor: Colors.amber[800],
          onTap: nav.onItemTapped,
        ),
        body: Center(
          child: nav.widgetOptions.value.elementAt(nav.selectedIndex.value),
        ),
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