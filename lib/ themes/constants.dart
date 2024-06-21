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
  'Address': Icons.location_pin,
  'Dashboard': Icons.dashboard,
  'Inventory': Icons.inventory_sharp,
  'Reservations': Icons.book,
  'Inbox': Icons.message,
  'Revenue': Icons.attach_money,
  'Search':Icons.search
};

Map<bool, Icon> eye = {
  true: const Icon(Icons.remove_red_eye_outlined),
  false: const Icon(Icons.remove_red_eye)
};

const String imagePath =
    'https://firebasestorage.googleapis.com/v0/b/adast-425404.appspot.com/o/profileImages%2Fbusinessman.png?alt=media&token=1245ce78-22fa-43d1-b863-bad64a8dcab4';

List<String> drawerOptions = [
  'Dashboard',
  'Inventory',
  'Reservations',
  'Inbox',
  'Revenue',
  'Settings'
];

List<String> categoryOptios = [
  'Activewear',
  'Blouses',
  'Chino Pants',
  'Dresses',
  'Dress Pants',
  'Hoodies',
  'Jeans',
  'Joggers',
  'Jumpsuits',
  'Leggings',
  'Outerwear',
  'Polos',
  'Rompers',
  'Shirts',
  'Shorts',
  'Skirts',
  'Sleepwear',
  'Sweaters',
  'Tank Tops',
  'T-shirts'
  ,'Others'
];

List<String> fits=['regular','oversized','slimfit'];

List<String> sizes=['XS', 'S', 'M', 'L', 'XL','XXL'];