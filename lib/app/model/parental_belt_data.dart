import 'dart:convert';

class PrenatalBeltData {
  final int timestamp;
  final double heartRate;
  final double spo2;
  final double dieTemp;

  PrenatalBeltData({
    required this.timestamp,
    required this.heartRate,
    required this.spo2,
    required this.dieTemp,
  });

  factory PrenatalBeltData.fromJson(Map<String, dynamic> json) {
    return PrenatalBeltData(
      timestamp: json['timestamp'] ?? 0,
      heartRate: (json['biosignals']?['heart_rate_bpm'] ?? 0).toDouble(),
      spo2: (json['biosignals']?['spo2_pct'] ?? 0).toDouble(),
      dieTemp: (json['biosignals']?['die_temp_c'] ?? 0).toDouble(),
    );
  }

  static List<PrenatalBeltData> listFromJson(String jsonString) {
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => PrenatalBeltData.fromJson(e)).toList();
  }
}
