import 'package:flutter/material.dart';

Map<String, IconData> icons = {
  'Email Address': Icons.email,
  'Password': Icons.lock_open,
  'Name': Icons.person,
  'Shop Name': Icons.business_sharp,
  'Confirm Password': Icons.password,
  'Personal Details': Icons.person,
  'My Reservations': Icons.lock_clock,
  'Saved': Icons.bookmark,
  'Settings': Icons.settings,
  'Camera': Icons.camera,
  'Gallery': Icons.image,
  'Address':Icons.location_pin,
  'Dashboard':Icons.dashboard,
  'Inventory':Icons.inventory_sharp,
  'Reservations':Icons.book,
  'Inbox':Icons.message,
  'Revenue':Icons.attach_money,
};

Map<bool, Icon> eye = {
  true: const Icon(Icons.remove_red_eye_outlined),
  false: const Icon(Icons.remove_red_eye)
};

const String imagePath =
    'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/profileImages%2Fbusinessman.png?alt=media&token=ac058815-cb09-48a7-996f-1eaace09cdfe';
