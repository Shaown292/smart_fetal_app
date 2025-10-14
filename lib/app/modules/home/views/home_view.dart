import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_fetal_app/app/widgets/custom_circular_animation.dart';
import 'package:smart_fetal_app/app/widgets/primary_button.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// Bluetooth Status
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
            SizedBox(height: 10),
            Container(
              height: 175,
              decoration: BoxDecoration(
                color: Color(0xFFFFD5D9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFF4A4C0), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff9d476e).withOpacity(0.25),
                    blurRadius: 90.8,
                    offset: Offset(0, 0),
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4B5563),
                        ),
                        children: [
                          const TextSpan(text: 'Monitor and\nadjust your '),
                          TextSpan(
                            text: 'Posture',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9D476E),
                            ),
                          ),
                          const TextSpan(
                            text:
                                '\nduring pregnancy\nfor your baby\'s\nwellbeing',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: 175,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD5D9),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/pregnant_woman.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            /// Tilt
            Obx(()=>  controller.triggerAnimation.value ?Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 130,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink.shade100, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color(0xFFD0D7E2), // soft gradient bottom
                        ],
                        // stops: [0.5, 1.0],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Horizontal lines with space in the middle
                          Text(
                              "Tilt°",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFF4B5563)
                              )
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                              "0°",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink.shade100, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color(0xFFD0D7E2), // soft gradient bottom
                        ],
                        // stops: [0.5, 1.0],
                      ),
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
                                  color: Color(0xFF4B5563)
                              )
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                              "0°",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFECECEC),
                      image: DecorationImage(
                        image: AssetImage("assets/images/i.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "This device provides posture guidance only. Consult healthcare professionals for persistent back pain or mobility concerns.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9D174D),
                      ),
                    ),
                  ),
                ],
              ),
            ),),
          Obx(()=>   controller.triggerAnimation.value ? SizedBox(height: 70) : SizedBox(),),
            /// Animation
            Obx(
              () => controller.triggerAnimation.value
                  ? CustomCircularAnimation(
                      ripple1: controller.ripple1,
                      ripple2: controller.ripple2,
                    )
                  : SizedBox(
                height: 50,
              )

              // Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Color(0xFF9D476E),
              //         ),
              //       ),
            ),
            Obx(()=>   controller.triggerAnimation.value ? SizedBox(height: 70) : SizedBox(),),
            /// Button
            Obx(
              () => controller.triggerAnimation.value
                  ? PrimaryButton(
                      title: "Check your position",
                      textStyle: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9D476E),
                      ),
                      borderColor: Color(0xFFF4A4C0),
                      color: Colors.white,
                      onTap: () {
                        controller.triggerAnimation.value = true;
                      },
                    )
                  : PrimaryButton(
                      title: "Get Started",
                      onTap: () {
                        controller.triggerAnimation.value = true;
                        Future.delayed(const Duration(seconds: 5), () {
                          Get.toNamed(Routes.CHECKING_POSITION);
                          controller.triggerAnimation.value = false;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
