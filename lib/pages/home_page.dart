// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tbr_group_test/pages/widgets/choose_country_button.dart';
import 'package:tbr_group_test/pages/widgets/phone_input.dart';
import 'package:tbr_group_test/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 160),
                  Row(
                    children: [
                      ChooseCountryButton(),
                      SizedBox(width: 8),
                      PhoneInput(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 48,
          height: 48,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {},
              backgroundColor: AppColors.inputBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.arrow_forward_outlined,
                  color: AppColors.inputHintTextColor,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
