import 'package:flutter/material.dart';

Map<String, IconData> icons = {
  'email address': Icons.email,
  'password': Icons.lock_open,
  'name': Icons.person,
  'shop name': Icons.business_sharp,
  'confirm password': Icons.password,
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
    'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/profileImages%2Fbusinessman.png?alt=media&token=1245ce78-22fa-43d1-b863-bad64a8dcab4';

List<String> options = [
       'Dashboard', 'Inventory', 'Reservations', 'Inbox', 'Revenue', 'Settings'
    ];