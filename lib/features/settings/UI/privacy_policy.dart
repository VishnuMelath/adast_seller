import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy for Adast Sellers'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy for Adast Sellers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              const Text(
                'Welcome to Adast Sellers! Your privacy is important to us. This application is intended for educational purposes only and is not for real use. The data collected is never used for any other purpose beyond the scope of this educational project. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. By using Adast, you agree to the terms of this Privacy Policy.',
              ),
              const SizedBox(height: 16),
              _sectionTitle('1. Information We Collect'),
              _listItem('Profile Photo: Used to personalize your profile within the app.'),
              _listItem('Name: Used to address you within the app.'),
              _listItem('Email Address: Used for account verification, notifications, and support.'),
              _listItem('Phone Number: Used for account verification and support.'),
              _listItem('Physical Address: Used for personalization and app functionality.'),
              _listItem('Location Data: Used to provide users with the location of the seller.'),
              _listItem('Fashion Item Details: Used to display items available in your shop. This includes:'),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    _listItem('Brand Name'),
                    _listItem('Category'),
                    _listItem('Description'),
                    _listItem('Fit'),
                    _listItem('Images'),
                    _listItem('Material'),
                    _listItem('Meta Description'),
                    _listItem('Meta Title'),
                    _listItem('Name'),
                    _listItem('Price'),
                    _listItem('Sizes and Their Counts'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _sectionTitle('2. How We Use Your Information'),
              _listItem('Personalization: To personalize your experience and provide tailored content.'),
              _listItem('Account Management: To manage your account and provide customer support.'),
              _listItem('Location Services: To provide users with the location of the seller.'),
              _listItem('In-App Chat: To facilitate communication between users and sellers.'),
              _listItem('Displaying Fashion Items: To showcase the fashion items available in your shop, including all relevant details such as brand name, category, and prices.'),
              const SizedBox(height: 16),
              _sectionTitle('3. Information Sharing and Disclosure'),
              const Text(
                'We do not share, sell, or distribute your personal information to any third parties. All information collected is used solely within Adast Sellers for the purposes mentioned above.',
              ),
              const SizedBox(height: 16),
              _sectionTitle('4. Data Security'),
              const Text(
                'We take the security of your personal information seriously and use industry-standard security measures to protect your data from unauthorized access, disclosure, alteration, and destruction.',
              ),
              const SizedBox(height: 8),
              _listItem('Encryption: We use encryption to protect your data during transmission and storage. All personal data, such as name, email, address, and location, is stored in Firebase after encryption.'),
              _listItem('Secure Storage: We store your data on secure servers provided by Firebase services, which comply with industry security standards.'),
              const SizedBox(height: 16),
              _sectionTitle('5. Your Rights'),
              _listItem('Access Your Information: Request a copy of the personal information we hold about you.'),
              _listItem('Update Your Information: Correct or update your personal information.'),
              _listItem('Delete Your Information: Request the deletion of your personal information.'),
              const SizedBox(height: 16),
              _sectionTitle('6. Changes to This Privacy Policy'),
              const Text(
                'We may update this Privacy Policy from time to time. If we make significant changes, we will notify you through the app or by other means before the changes take effect. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.',
              ),
              const SizedBox(height: 16),
              _sectionTitle('7. Contact Us'),
              const Text(
                'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:',
              ),
              const SizedBox(height: 8),
              const Text('Email: vishnumeloth13@gmail.com'),
              const Text('Phone: 9605391056'),
              const SizedBox(height: 16),
              const Text(
                'Effective Date: 13/08/2024',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'By using Adast Sellers, you acknowledge that you have read and understood this Privacy Policy and agree to its terms.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  static Widget _listItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '• $text',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
