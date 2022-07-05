import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/routineItem.dart';
import '../widgets/widgets.dart';
import '../controller/routineItemController.dart';

class WidgetTestPage extends StatefulWidget {
  const WidgetTestPage({Key? key}) : super(key: key);

  @override
  State<WidgetTestPage> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  @override
  Widget build(BuildContext context) {
    RoutineItemController routineItemController =
        Get.find();
    return Scaffold(
      appBar: AppBar(title: Text('Widget Test')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('NextButtonBig'),
              Padding(
                padding: REdgeInsets.all(8),
                child: NextButtonBig(voidFunction),
              ),
              Text('NextAndBackButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: NextAndBackButton(voidFunction, voidFunction),
              ),
              Text('SaveButtonGray'),
              Padding(
                padding: REdgeInsets.all(8),
                child: SaveButtonGray(voidFunction),
              ),
              Text('SaveButtonBlue'),
              Padding(
                padding: REdgeInsets.all(8),
                child: SaveButtonBlue(voidFunction),
              ),
              Text('MakeMyRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: MakeMyRoutineButton(voidFunction),
              ),
              Text('AddButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: AddButton(voidFunction),
              ),
              Text('AddRoutineButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: AddRoutineButton(voidFunction),
              ),
              Text('PlusSquareButton'),
              Padding(
                padding: REdgeInsets.all(8),
                child: PlusSquareButton(voidFunction),
              ),
              Text('DeleteAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: DeleteAlertDialog(voidFunction, voidFunction),
              ),
              Text('SaveAlertDialog'),
              Padding(
                padding: REdgeInsets.all(8),
                child: SaveAlertDialog(voidFunction),
              ),
              Padding(
                padding: REdgeInsets.all(8),
                child: RoutineItemList(routineItemController),
              ),
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
