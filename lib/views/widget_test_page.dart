import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';
import '../models/routine_item.dart';
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
      appBar: AppBar(title: Text('Widget Test')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('NextButtonBig'),
              Padding(
                padding: REdgeInsets.all(8),
                child: nextButtonBig(voidFunction),
              ),
              Text('NextAndBackButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: nextAndBackButton(voidFunction, voidFunction),
              ),
              Text('SaveButtonGray'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveButtonGray(voidFunction),
              ),
              Text('SaveButtonBlue'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveButtonBlue(voidFunction),
              ),
              Text('MakeMyRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: makeMyRoutineButton(voidFunction),
              ),
              Text('AddButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: addButton(voidFunction),
              ),
              Text('AddRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: addRoutineButton(voidFunction),
              ),
              Text('PlusSquareButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: plusSquareButton(voidFunction),
              ),
              Text('DeleteAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: deleteAlertDialog(voidFunction, voidFunction),
              ),
              Text('SaveAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: saveAlertDialog(voidFunction),
              ),
              Text('CircularGuage'),
              Padding(
                padding: REdgeInsets.all(8),
                child: Container(
                  height: 50,
                  child: circluarGuage(0.75),
                ),
              ),
              Text('HalfCircularGuage'),
              Padding(
                padding: REdgeInsets.all(8),
                child: Container(
                  height: 240,
                  child: halfCircluarGuage(0.75),
                ),
              ),
              Text('AcheiveAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: achieveAlertDialog('\$\ 사용자', voidFunction),
              ),
              Text('RoutineStartAlertDialog'),
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
