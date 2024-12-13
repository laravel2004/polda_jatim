import 'package:flutter/material.dart';
import 'package:monitor/models/error_logs_model.dart';
import 'package:monitor/models/interface_model.dart';
import 'package:monitor/view_models/dashboard/dashboard_service.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardService _service = DashboardService();
  List<InterfaceModel> interfaces = [];
  List<ErrorLogsModel> errorLogs = [];
  bool _isLoading = true; // Tambahkan status loading

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedInterfaces = await _service.getInterfaces();
      final fetchedErrorLogs = await _service.getErrorLogs();

      setState(() {
        interfaces = fetchedInterfaces;
        errorLogs = fetchedErrorLogs;
        _isLoading = false; // Data berhasil dimuat, ubah status loading
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Tetap ubah status loading meskipun gagal
      });
    }
  }

  String _convertUnixToTime(String unixTime) {
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(unixTime) * 1000); // Konversi UNIX ke DateTime
      return DateFormat('HH:mm:ss, dd MMM yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid time';
    }
  }

  Widget _buildIpStatus() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: interfaces.length,
      itemBuilder: (context, index) {
        final ip = interfaces[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IP: ${ip.ip}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        Text("Available: ${ip.available}")
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 8),
                        Text("Errors: ${ip.error}")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorLogs() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: errorLogs.length,
      itemBuilder: (context, index) {
        final log = errorLogs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Time: ${_convertUnixToTime(log.clock)}"), // Konversi waktu
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: log.tags.map((tag) {
                    return Chip(
                      label: Text("${tag['tag']}: ${tag['value']}"),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Monitoring"),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(), // Tampilkan loading
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "IP Status",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildIpStatus(),
                const SizedBox(height: 16),
                const Text(
                  "Error Logs",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildErrorLogs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
