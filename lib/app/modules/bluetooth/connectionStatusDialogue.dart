import 'package:flutter/material.dart';

class ConnectionStatusDialog extends StatelessWidget {
  final String title;
  final String message;
  final bool isConnected;

  const ConnectionStatusDialog({
    required this.title,
    required this.message,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Row(
        children: [
          Icon(
            isConnected ? Icons.check_circle : Icons.error,
            color: isConnected ? Colors.green : Colors.red,
          ),
          SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
