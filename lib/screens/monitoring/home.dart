import 'package:flutter/material.dart';
import 'package:monitor/screens/monitoring/system.dart';
import 'package:monitor/screens/monitoring/cpu.dart';
import 'package:monitor/screens/monitoring/memory.dart';
import 'package:monitor/screens/monitoring/network.dart';
import 'package:monitor/screens/monitoring/storage.dart';

class HomeMonitoringScreen extends StatefulWidget {
  const HomeMonitoringScreen({super.key});

  @override
  State<HomeMonitoringScreen> createState() => _HomeMonitoringScreenState();
}

class _HomeMonitoringScreenState extends State<HomeMonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Monitoring'),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.computer), text: 'System'),
                  Tab(icon: Icon(Icons.memory_outlined), text: 'CPU'),
                  Tab(icon: Icon(Icons.sd_storage), text: 'Memory'),
                  Tab(icon: Icon(Icons.storage), text: 'Storage'),
                  Tab(icon: Icon(Icons.network_wifi), text: 'Network'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                SystemScreen(),
                CpuScreen(),
                MemoryScreen(),
                StorageScreen(),
                NetworkScreen(),
              ],
            )
        ),
    );
  }
}
