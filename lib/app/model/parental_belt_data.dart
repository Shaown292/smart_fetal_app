import 'dart:ui';

import 'package:flutter/material.dart';


/// Model for Prenatal Belt Sensor Data
class PrenatalBeltData {
  final double? tempMeanC;
  final String? positionState;
  final String? positionQuality;
  final int? heartRateBpm;
  final double? pitch;
  final double? roll;
  final double? yaw;
  final String? timestamp;

  PrenatalBeltData({
    this.tempMeanC,
    this.positionState,
    this.positionQuality,
    this.heartRateBpm,
    this.pitch,
    this.roll,
    this.yaw,
    this.timestamp,
  });

  factory PrenatalBeltData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PrenatalBeltData();

    return PrenatalBeltData(
      tempMeanC: (json['temp_mean_c'] as num?)?.toDouble(),
      positionState: json['position_state'] as String?,
      positionQuality: json['position_quality'] as String?,
      heartRateBpm: json['heart_rate_bpm'] as int?,
      pitch: (json['pitch'] as num?)?.toDouble(),
      roll: (json['roll'] as num?)?.toDouble(),
      yaw: (json['yaw'] as num?)?.toDouble(),
      timestamp: json['timestamp'] as String?,
    );
  }
}


class PositionStyle {
  /// The main background color for the container (e.g., card or panel)
  final Color containerColor;

  /// The border color that visually reinforces state importance
  final Color borderColor;

  /// The icon that represents the position (e.g., warning, checkmark)
  final String icon;

  /// Small dot indicator color (e.g., for quality signal or preferred state)
  final Color dotColor;

  /// Short status label, e.g. "Preferred", "Avoid", "Neutral"
  final String status;
  final Color statusColor;

  /// General message or short feedback about the position
  final String message;
  final Color messageColor;

  /// A rotation suggestion like “Tilt slightly left” or “Adjust head angle”
  final String rotationSuggestion;
  final String remarks;

  /// A specific suggestion for the patient (e.g., “Try sleeping on your left side”)
  final String suggestionsForPatient;

  PositionStyle({
    required this.statusColor,
    required this.messageColor,
    required this.remarks,
    required this.containerColor,
    required this.borderColor,
    required this.icon,
    required this.dotColor,
    required this.status,
    required this.message,
    required this.rotationSuggestion,
    required this.suggestionsForPatient,
  });
}

PositionStyle getStyleForPosition(String positionState) {
  switch (positionState) {
    case "left-side":
      return PositionStyle(
        statusColor: Color(0xFF4CAF50),
        remarks: "You're in a healthy posture",
        containerColor: Color(0xFFB4E3B9).withOpacity(0.25),
        borderColor: Color(0xFF34D399),
        icon: "assets/images/green_bed.png",
        dotColor: Color(0xFF4CAF50),
        status: "Left-side",
        message: "Good Posture",
        rotationSuggestion: "Left side lying",
        suggestionsForPatient:
            "Continue with micro-movements to maintain good circulations",
          messageColor: Color(0xFF3C8B40),
      );

    case "right-side":
      return PositionStyle(
        statusColor: Color(0xFFF59E0B),
        remarks: "Left-side or forward-leaning positions help your baby stay in an optimal position.”",
        messageColor: Color(0xFFF59E0B),
        containerColor: Color(0xFFFEF3C7),
        borderColor: Color(0xFFFBBF24),
        icon: "assets/images/yellow_bed.png",
        dotColor: Color(0xFFFBBF24).withOpacity(0.8),
        status: "Right-Side",
        message: "Try Rolling on your left side",
        rotationSuggestion: "Right Side",
        suggestionsForPatient:
            "1. Roll slowly to your left.\n2. Use a pillow for support.\n3. Keep your knees slightly bent.",
      );

    case "supine":
      return PositionStyle(
        statusColor: Color(0xFFDC2626),
        remarks: "Please avoid lying flat on your back. Roll to your LEFT side with a pillow behind your back.",
        messageColor: Color(0xFFDC2626),
        containerColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFF87171),
        icon: "assets/images/red_bed.png",
        dotColor: Color(0xFF9D476E),
        status: "Supine",
        message: "Need Adjustments",
        rotationSuggestion: "Lying flat on back",
        suggestionsForPatient:
            "1. Slowly turn to your left.\n2. Use a pillow between your knees. ",
      );

    default:
      return PositionStyle(
        statusColor: Color(0xFFDC2626),
        remarks: "Please avoid lying flat on your back. Roll to your LEFT side with a pillow behind your back.",
        messageColor: Color(0xFFDC2626),
        containerColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFF87171),
        icon: "assets/images/red_bed.png",
        dotColor: Color(0xFF9D476E),
        status: "Supine",
        message: "Need Adjustments",
        rotationSuggestion: "Lying flat on back",
        suggestionsForPatient:
            "1. Slowly turn to your left.\n2. Use a pillow between your knees. ",
      );
  }
}
