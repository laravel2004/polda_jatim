import 'package:flutter/material.dart';
import 'package:monitor/widgets/chart_cpu.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Memory 4.00 GB',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ChartCpu(),
            ],
          ) ,
        ),
      ),
    );
  }
}
