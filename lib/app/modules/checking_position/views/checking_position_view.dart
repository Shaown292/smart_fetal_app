import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checking_position_controller.dart';

class CheckingPositionView extends GetView<CheckingPositionController> {
  const CheckingPositionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckingPositionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckingPositionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
