import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_circular_animation.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/checking_position_controller.dart';

class CheckingPositionView extends GetView<CheckingPositionController> {
  const CheckingPositionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/dp.png")),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B5563),
              ),
            ),
            Text(
              "Amelie",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9D476E),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFECECEC),
                image: DecorationImage(
                  image: AssetImage("assets/images/notification.png"),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Bluetooth Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Connected",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Last Packet",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "2s ago",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Obx(() => controller.updateChanges.value
                  ? Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF34D399), width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Posture",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF4CAF50)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFB4E3B9).withOpacity(0.5),
                        image: DecorationImage(
                          image: AssetImage("assets/images/green_bed.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    Text(
                      "Left-side",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    SizedBox(height: 17),
                    Text(
                      "Left side lying",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
                  : Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFF87171), width: 1),

                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Posture",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Color(0xFF9D476E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDC2626).withOpacity(0.25),
                        image: DecorationImage(
                          image: AssetImage("assets/images/red_bed.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                    Text(
                      "Supine",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    SizedBox(height: 17),
                    Text(
                      "Lying flat on back",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF8C8DC), width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF2FCFF),
                    ),
                    child: Column(
                      children: [
                        // Horizontal lines with space in the middle
                        Text(
                          "Tilt°",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "-4.3°",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 33),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF8C8DC), width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF2FCFF),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Horizontal lines with space in the middle
                          Text(
                            "Roll°",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "-0.1°",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
               Obx(() =>  Text(
                 controller.updateChanges.value?  "Good Posture" : "Need adjustment",
                 style: GoogleFonts.poppins(
                   fontWeight: FontWeight.w700,
                   fontSize: 20,
                   color:controller.updateChanges.value? Color(0xFF3C8B40):  Color(0xFFDC2626),
                 ),
               ),),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFFDE68A), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     controller.updateChanges.value ? "You’re in a healthy posture. Keep gently moving.": "Please avoid lying flat on your back. Roll to your LEFT side with a pillow behind your back.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:controller.updateChanges.value ?Color(0xFF4CAF50) : Color(0xFF92400E),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Suggestion:",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9D476E),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "1.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                        Text(
                         controller.updateChanges.value ? " Continue with Micro-movement": " Slowly turn to your left.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(height: 20),

              /// Animation
              Obx(
                () => controller.triggerAnimation.value
                    ? SizedBox(height: 70)
                    : SizedBox(),
              ),
              Obx(
                () => controller.triggerAnimation.value
                    ? CustomCircularAnimation(
                        ripple1: controller.ripple1,
                        ripple2: controller.ripple2,
                      )
                    : SizedBox(),
              ),
              Obx(
                () => controller.triggerAnimation.value
                    ? SizedBox(height: 70)
                    : SizedBox(),
              ),
              PrimaryButton(
                title: "Start Again",
                onTap: () {
                  controller.triggerAnimation.value = true;
                  Future.delayed(const Duration(seconds: 5), () {
                    controller.updateChanges.value = !controller.updateChanges.value;
                    controller.triggerAnimation.value = false;
                  });
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
