import 'package:eduscan_app/widgets/add_your_image.dart';
import 'package:eduscan_app/widgets/custom_row.dart';
import 'package:eduscan_app/widgets/list_tile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 25.sp, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            AddYourImage(),
            SizedBox(height: 8.h),
            Text(
              'Tap to change your photo',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20.h),

            CustomRow(title: 'Sign out', icon: Icons.exit_to_app),
            CustomRow(
              title: 'Theme',
              icon: Icons.brightness_6,
              onPressed: () {
                themeNotifier.value = !themeNotifier.value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
