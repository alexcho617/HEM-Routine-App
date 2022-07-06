import 'package:flutter/material.dart';

enum TabItem { red, green, blue }

Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  final _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildOffstageNavigator(TabItem.red),
        _buildOffstageNavigator(TabItem.green),
        _buildOffstageNavigator(TabItem.blue),
      ]),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
  // Widget _buildBody() {
  //   return Container(
  //       color: activeTabColor[TabItem.red],
  //       alignment: Alignment.center,
  //       child: TextButton(
  //         child: Text(
  //           'PUSH',
  //           style: TextStyle(fontSize: 32.0, color: Colors.white),
  //         ),
  //         onPressed: _push,
  //       ));
  // }

  // void _push() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     // we'll look at ColorDetailPage later
  //     builder: (context) => ColorDetailPage(
  //       color: activeTabColor[TabItem.red],
  //       title: tabName[TabItem.red],
  //     ),
  //   ));
  // }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.green),
        _buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  MaterialColor? _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

// 2
class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  // 3
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            materialIndex: materialIndex,
          ),
    };
  }

  // 4
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          //왜 null?
          builder: (context) {
            if (routeSettings.name == '/detail') {
              return ColorDetailPage(
                color: activeTabColor[tabItem],
                title: tabName[tabItem],
                materialIndex: 500,
              );
            } else {
              return ColorsListPage(
                color: activeTabColor[tabItem],
                title: tabName[tabItem],
                onPush: (materialIndex) =>
                    _push(context, materialIndex: materialIndex),
              );
            }
          },
        );
      },
    );
  }

  // 5
  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (TabNavigatorRoutes.detail == '/detail') {
            return ColorDetailPage(
                color: activeTabColor[tabItem],
                title: tabName[tabItem],
                materialIndex: 500,
              );
          } else {
            return ColorsListPage(
              color: activeTabColor[tabItem],
              title: tabName[tabItem],
              onPush: (materialIndex) =>
                  _push(context, materialIndex: materialIndex),
            );
          }
        },
      ),
    );
  }
}

class ColorsListPage extends StatelessWidget {
  ColorsListPage(
      {required this.color, required this.title, required this.onPush});
  final MaterialColor? color;
  final String? title;
  final ValueChanged<int> onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
          ),
          backgroundColor: color,
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ));
  }

  final List<int> materialIndices = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];

  Widget _buildList() {
    return ListView.builder(
        itemCount: materialIndices.length,
        itemBuilder: (BuildContext content, int index) {
          int materialIndex = materialIndices[index];
          return Container(
            color: color![materialIndex],
            child: ListTile(
              title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
              trailing: Icon(Icons.chevron_right),
              onTap: () => onPush(materialIndex),
            ),
          );
        });
  }
}

class ColorDetailPage extends StatelessWidget {
  ColorDetailPage(
      {required this.color, required this.title, this.materialIndex: 500});
  final MaterialColor? color;
  final String? title;
  final int materialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          '$title[$materialIndex]',
        ),
      ),
      body: Container(
        color: color![materialIndex],
      ),
    );
  }
}
