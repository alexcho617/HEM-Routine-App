import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../widgets/widgets.dart';
import '../controllers/routine_on_controller.dart';

class WidgetTestPage extends StatefulWidget {
  const WidgetTestPage({Key? key}) : super(key: key);

  @override
  State<WidgetTestPage> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  
  
  @override
  Widget build(BuildContext context) {
    RoutineOnController routineItemController = Get.put(RoutineOnController());
    // RoutineOnController routineIController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Test')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('NextButtonBig'),
              Padding(
                padding: REdgeInsets.all(8),
                child: nextButtonBig(voidFunction),
              ),
              const Text('NextAndBackButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: nextAndBackButton(voidFunction, voidFunction),
              ),
              const Text('SaveButtonGray'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveButtonGray(voidFunction),
              ),
              const Text('SaveButtonBlue'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveButtonBlue(voidFunction),
              ),
              const Text('MakeMyRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: makeMyRoutineButton(voidFunction),
              ),
              const Text('AddButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: addButton(voidFunction),
              ),
              const Text('AddRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: addRoutineButton(voidFunction),
              ),
              const Text('PlusSquareButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: plusSquareButton(voidFunction),
              ),
              const Text('DeleteAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: deleteAlertDialog(voidFunction, voidFunction),
              ),
              const Text('SaveAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveAlertDialog(voidFunction),
              ),
              const Text('CircularGuage'),
              Padding(
                padding: REdgeInsets.all(8),
                child: Container(
                  height: 50,
                  child: circluarGuage(0.75),
                ),
              ),
              const Text('HalfCircularGuage'),
              Padding(
                padding: REdgeInsets.all(8),
                child: Container(
                  height: 240,
                  child: halfCircluarGuage(0.75),
                ),
              ),
              const Text('AcheiveAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: achieveAlertDialog('\$\ 사용자', voidFunction),
              ),
              const Text('RoutineStartAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: routineStartAlertDialog(voidFunction, voidFunction),
              ),
              // Text('AddRoutineItemList'),
              // Padding(
              //   padding: REdgeInsets.all(8),
              //   child: Container(
              //     height: 350,
              //     child: addRoutineItemList(routineEntityController),),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void voidFunction() {
    // void function for lint
  }
  dynamic dynamicFunction() {
    // dymanic function for lint
    return dynamic;
  }

  void testFuntion1() {
    print("Test Function 1 Called!");
  }

  void testFuntion2() {
    print("Test Function 2 Called!");
  }
}
