import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hem_routine_app/views/calendar/calendar.dart';
import 'package:hem_routine_app/widgets/widgets.dart';

import '../utils/colors.dart';
import 'routine/routine.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = [
    Calendar(),
    RoutinePage(),
    Center(
      child: Text('Report'),
    ),
    Center(
      child: Text('Setting'),
    ),
  ];
  final _navigatorKeyList =
      List.generate(4, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_currentIndex]
            .currentState!
            .maybePop());
      },
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: _pages.map(
                (page) {
                  int index = _pages.indexOf(page);
                  return CustomNavigator(
                    page: page,
                    navigatorKey: _navigatorKeyList[index],
                  );
                },
              ).toList(),
            ),
          ),
          bottomNavigationBar: Container(
            color: Color.fromRGBO(238, 240, 255, 1),
            child: TabBar(
              isScrollable: false,
              indicatorColor: Colors.transparent,
              indicatorPadding: const EdgeInsets.only(bottom: 74),
              // automaticIndicatorColorAdjustment: true,
              labelColor: grey900,
              unselectedLabelColor: grey600,
              onTap: (index) => setState(() {
                _currentIndex = index;
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
      ),
    );
  }
}
