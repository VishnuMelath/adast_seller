import 'dart:developer';

import 'package:adast_seller/features/settings/UI/about.dart';
import 'package:adast_seller/features/settings/UI/widgets/customtile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ themes/colors_shemes.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';
import 'widgets/edit_profile.dart';
import 'widgets/logout_button.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              customListTile('Edit profile', () {
                editProfile(context);
              },),
              customListTile('Privacy policy', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => PrivacyPolicy(),));
              },),
              customListTile('Terms and Conditions', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const TermsConditionsPage(),));
              },),
              customListTile('Help', () async{
                 final Uri params = Uri(
              scheme: 'mailto',
              path: 'vishnumeloth13@gmail.com',
              query:
                  'subject=Adast%20Inquiry', 
            );
            if (await canLaunchUrl(params)) {
              await launchUrl(params);
            } else {
              log('Could not launch $params');
            }
              },),
              customListTile('About', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const About(),));
              },),

              logoutButton(context)
            ],
          ),
        ),
      ),
    );
  }
}