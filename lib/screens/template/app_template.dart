import 'package:flutter/material.dart';
import 'package:monitor/screens/dashboard.dart';
import 'package:monitor/screens/monitoring/home.dart';
import 'package:monitor/screens/setting.dart';
import 'package:monitor/utils/colors.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({super.key});

  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {

  int _selectedIndex = 0;

  static const List<Widget> listPage = <Widget>[
    DashboardScreen(),
    HomeMonitoringScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: listPage.length > _selectedIndex ? listPage[_selectedIndex] : listPage[0],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorTheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
