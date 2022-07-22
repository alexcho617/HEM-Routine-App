import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../widgets/widgets.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('프로필 설정'),
      ),
      body: Form(
        key : _formKey,
        child: Column(
          children: <Widget>[
            Text('프로필 이름'),
            TextFormField(),
            Text('성별'),
            //GenderChooseButtons
            Text('생년월'),
            //flutter_picker something here
            saveButtonBlue(onPressed),
          ],
        ),
      )
    );
  }
}

void onPressed(){
  //
}