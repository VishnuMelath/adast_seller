import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          title: Text('Terms and Conditions', style: blackTextStyle),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TermsConditionsContent(),
          ),
        ),
      ),
    );
  }
}

class TermsConditionsContent extends StatelessWidget {
  const TermsConditionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Introduction',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome to Adast Sellers. By accessing or using our mobile application, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, you must not use our app.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Use of the App',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Adast Sellers is designed to allow fashion sellers to list their items and connect with potential buyers. You agree to use the app only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else’s use and enjoyment of the app.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Account Registration',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'When you create an account with us, you must provide accurate and complete information. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'User Content',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'You are responsible for any content you submit to the app, including listings, messages, and other communications. You agree not to submit any content that is unlawful, offensive, or infringes on the rights of others. We reserve the right to remove any content that violates these terms.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Payments',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Payments made through the app are processed by Razorpay. By making a payment, you agree to Razorpay’s terms and conditions. We are not responsible for any issues arising from payment processing.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Limitation of Liability',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'To the fullest extent permitted by law, Adast Sellers and its affiliates, directors, employees, and agents shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from (i) your use or inability to use the app; (ii) any unauthorized access to or use of our servers and/or any personal information stored therein; (iii) any interruption or cessation of transmission to or from the app.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Indemnification',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'You agree to indemnify and hold harmless Adast Sellers and its affiliates, directors, employees, and agents from and against any and all claims, damages, obligations, losses, liabilities, costs, or debt, and expenses (including but not limited to attorney’s fees) arising from (i) your use of and access to the app; (ii) your violation of any term of these terms and conditions; (iii) your violation of any third-party right, including without limitation any copyright, property, or privacy right.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Governing Law',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'These terms shall be governed and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions. Our failure to enforce any right or provision of these terms will not be considered a waiver of those rights. If any provision of these terms is held to be invalid or unenforceable by a court, the remaining provisions of these terms will remain in effect.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Changes to Terms and Conditions',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will try to provide at least 30 days’ notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Contact Us',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'If you have any questions about these terms and conditions, please contact us at',
          style: blackPlainTextStyle,
        ),
        GestureDetector(
          onTap: () async {
            final Uri params = Uri(
              scheme: 'mailto',
              path: 'vishnumeloth13@gmail.com',
              query:
                  'subject=Terms%20and%20Conditions%20Inquiry',
            );
            if (await canLaunchUrl(params)) {
              await launchUrl(params);
            } else {
              log('Could not launch $params');
            }
          },
          child: Text(
            'vishnumeloth13@gmail.com',
            style: urlTextStyle,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Remember to replace the placeholders with your specific information and consult with a legal professional to ensure compliance with applicable laws.',
          style: blackPlainTextStyle,
        ),
      ],
    );
  }
}
