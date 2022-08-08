import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/models/routineItem.dart';
import 'loginService.dart';

class RotuineItemSettingController extends GetxController {
  //TODO: 내가 만든 모든 루틴 항목을 읽어들일 수 있는 코드가 필요하다. where? 아마....
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<RoutineItem> customRoutineItems = [];
  

  @override
  void onInit(){
    getCustomRoutineItemNameList();
    super.onInit();
  }

  void getCustomRoutineItemNameList() async {
    //기존에 존재하던 items 받아오는 코드
    //내가 만든 루틴 항목만을 가져오는 코드이다.  
    await firestore
        .collection(
            'user/${Get.find<LoginService>().auth.value.currentUser!.uid}/userRoutineItems')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        customRoutineItems.add(RoutineItem(
          name: data['name'],
          description: data['description'],
          category: data['category'],
          docID: data[doc.id],
        )); 
      });
    });
    update();
  }

  void tapState(bool value, int index) {
    customRoutineItems[index].isTapped = value;
    update();
  }
}