import 'package:flutter/material.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

class WidgetTestPage extends StatefulWidget {
  const WidgetTestPage({Key? key}) : super(key: key);

  @override
  State<WidgetTestPage> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widget Test')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NextButtonBig(voidFunction),
            ),
          ],
        ),
      ),
    );
  }


  void voidFunction() {
    // void function for lint
  }
}
