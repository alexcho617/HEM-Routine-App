import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hem_routine_app/models/routineItem.dart';
import 'loginService.dart';

class RotuineItemSettingController extends GetxController {
  //TODO: 내가 만든 모든 루틴 항목을 읽어들일 수 있는 코드가 필요하다. where? 아마....
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString filter = ''.obs;
  List<RoutineItem> customRoutineItems = [];
  List<String> categories = [
    '전체',
    '수분 섭취',
    '운동/생활습관',
    '음식/식습관',
    '마이크로바이옴 관리',
    '멘탈 케어',
    '영양제/약',
    '기타'
  ];

  @override
  void onInit() {
    filter.value = categories[0];
    getCustomRoutineItemNameList();
    super.onInit();
  }

  void getCustomRoutineItemNameList() async {
    //기존에 존재하던 items 받아오는 코드
    //내가 만든 루틴 항목만을 가져오는 코드이다.
    customRoutineItems.clear();
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
          docID: doc.id,
        ));
      });
    });
    update();

    customRoutineItems.sort(((a, b) => a.name.compareTo(b.name)));
  }

  void tapState(bool value, int index) {
    customRoutineItems[index].isTapped = value;
    update();
  }
}
