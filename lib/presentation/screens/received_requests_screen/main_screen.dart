import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';

class ReceivedRequestsScreen extends StatefulWidget {
  const ReceivedRequestsScreen({super.key});

  @override
  State<ReceivedRequestsScreen> createState() => _ReceivedRequestsScreenState();
}

class _ReceivedRequestsScreenState extends State<ReceivedRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(title: "title", body: Column(children: []));
  }
}
