// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';
import 'package:hem_routine_app/views/report/report.dart';
import 'package:hem_routine_app/views/setting/settings.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

import '../controllers/routine_on_controller.dart';
import '../utils/colors.dart';
import 'routine/routine.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _pages = [
    Calendar(),
    RoutinePage(),
    ReportPage(),
    SettingsPage(),
  ];
  static List<GlobalKey<NavigatorState>> navigatorKeyList =
      List.generate(4, (index) => GlobalKey<NavigatorState>());
  static int currentIndex = 0;
  static late TabController tabController;
  @override
  void initState() {
    for (var page in _pages) {
      page.createElement();
    }
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await navigatorKeyList[currentIndex].currentState!.maybePop());
      },
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                return CustomNavigator(
                  page: page,
                  navigatorKey: navigatorKeyList[index],
                );
              },
            ).toList(),
          ),
        ),
        bottomNavigationBar: Container(
          color: Color.fromRGBO(238, 240, 255, 1),
          child: TabBar(
            controller: tabController,
            isScrollable: false,
            indicatorColor: Colors.transparent,
            indicatorPadding: const EdgeInsets.only(bottom: 74),
            // automaticIndicatorColorAdjustment: true,
            labelColor: grey900,
            unselectedLabelColor: grey600,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            tabs: const [
              Tab(
                icon: Icon(Icons.event),
                text: '캘린더',
              ),
              Tab(
                icon: Icon(Icons.tour),
                text: '루틴 도전',
              ),
              Tab(
                icon: Icon(Icons.description),
                text: '리포트',
              ),
              Tab(
                icon: Icon(Icons.settings_outlined),
                text: '설정',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
