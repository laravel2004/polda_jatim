import 'package:flutter/material.dart';
import 'package:monitor/models/general_model.dart';
import 'package:monitor/utils/constant.dart';
import 'package:monitor/utils/data_state.dart';
import 'package:monitor/view_models/general/general_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final GeneralService _generalService = GeneralService();
  DataState<List<GeneralModel>> _memoryStat = DataLoading();
  late String host;

  @override
  void initState() {
    super.initState();
    handleGetMemoryStat();
  }

  void handleGetMemoryStat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    host = prefs.getString('host') ?? '';
    setState(() {
      _memoryStat = DataLoading();
    });

    try {
      final result = await _generalService.getNetworkStat('memory');
      setState(() {
        _memoryStat = result;
      });
    } catch (e) {
      setState(() {
        _memoryStat = DataError(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_memoryStat is DataError) {
      return const Scaffold(
        body: Center(
          child: Text("Fetched data error"),
        ),
      );
    }

    if (_memoryStat is DataLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final data = (_memoryStat as DataSuccess<List<GeneralModel>>).data;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = data![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    '${BASE_IMAGE}/chart2.php?graphid=${item.graphId}',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
